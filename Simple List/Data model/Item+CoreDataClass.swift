//
//  Item+CoreDataClass.swift
//  Simple List
//
//  Created by Chris Filiatrault on 10/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftUI

@objc(Item)
public class Item: NSManagedObject {

}

//extension Item {
//   static func getItemsFetchRequest () -> NSFetchRequest<Item> {
//         
//      guard let appDelegate =
//         UIApplication.shared.delegate as? AppDelegate else {
//            
//      }
//
//      let managedContext =
//         appDelegate.persistentContainer.viewContext
//
//
//      let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Item")
//      fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Item.position, ascending: false)]
//
//
//      do {
//         let fetchReturn = try managedContext.fetch(fetchRequest)
//         
//         return fetchReturn
//            
//         } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//         }
//    
//      
//   }
//}






