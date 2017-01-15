//
//  SimpleResponse.swift
//  Libros
//
//  Created by Yoshihiro Tanaka on 2017/01/14.
//  Copyright © 2017年 Yoshihiro Tanaka. All rights reserved.
//

import Foundation
import Himotoki

struct SimpleResponse : Decodable {
    let status: Int
    
    static func decode(_ e: Extractor) throws -> SimpleResponse {
        return try SimpleResponse(
            status: e <| "status"
        )
    }
    
}
