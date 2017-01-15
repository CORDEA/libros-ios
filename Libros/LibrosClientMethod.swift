//
//  LibrosClientMethod.swift
//  Libros
//
//  Created by Yoshihiro Tanaka on 2017/01/14.
//  Copyright © 2017年 Yoshihiro Tanaka. All rights reserved.
//

import Foundation

protocol LibrosClientMethod {
    
    static func getBooks(onResponse: @escaping ((Books?) -> Swift.Void))
    
    static func searchBook(code: String, onResponse: @escaping ((BookResponse?) -> Swift.Void))
    
    static func patchBook(book: Book, onResponse: @escaping ((BookResponse?) -> Swift.Void))
    
    static func deleteBook(id: Int, onResponse: @escaping ((SimpleResponse?) -> Swift.Void))
    
    static func postBook(book: Book, onResponse: @escaping ((BookResponse?) -> Swift.Void))
    
}
