//
//  ViewController.swift
//  Gousto_app2
//
//  Created by Kriss Wiltshire on 19/01/2020.
//  Copyright © 2020 Kriss Wiltshire. All rights reserved.
//

import UIKit

var selectedIndex = 0
var detailProducts = [Products]()

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let url = URL(string: "https://api.gousto.co.uk/products/v2.0/products?&includes[]=attributes&image_sizes[]=750")
    var products = [Products]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                detailProducts = self.products
                self.navigationItem.title = "\(self.products.count) Products found"
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
       downloadJson()
    }

    // MARK: Retrieve all JSON data according to productDataModel
    func downloadJson(){
        guard let dataURL = url else {return}
        let dataTask = URLSession.shared.dataTask(with: dataURL) { data, _, _ in
            guard let jsonData = data else {
                print("No response from Gousto API")
                return
            }
            do {
                let decoder = JSONDecoder()
                let allProducts = try decoder.decode(AllProducts.self, from: jsonData)
                self.products = allProducts.data!
                detailProducts = allProducts.data!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch{
                print("Unable to decode JSON data: reason : \(error.localizedDescription)")
            }
        };dataTask.resume()
    }
    
    
    // MARK: Setup the table views
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "detailView", sender: self)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductTableViewCell else { return UITableViewCell() }
            let product = products[indexPath.row]
        cell.titleLabel.text = product.title
        cell.priceLabel.text = "£\(product.list_price ?? "")"
        cell.imageViewCell?.clipsToBounds = true
        return cell
    }
}

// MARK: Search setup
extension ViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String){
        guard let searchBarText = searchBar.text else {return}
        if ((searchBarText) == "") {
        let productSearch = ProductSearch(titleSearch: searchBarText)
        productSearch.getProducts {[weak self] result in
            switch result {
            case.failure(let error):
                print(error)
            case.success(let searchProducts):
                self!.products = searchProducts
            }
        }
    }
}

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {return}
        let productSearch = ProductSearch(titleSearch: searchBarText)
        productSearch.getProducts {[weak self] result in
            switch result {
            case.failure(let error):
                print(error)
            case.success(let searchProducts):
                self!.products = searchProducts
                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
                }
            }
        }
    }
}
