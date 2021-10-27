//
//  ProductListViewController.swift
//  CollectionViewExample
//
//  Created by Jesus Jaime Cano Terrazas on 11/09/21.
//

import UIKit
import Alamofire

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource: [ProductModel] = []
    private var isGrid: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getProducts()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "PagerDetailViewController" {
            let pagerDetailViewController = segue.destination as! PagerDetailViewController
            pagerDetailViewController.dataSource = dataSource
            pagerDetailViewController.selectedIndex = sender as! Int
        }
    }
    
    
    // MARK: - User Interaction
    @IBAction func selectTypeOfViewSegmentalControl(_ sender: UISegmentedControl) {
        isGrid = sender.selectedSegmentIndex == 0 ? false : true
        self.collectionView.reloadData()
    }
    
    
    // MARK: - Private Methods
    
    private func getProducts() {
        AF.request(Constants.API.productsURL).validate().responseData { response in
            switch response.result {
            case .success(let value):
                print("JSON: \(value)")
                
                do {
                    let productsResponse = try JSONDecoder().decode(ProductsResponseModel.self, from: value)
                    print("Products: \(productsResponse.metadata.results.count)")
                    self.dataSource = productsResponse.metadata.results
                    self.collectionView.reloadData()
                } catch let error {
                    print("Decode Error: \(error.localizedDescription)")
                }
                
            case .failure(let error):
                print("Loading products error: \(error.localizedDescription)")
            }
        }
    }

}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension ProductListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isGrid {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCollectionViewCell", for: indexPath) as! GridCollectionViewCell
            cell.product = self.dataSource[indexPath.item]
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as! ListCollectionViewCell
        
        cell.product = self.dataSource[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PagerDetailViewController", sender: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = collectionView.frame.width
        
        if isGrid {
            let cellWidth = (screenWidth - 30) / 2
            let size = CGSize(width: cellWidth, height: cellWidth)
            
            return size
        }
        
        let cellwidth = screenWidth - 20
        let size = CGSize(width: cellwidth, height: 120)
        return size
    }
    
}
