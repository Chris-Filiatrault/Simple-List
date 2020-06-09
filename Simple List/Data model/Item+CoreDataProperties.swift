//
//  Item+CoreDataProperties.swift
//  Simple List
//
//  Created by Chris Filiatrault on 10/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var markedOff: Bool
    @NSManaged public var dateAdded: Date?
    @NSManaged public var position: Double
   
   public var wrappedName: String {
      name ?? "Unknown item"
   }
   
   
}
