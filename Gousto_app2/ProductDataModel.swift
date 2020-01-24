//
//  ProductDataModel.swift
//  Gousto_app2
//
//  Created by Kriss Wiltshire on 19/01/2020.
//  Copyright © 2020 Kriss Wiltshire. All rights reserved.
//

import Foundation

// MARK: Get all data from Gousto API JSON
 struct AllProducts: Codable {
    let data: [Products]?

    init(data: [Products]?) {
        self.data = data
    }
}

 struct Products: Codable {
    let title: String?
    let description: String?
    let list_price: String?
    let attributes: [Attributes]?
//    let images: [String:Image]?

    init(title: String, description: String, list_price: String, attributes: [Attributes]?) {
        self.title = title
        self.description = description
        self.list_price = list_price
        self.attributes = attributes
//        self.images = images
    }
}

 struct Attributes: Codable {
    let title: String?
    let unit: String?
    let value: String?

    init(title: String?, unit: String?, value: String?) {
        self.title = title
        self.unit = unit
        self.value = value
    }
}

//struct Image: Codable {
//    let src: String = ""
//}


/////////////////////////////////////////////////////////////////////////////////


// MARK: Original DataModel

// struct AllProducts: Codable {
//    let data: [Products]
//
//    enum CodingKeys: String, CodingKey {
//        case data = "data"
//    }
//}
//
// struct Products: Codable {
//    let title: String
//    let description: String
//    let list_price: String
//    let attributes: [Attributes]?
//    var images: [String:Image] = [:]
//
//    enum CodingKeys: String, CodingKey {
//        case title = "title"
//        case description = "description"
//        case list_price = "list_price"
//        case attributes = "attributes"
//        case images = "images"
//    }
//     init (from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        if let image = try values.decodeIfPresent([String:images].self, forKey: .images) {
//            images = [String:image]
//        } else {
//            images = [:]
//        }
//    }
//}
//
// struct Attributes: Codable {
//    let title: String
//    let unit: String
//    let value: String
//
//    enum CodingKeys: String, CodingKey {
//        case title = "data"
//        case unit = "unit"
//        case value = "value"
//    }
//}
//
// struct Image: Codable {
//    let src: String = ""
//    let url: String = ""
//    let width: Int = 0
//
//    enum CodingKeys: String, CodingKey {
//        case src = "src"
//        case url = "url"
//        case width = "width"
//    }
//}
