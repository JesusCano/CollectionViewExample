//
//  GridCollectionViewCell.swift
//  CollectionViewExample
//
//  Created by Jesus Jaime Cano Terrazas on 25/09/21.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    var product: ProductModel! {
        didSet {
            configureCell()
        }
    }
    
    private func configureCell() {
        if let firstImage = product.images.first {
            if let imageURL = URL(string: firstImage.path) {
                self.productImageView.af.setImage(withURL: imageURL, imageTransition: UIImageView.ImageTransition.crossDissolve(0.25))
            }
        }
        
        self.productNameLabel.text = product.data.name
    }
    
}
