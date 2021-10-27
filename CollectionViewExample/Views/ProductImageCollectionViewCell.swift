//
//  ProductImageCollectionViewCell.swift
//  CollectionViewExample
//
//  Created by Jesus Jaime Cano Terrazas on 25/09/21.
//

import UIKit
import AlamofireImage

class ProductImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var productImage: ProductImageModel! {
        didSet {
            configureCell()
        }
    }
    
    //MARK: - Private Methods
    
    private func configureCell() {
        if let imageURL = URL(string: productImage.path) {
            photoImageView.af.setImage(withURL: imageURL)
        }
    }
    
}
