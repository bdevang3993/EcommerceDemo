//
//  Categories+CoreDataProperties.swift
//  EcommerceDemo
//
//  Created by devang bhavsar on 08/08/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//
//

import Foundation
import CoreData


extension CategoriesDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoriesDB> {
        return NSFetchRequest<CategoriesDB>(entityName: "CategoriesDB")
    }

    @NSManaged public var childCategoryId: [Int]?
    @NSManaged public var id: Int
    @NSManaged public var name: String?
    @NSManaged public var productId: [Int]?

}
