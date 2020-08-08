//
//  ProductDetailsViewModel.swift
//  EcommerceDemo
//
//  Created by devang bhavsar on 05/08/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit
import SBPickerSelector

class ProductDetailsViewModel: NSObject {
    var arrSelectionTitle = [String]()
    var arrSelectOption = [String]()
    var price:Int = 0
}

extension ProductDetailsViewController: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
           return objProductDetiailsViewModel.arrSelectionTitle.count
        } else {
             return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tblProductDetailsData.dequeueReusableCell(withIdentifier: "PickerTableViewCell") as! PickerTableViewCell
            cell.lblTitle.text = objProductDetiailsViewModel.arrSelectionTitle[indexPath.row]
            cell.lblDescription.text = objProductDetiailsViewModel.arrSelectOption[indexPath.row]
            cell.btnPicker.tag = indexPath.row
            cell.tagSelected = { [weak self] value in
                self!.setupPickerCall(tag: value)
            }
            cell.selectionStyle = .none
            return cell
            
        } else {
            let cell = tblProductDetailsData.dequeueReusableCell(withIdentifier: "LableTableViewCell") as! LableTableViewCell
            cell.lblTitle.text = "Price :"
            cell.lblDescription.text = "$" + "\(objProductDetiailsViewModel.price)"
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}
extension ProductDetailsViewController {
    func setupPickerCall(tag:Int) {
        switch tag {
        case 0:
            self.setUpPicker(arrPickerData: arrColors)
            break
        case 1:
        self.setUpSizePicker(arrPicker: arrSize)
            break
        default:
            break
        }
    }
    //MARK:- Picker View
    func setUpPicker(arrPickerData:[String])  {
        let newData = arrPickerData.removingDuplicates()
        SBPickerSwiftSelector(mode: SBPickerSwiftSelector.Mode.text, data: newData).cancel {
            print("cancel, will be autodismissed")
        }.set { values in
            if let values = values as? [String] {
                 self.objProductDetiailsViewModel.arrSelectOption[0] = values[0]
                
                if self.objProductDetiailsViewModel.arrSelectOption.count > 1 {
                    if  self.objProductDetiailsViewModel.arrSelectOption[0] != "please choose color" && self.objProductDetiailsViewModel.arrSelectOption[1] != "please choose size" {
                        
                        self.objProductDetiailsViewModel.price = self.getprice(color: values[0], size: Int( self.objProductDetiailsViewModel.arrSelectOption[1])!)
                        if self.objProductDetiailsViewModel.price == 0  {
                            DispatchQueue.main.async {
                                self.showAlert(message: "Product is out of stock")
                            }
                            
                            self.objProductDetiailsViewModel.arrSelectOption[0] = "please choose color"
                            self.objProductDetiailsViewModel.arrSelectOption[1] = "please choose size"
                            return
                        } else {
                            self.objProductDetiailsViewModel.arrSelectOption[0] = values[0]
                        }
                    }
                } else {
                    self.objProductDetiailsViewModel.price = self.getPriceOfColor(color: values[0])
                    if self.objProductDetiailsViewModel.price == 0  {
                        DispatchQueue.main.async {
                            self.showAlert(message: "Product is out of stock")
                        }
                    }
                }
                self.tblProductDetailsData.reloadData()
            }
            
        }.present(into: self)
    }
    
    func setUpSizePicker(arrPicker:[Int])  {
        let newData = arrPicker.removingDuplicates()
        var stringArray = newData.map{Optional(String($0)) }
        SBPickerSwiftSelector(mode: SBPickerSwiftSelector.Mode.text, data: stringArray).cancel {
            print("cancel, will be autodismissed")
        }.set { values in
            if let values = values as? [String] {
                
                let sizeValue = Int(values[0])
                 self.objProductDetiailsViewModel.arrSelectOption[1] = values[0]
                if self.objProductDetiailsViewModel.arrSelectOption[0] != "please choose color" && self.objProductDetiailsViewModel.arrSelectOption[1] != "please choose size" {
                    self.objProductDetiailsViewModel.price = self.getprice(color: self.objProductDetiailsViewModel.arrSelectOption[0], size: Int(values[0])!)
                    if self.objProductDetiailsViewModel.price == 0 {
                        self.objProductDetiailsViewModel.arrSelectOption[0] = "please choose color"
                          self.objProductDetiailsViewModel.arrSelectOption[1] = "please choose size"
                        DispatchQueue.main.async {
                            self.showAlert(message: "Product is out of stock")
                        }
                        
                    } else {
                        self.objProductDetiailsViewModel.arrSelectOption[1] = values[0]
                    }
                }
                
                self.tblProductDetailsData.reloadData()
            }
            
        }.present(into: self)
    }
    func getprice(color:String,size:Int) -> Int {
        var price:Int = 0
        let allData = self.objProducts?.variants?.filter{$0.color == color && $0.size == size}
        let selectedPrice = allData?.compactMap{$0.price}
        if selectedPrice != nil {
            if selectedPrice!.count > 0 {
                price = selectedPrice![0]
            }
        }
        return price
    }
    
    func getPriceOfColor(color:String) -> Int {
        var price:Int = 0
        let allData = self.objProducts?.variants?.filter{$0.color == color }
        let selectedPrice = allData?.compactMap{$0.price}
        if selectedPrice != nil {
            if selectedPrice!.count > 0 {
                price = selectedPrice![0]
            }
        }
        return price
    }
    
    func showAlert(message:String)  {
         Alert().showAlert(message: message, viewController: self)
    }
    
}
