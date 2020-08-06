//
//  ViewController.swift
//  EcommerceDemo
//
//  Created by devang bhavsar on 05/08/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblCategoryTitle: UILabel!
    @IBOutlet weak var searchData: UISearchBar!
    @IBOutlet weak var tblDisplay: UITableView!
    var objCategoryViewModel = CategoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureValues()
        
    }
    func configureValues() {
        self.tblDisplay.dataSource = self
        self.tblDisplay.delegate = self
        self.tblDisplay.tableFooterView = UIView()
        self.tblDisplay.separatorStyle = .none
        searchData.searchTextField.delegate = self
        searchData.delegate = self
        self.getCategoryData()
    }


}

