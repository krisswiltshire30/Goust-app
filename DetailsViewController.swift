//
//  DetailsViewController.swift
//  Gousto_app2
//
//  Created by Kriss Wiltshire on 20/01/2020.
//  Copyright © 2020 Kriss Wiltshire. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var descriptionView: UILabel!
    @IBOutlet weak var priceView: UILabel!
    @IBOutlet weak var allergyView: UILabel?
    @IBOutlet weak var attributeTwoView: UILabel?
    let placeHolderImage = UIImage(named: "placeholder")!
    final let url = URL(string: "https://api.gousto.co.uk/products/v2.0/products?&includes[]=attributes&image_sizes[]=750")
    
    //MARK: Load data into respective labels
    override func viewDidLoad() {
        super.viewDidLoad()
        titleView.text = detailProducts[selectedIndex].title
        descriptionView.text = detailProducts[selectedIndex].description
        priceView.text = "£\(detailProducts[selectedIndex].list_price ?? "0.00")"
        let attributes = detailProducts[selectedIndex].attributes

        if ((attributes?.count) != 0) {
            if ((attributes![0].title) == "Allegen"){
                allergyView?.text = "Allergy Info : \(attributes?[0].value ?? "N/A")"
            }
            if ((attributes?.count) == 2) {
                if (attributes![1].title != nil) {
                attributeTwoView?.text = "\(attributes?[1].value ?? "") \(attributes?[1].unit ?? "")"
                }
            }
        }
    }
}
