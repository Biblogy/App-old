// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(BooksResponse.self, from: jsonData)

import Foundation

// MARK: - BooksResponse
public struct BooksResponse: Codable {
    let start, welcomeNumFound, numFound: Int
    let docs: [BookItem]

    enum CodingKeys: String, CodingKey {
        case start
        case welcomeNumFound = "num_found"
        case numFound, docs
    }
}

// MARK: - Book
public struct BookItem: Codable, Identifiable {
    public let id: String
    public let titleSuggest: String?
    public let editionKey: [String]?
    public let coverI: Int?
    public let isbn: [String]?
    public let hasFulltext: Bool?
    public let text, authorName, seed: [String]?
    public let oclc: [String]?
    public let authorKey: [String]?
    public let subject: [String]?
    public let title: String?
    public let publishDate: [String]?
    public let type: String?
    public let ebookCountI: Int?
    public let publishPlace: [String]?
    public let editionCount: Int?
    public let lcc: [String]?
    public let publisher, language: [String]?
    public let lastModifiedI: Int?
    public let coverEditionKey: String?
    public let publishYear: [Int]?
    public let firstPublishYear: Int?
    public let idDnb: [String]?
    public let subtitle: String?
    public let place: [String]?
    public var pages: String? = ""
    public var numberOfPages: String?
    public var isCorrect: Bool?

    
    enum CodingKeys: String, CodingKey {
        case titleSuggest = "title_suggest"
        case id = "key"
        case editionKey = "edition_key"
        case coverI = "cover_i"
        case isbn
        case hasFulltext = "has_fulltext"
        case text
        case authorName = "author_name"
        case seed, oclc
        case authorKey = "author_key"
        case subject, title
        case publishDate = "publish_date"
        case type
        case ebookCountI = "ebook_count_i"
        case publishPlace = "publish_place"
        case editionCount = "edition_count"
        case lcc, publisher, language
        case lastModifiedI = "last_modified_i"
        case coverEditionKey = "cover_edition_key"
        case publishYear = "publish_year"
        case firstPublishYear = "first_publish_year"
        case idDnb = "id_dnb"
        case subtitle, place
        case pages
        case numberOfPages = "number_of_pages"
        case isCorrect
    }
}
