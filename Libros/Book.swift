//
//  Book.swift
//  Libros
//
//  Created by Yoshihiro Tanaka on 2017/01/14.
//  Copyright © 2017年 Yoshihiro Tanaka. All rights reserved.
//

import Foundation
import Himotoki
import Alamofire

struct Book: Decodable {
    let id: Int?
    let title: String
    let author: String?
    let publisher: String?
    let code: String
    
    static func decode(_ e: Extractor) throws -> Book {
        return try Book(
            id: e <|? "id",
            title: e <| "title",
            author: e <|? "author",
            publisher: e <|? "publisher",
            code: e <| "code"
        )
    }
    
    func toParameters() -> Parameters {
        return [
            "title": title,
            "author": author ?? "",
            "publisher": publisher ?? "",
            "code": code
        ]
    }
}
