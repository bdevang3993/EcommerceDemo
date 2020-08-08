//
//  RankingDB+CoreDataProperties.swift
//  EcommerceDemo
//
//  Created by devang bhavsar on 08/08/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//
//

import Foundation
import CoreData


extension RankingDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RankingDB> {
        return NSFetchRequest<RankingDB>(entityName: "RankingDB")
    }

    @NSManaged public var shares: Int
    @NSManaged public var order_count: Int
    @NSManaged public var view_count: Int
    @NSManaged public var id: Int
    @NSManaged public var name: String?

}
