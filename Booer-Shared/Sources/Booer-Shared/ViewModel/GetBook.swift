//
//  GetBook.swift
//  EBookTracking
//
//  Created by Veit Progl on 30.11.20.
//

import Foundation
import Combine
import Alamofire

final public class OpenLibary {
    static public let shared = OpenLibary()
    public init() {}
    
    public func getBooks(bookTitle: String, completion: @escaping (Result<[BookItem], Error>) -> Void) {
        if bookTitle != "" || !bookTitle.isEmpty || bookTitle != "" {
            print("=====")
            let url = "https://openlibrary.org/search.json?q=\(bookTitle.replacingOccurrences(of: " ", with: "+"))&mode=everything"
    //        print(url)
            
            AF.request(url, method: .get)
                .validate()
                .responseDecodable(of: BooksResponse.self) { (response) in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value.docs))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    }
}
