//
//  TaxDB+CoreDataProperties.swift
//  EcommerceDemo
//
//  Created by devang bhavsar on 08/08/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//
//

import Foundation
import CoreData


extension TaxDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaxDB> {
        return NSFetchRequest<TaxDB>(entityName: "TaxDB")
    }

    @NSManaged public var value: Double
    @NSManaged public var name: String?

}
