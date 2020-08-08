//
//  VariantDB+CoreDataProperties.swift
//  EcommerceDemo
//
//  Created by devang bhavsar on 08/08/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//
//

import Foundation
import CoreData


extension VariantDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VariantDB> {
        return NSFetchRequest<VariantDB>(entityName: "VariantDB")
    }

    @NSManaged public var price: Int
    @NSManaged public var size: Int
    @NSManaged public var color: String?
    @NSManaged public var id: Int

}
