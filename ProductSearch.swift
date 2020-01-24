//
//  productRequest.swift
//  Gousto_app2
//
//  Created by Kriss Wiltshire on 20/01/2020.
//  Copyright © 2020 Kriss Wiltshire. All rights reserved.
//

import Foundation

enum JsonDataError:Error {
    case noDataAvailable
    case cannotProcessData
}

struct ProductSearch {
    let resourceUrl:URL
    
    init(titleSearch: String) {
        let resourceString = "https://api.gousto.co.uk/products/v2.0/products?&includes[]=attributes&image_sizes[]=750&title=\(titleSearch)"
        guard let resourceUrl = URL(string: resourceString) else {fatalError()}
        
        self.resourceUrl = resourceUrl
    }
    
    func getProducts (completion: @escaping(Result<[Products], JsonDataError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceUrl) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let allProducts = try decoder.decode(AllProducts.self, from: jsonData)
                let products = allProducts.data
                completion(.success(products!))
            }catch{
                completion(.failure(.cannotProcessData))
            }
        };dataTask.resume()
    }
}
