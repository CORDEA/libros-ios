//
//  ViewController.swift
//  Libros
//
//  Created by Yoshihiro Tanaka on 2017/01/14.
//  Copyright © 2017年 Yoshihiro Tanaka. All rights reserved.
//

import UIKit
import PKHUD

class ViewController: UITableViewController {
    
    private var books: [Book] = []

    override func viewDidAppear(_ animated: Bool) {
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        LibrosClient.getBooks { [weak self] response in
            PKHUD.sharedHUD.hide()
            if let r = response {
                if r.status == 1 {
                    self?.books = r.books
                    self?.tableView.reloadData()
                    return
                }
            }
            self?.books = []
            self?.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let book = books[indexPath.row]
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.author
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRegister" {
            let controller = segue.destination as! RegisterViewController
            if let index = tableView.indexPathForSelectedRow?.row {
                controller.book = books[index]
            }
        }
    }
}

