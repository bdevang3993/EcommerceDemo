//
//  ProductViewModel.swift
//  EcommerceDemo
//
//  Created by devang bhavsar on 05/08/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit
import SBPickerSelector

class ProductViewModel: NSObject {
    var arrProducts = [Products]()
    var arrSearchProducts = [Products]()
    var arrSortBy = [String]()
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
        cell.selectionStyle = .none
        return cell
     }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objProductDetails = UIStoryboard(name: MainStoryBoard, bundle: nil).instantiateViewController(identifier: "ProductDetailsViewController") as! ProductDetailsViewController
        objProductDetails.objProducts = objProductViewModel.arrSearchProducts[indexPath.row]
        self.navigationController?.pushViewController(objProductDetails, animated: true)
        
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
extension ProductViewController {
    //MARK:- Picker View
    func setUpPicker(arrPickerData:[String])  {
        let newData = arrPickerData.removingDuplicates()
        SBPickerSwiftSelector(mode: SBPickerSwiftSelector.Mode.text, data: newData).cancel {
            print("cancel, will be autodismissed")
        }.set { values in
            if let values = values as? [String] {
                var selectedValue = values[0]
                self.sortByGivenValues(sortBy: selectedValue)
            }
            
        }.present(into: self)
    }
    
    func sortByGivenValues(sortBy:String) {
        
        if sortBy == "Most Viewed Products" {
            self.sortDataByMostViewed()
        } else if sortBy == "Most OrdeRed Products" {
            self.sortDataByOrderRect()
        } else {
            self.sortByShared()
        }
    }
    
    func sortDataByMostViewed() {
        let arrFilterProduct = objCategoryModel?.rankings![0]//objCategoryModel?.rankings?.filter{$0.ranking == sortBy}
        var arrnewFilterData = arrFilterProduct.flatMap{$0.products}
        arrnewFilterData?.sort(by: { (pro1, pro2) -> Bool in
            var value1:Int = 0
            var value2:Int = 0
            if pro1.view_count != nil {
                value1 = pro1.view_count!
            }
            if pro2.view_count != nil {
                value2 = pro2.view_count!
            }
            
            if value1 > value2 {
                return true
            }else {
                return false
            }
        })
        
        let arrAllIds = arrnewFilterData?.compactMap{$0.id}
        let sortArray = objProductViewModel.arrSearchProducts
        var sortedbyDate = [Products]()
        
        for i in 0...arrAllIds!.count - 1 {
            for product in sortArray {
                if product.id == arrAllIds![i] {
                    sortedbyDate.append(product)
                    break
                }
            }
        }
         objProductViewModel.arrSearchProducts = sortedbyDate
        self.tblProductDisplay.reloadData()

    }
    
    func sortDataByOrderRect() {
           let arrFilterProduct = objCategoryModel?.rankings![1]//objCategoryModel?.rankings?.filter{$0.ranking == sortBy}
           var arrnewFilterData = arrFilterProduct.flatMap{$0.products}
             let newData = arrnewFilterData?.sort(by: { (pro1, pro2) -> Bool in
               var value1:Int = 0
               var value2:Int = 0
               if pro1.order_count != nil {
                   value1 = pro1.order_count!
               }
               if pro2.order_count != nil {
                   value2 = pro2.order_count!
               }
               
               if value1 > value2 {
                   return true
               }else {
                   return false
               }
           })
           
           let arrAllIds = arrnewFilterData?.compactMap{$0.id}
           let sortArray = objProductViewModel.arrSearchProducts
           var sortedbyDate = [Products]()
           
           for i in 0...arrAllIds!.count - 1 {
               for product in sortArray {
                   if product.id == arrAllIds![i] {
                       sortedbyDate.append(product)
                       break
                   }
               }
           }
            objProductViewModel.arrSearchProducts = sortedbyDate
           self.tblProductDisplay.reloadData()

       }
    
    func sortByShared() {
        let arrFilterProduct = objCategoryModel?.rankings![2]//objCategoryModel?.rankings?.filter{$0.ranking == sortBy}
        var arrnewFilterData = arrFilterProduct.flatMap{$0.products}
        let newData = arrnewFilterData?.sort(by: { (pro1, pro2) -> Bool in
            var value1:Int = 0
            var value2:Int = 0
            if pro1.shares != nil {
                value1 = pro1.shares!
            }
            if pro2.shares != nil {
                value2 = pro2.shares!
            }
            
            if value1 > value2 {
                return true
            }else {
                return false
            }
        })
        
        let arrAllIds = arrnewFilterData?.compactMap{$0.id}
        let sortArray = objProductViewModel.arrSearchProducts
        var sortedbyDate = [Products]()
        
        for i in 0...arrAllIds!.count - 1 {
            for product in sortArray {
                if product.id == arrAllIds![i] {
                    sortedbyDate.append(product)
                    break
                }
            }
        }
        objProductViewModel.arrSearchProducts = sortedbyDate
        self.tblProductDisplay.reloadData()
        
    }
}
