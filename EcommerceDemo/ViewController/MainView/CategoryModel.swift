//
//  CategoryModel.swift
//  EcommerceDemo
//
//  Created by devang bhavsar on 05/08/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import Foundation

struct CategoryModel:Decodable {
    let categories : [Categories]?
    let rankings : [Rankings]?

    enum CodingKeys: String, CodingKey {

        case categories = "categories"
        case rankings = "rankings"
    }
}
struct Categories : Decodable {
    let id : Int?
    let name : String?
    let products : [Products]?
    let child_categories : [Int]?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case products = "products"
        case child_categories = "child_categories"
    }
}
struct Products : Decodable {
    let id : Int?
    let view_count : Int?
    let name : String?
    let date_added : String?
    let order_count:Int?
    let shares : Int?
    let variants:[Variants]?
    let tax:Tax?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case view_count = "view_count"
        case name = "name"
        case date_added = "date_added"
        case variants = "variants"
        case tax = "tax"
        case order_count = "order_count"
        case shares = "shares"
    }
}
struct Rankings : Decodable {
    let ranking : String?
    let products : [Products]?
    
    enum CodingKeys: String, CodingKey {
        
        case ranking = "ranking"
        case products = "products"
    }
}
struct Tax : Decodable {
    let name : String?
    let value : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case value = "value"
    }
}
struct Variants : Decodable {
    let id : Int?
    let color : String?
    let size : Int?
    let price : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case color = "color"
        case size = "size"
        case price = "price"
    }
}
