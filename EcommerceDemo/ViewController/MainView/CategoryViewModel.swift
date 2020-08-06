//
//  CategoryViewModel.swift
//  EcommerceDemo
//
//  Created by devang bhavsar on 05/08/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit

class CategoryViewModel: NSObject {
  var apisuccessMessage:TAAPISuccess?
  var apiFailedMessage:TAAPIFailed?
  var arrMainData = [Categories]()
  var arrSearchData = [Categories]()
    //MARK:- API request Registration
    func getAllData(){
        do
        {
            let getInfo = baseURL//baseURL + signupAPI
            DispatchQueue.global(qos: .userInitiated).sync {
                APIRequest.shared.getAPIRequest(serviceName: getInfo, completionBlockSuccess: { (cm:CategoryModel) in
                    self.arrMainData = cm.categories!
                    self.arrSearchData = self.arrMainData
                    self.apisuccessMessage!(ksuccess)
                }) { (value) in
                    self.apiFailedMessage!(value as! String)
                }
            }
            
        }
}


}
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objCategoryViewModel.arrSearchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblDisplay.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as! CategoryTableViewCell
        cell.lblCompanyName.text = objCategoryViewModel.arrSearchData[indexPath.row].name
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objProduct = UIStoryboard(name: MainStoryBoard, bundle: nil).instantiateViewController(identifier:  "ProductViewController") as! ProductViewController
        objProduct.objCategory = objCategoryViewModel.arrSearchData[indexPath.row]
        self.navigationController?.pushViewController(objProduct, animated: true)
    }
}


extension ViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            
            objCategoryViewModel.arrSearchData = objCategoryViewModel.arrMainData.filter{($0.name?.lowercased().contains(searchText.lowercased()))! }
            
            tblDisplay.reloadData()
        }
        else if searchText == "" {
            objCategoryViewModel.arrSearchData = objCategoryViewModel.arrMainData
             tblDisplay.reloadData()
            searchBar.searchTextField.resignFirstResponder()
            searchBar.endEditing(true)
        }
        else {
              objCategoryViewModel.arrSearchData = objCategoryViewModel.arrMainData
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       objCategoryViewModel.arrSearchData = objCategoryViewModel.arrMainData
        tblDisplay.reloadData()
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
extension ViewController:UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        self.searchData.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
         self.searchData.endEditing(true)
        return true
    }
}
extension ViewController {
    func getCategoryData() {
        objCategoryViewModel.apiFailedMessage = {[weak self] value in
            removeProgressHub()
            Alert().showAlert(message: value, viewController: self!)
        }
        objCategoryViewModel.apisuccessMessage = {[weak self] value in
            removeProgressHub()
            if ksuccess == value {
                self?.tblDisplay.reloadData()
            }
        }
        setProgressHub(view: self.view)
        objCategoryViewModel.getAllData()
    }
}
