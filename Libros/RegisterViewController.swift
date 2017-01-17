//
//  RegisterViewController.swift
//  Libros
//
//  Created by Yoshihiro Tanaka on 2017/01/14.
//  Copyright © 2017年 Yoshihiro Tanaka. All rights reserved.
//

import UIKit
import PKHUD

class RegisterViewController: UIViewController, ReaderViewControllerDelegate {
    
    var book: Book? = nil
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var isbnTextField: UITextField!
    
    @IBOutlet weak var authorTextField: UITextField!
    
    @IBOutlet weak var publisherTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let it = book {
            titleTextField.text = it.title
            isbnTextField.text = it.code
            authorTextField.text = it.author
            publisherTextField.text = it.publisher
        }
    }
    
    @IBAction func onScan(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "reader") as! ReaderViewController
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func onReadCompleted(_ code: String) {
        isbnTextField.text = code
        search(code: code)
    }
    
    @IBAction func onRegister(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, let code = isbnTextField.text else {
            // error
            return
        }
        let book = Book(
            id: nil,
            title: title,
            author: authorTextField.text,
            publisher: publisherTextField.text,
            code: code
        )
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        if let _ = self.book {
            LibrosClient.patchBook(book: book) { [weak self] response in
                self?.onResponse(response)
            }
            return
        }
        LibrosClient.postBook(book: book) { [weak self] response in
            self?.onResponse(response)
        }
    }
    
    private func onResponse(_ response: BookResponse?) {
        PKHUD.sharedHUD.hide()
        if let r = response {
            if r.status == 1 {
                HUD.flash(.success, delay: 0.5) { _ in
                    _ = self.navigationController?.popViewController(animated: true)
                }
                return
            }
        }
        HUD.flash(.error, delay: 0.5)
    }
    
    @IBAction func onSearch(_ sender: UIButton) {
        if let code = isbnTextField.text {
            search(code: code)
        }
    }
    
    private func search(code: String) {
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        LibrosClient.searchBook(code: code) { [weak self] response in
            PKHUD.sharedHUD.hide()
            if let r = response {
                if r.status == 0 {
                    return
                }
                self?.isbnTextField.text = r.book.code
                self?.titleTextField.text = r.book.title
                self?.authorTextField.text = r.book.author
                self?.publisherTextField.text = r.book.publisher
                return
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
