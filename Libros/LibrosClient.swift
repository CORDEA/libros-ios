//
//  LibrosClient.swift
//  Libros
//
//  Created by Yoshihiro Tanaka on 2017/01/14.
//  Copyright © 2017年 Yoshihiro Tanaka. All rights reserved.
//

import Foundation
import Alamofire
import Himotoki

class LibrosClient : LibrosClientMethod {
    
    private static let baseUrl = "http://localhost:8080"
    
    static func getBooks(onResponse: @escaping ((Books?) -> Void)) {
        return sendRequest(
            "/books", .get,
            onResponse: onResponse)
    }
    
    static func searchBook(code: String, onResponse: @escaping ((BookResponse?) -> Void)) {
        return sendRequest(
            "/search/book", .get,
            onResponse: onResponse,
            parameters: ["code": code])
    }
    
    static func patchBook(book: Book, onResponse: @escaping ((BookResponse?) -> Void)) {
        return sendRequest(
            "/book", .patch,
            onResponse: onResponse,
            parameters: book.toParameters(),
            encoding: JSONEncoding.default)
    }
    
    static func deleteBook(id: Int, onResponse: @escaping ((SimpleResponse?) -> Void)) {
        return sendRequest(
            String(format: "/book/%d", arguments: [id]), .delete,
            onResponse: onResponse)
    }
    
    static func postBook(book: Book, onResponse: @escaping ((BookResponse?) -> Void)) {
        return sendRequest(
            "/book", .post,
            onResponse: onResponse,
            parameters: book.toParameters(),
            encoding: JSONEncoding.default)
    }

    private static func sendRequest<T: Decodable>(
        _ path: String,
        _ method: HTTPMethod,
        onResponse: @escaping ((T?) -> Swift.Void),
        parameters: Parameters = [:],
        encoding: ParameterEncoding = URLEncoding.default) {
        let url = baseUrl + path
        onResponse(nil)
        Alamofire
            .request(url,
                     method: method,
                     parameters: parameters,
                     encoding: encoding
            )
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    onResponse(try? T.decodeValue(data))
                case .failure:
                    onResponse(nil)
                }
        }
    }
}
