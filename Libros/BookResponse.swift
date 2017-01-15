//
//  BookResponse.swift
//  Libros
//
//  Created by Yoshihiro Tanaka on 2017/01/14.
//  Copyright © 2017年 Yoshihiro Tanaka. All rights reserved.
//

import Foundation
import Himotoki

struct BookResponse : Decodable {
    let status: Int
    let book: Book
    
    static func decode(_ e: Extractor) throws -> BookResponse {
        return try BookResponse(
            status: e <| "status",
            book: e <| "book"
        )
    }
}
