//
//  PagerDetailViewController.swift
//  CollectionViewExample
//
//  Created by Jesus Jaime Cano Terrazas on 25/09/21.
//

import UIKit

class PagerDetailViewController: UIViewController {
    
    private var pageViewController: UIPageViewController!
    
    var dataSource: [ProductModel] = []
    var selectedIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        pageViewController = storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        pageViewController.dataSource = self
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        let firstViewController = createViewControllerAt(index: selectedIndex)
        pageViewController.setViewControllers([firstViewController], direction: .forward, animated: false, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Private Methods
    
    private func createViewControllerAt(index: Int) -> UIViewController{
        let productDetailViewController = storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        productDetailViewController.product = dataSource[index]
        productDetailViewController.pageIndex = index
        
        return productDetailViewController
    }

}

// MARK: UIPageViewControllerDataSource


extension PagerDetailViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let currentProductDetailController = viewController as? ProductDetailViewController {
            let currentIndex = currentProductDetailController.pageIndex
            
            if currentIndex == dataSource.count - 1 {
                return nil
            }
            
            let productDetailViewController = createViewControllerAt(index: currentIndex  + 1)
            return productDetailViewController
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let currentProductDetailController = viewController as? ProductDetailViewController {
            let currentIndex = currentProductDetailController.pageIndex
            
            if currentIndex == 0 {
                return nil
            }
            
            let productDetailViewController = createViewControllerAt(index: currentIndex - 1)
            return productDetailViewController
        }
        
        return nil
    }
    
}
