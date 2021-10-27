//
//  ListCollectionViewCell.swift
//  CollectionViewExample
//
//  Created by Jesus Jaime Cano Terrazas on 25/09/21.
//

import UIKit
import AlamofireImage

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productBrandLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    var product: ProductModel! {
        didSet {
            configureCell()
        }
    }
    
    // MARK: - Private Methods
    
    private func configureCell() {
        
        if let firstImage = product.images.first {
            if let imageURL = URL(string: firstImage.path) {
                self.productImageView.af.setImage(withURL: imageURL, imageTransition: UIImageView.ImageTransition.crossDissolve(0.25))
            }
        }
        
        self.productNameLabel.text = product.data.name
        self.productBrandLabel.text = product.data.brand
        self.productPriceLabel.text = product.data.formattedPrice
    }
}
