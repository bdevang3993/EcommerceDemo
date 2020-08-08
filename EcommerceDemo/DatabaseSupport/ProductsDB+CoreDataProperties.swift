//
//  ProductsDB+CoreDataProperties.swift
//  EcommerceDemo
//
//  Created by devang bhavsar on 08/08/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductsDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductsDB> {
        return NSFetchRequest<ProductsDB>(entityName: "ProductsDB")
    }

    @NSManaged public var taxName: String?
    @NSManaged public var variant_id: [Int]?
    @NSManaged public var date_added: String?
    @NSManaged public var name: String?
    @NSManaged public var id: Int

}
