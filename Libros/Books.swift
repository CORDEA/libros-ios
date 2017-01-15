//
//  Books.swift
//  Libros
//
//  Created by Yoshihiro Tanaka on 2017/01/14.
//  Copyright © 2017年 Yoshihiro Tanaka. All rights reserved.
//

import Foundation
import Himotoki

struct Books : Decodable {
    let status: Int
    let books: [Book]
    
    static func decode(_ e: Extractor) throws -> Books {
        return try Books(
            status: e <| "status",
            books: e <|| "books"
        )
    }
    
}
