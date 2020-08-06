//
//  ProductViewModel.swift
//  EcommerceDemo
//
//  Created by devang bhavsar on 05/08/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit

class ProductViewModel: NSObject {
    var arrProducts = [Products]()
    var arrSearchProducts = [Products]()
}
extension ProductViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objProductViewModel.arrSearchProducts.count//(objCategory?.products!.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblProductDisplay.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as! ProductTableViewCell
        let objProductData = objProductViewModel.arrSearchProducts[indexPath.row]//objCategory?.products![indexPath.row]
        if let name = objProductData.name {
             cell.lblProductName.text = name
        }
        return cell
     }
    
}
extension ProductViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            
            objProductViewModel.arrSearchProducts = objProductViewModel.arrProducts.filter{($0.name?.lowercased().contains(searchText.lowercased()))! }
            
            tblProductDisplay.reloadData()
        }
        else if searchText == "" {
            objProductViewModel.arrSearchProducts = objProductViewModel.arrProducts
             tblProductDisplay.reloadData()
            searchBar.searchTextField.resignFirstResponder()
            searchBar.endEditing(true)
        }
        else {
              objProductViewModel.arrSearchProducts = objProductViewModel.arrProducts
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       objProductViewModel.arrSearchProducts = objProductViewModel.arrProducts
        tblProductDisplay.reloadData()
       searchBar.searchTextField.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         searchBar.endEditing(true)
        searchBar.searchTextField.resignFirstResponder()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
         searchBar.searchTextField.resignFirstResponder()
    }
   
}
extension ProductViewController:UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        self.searchView.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
         self.searchView.endEditing(true)
        return true
    }
}
