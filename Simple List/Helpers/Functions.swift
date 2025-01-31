//
//  Functions.swift
//  Simple List
//
//  Created by Chris Filiatrault on 10/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

import SwiftUI
import CoreData

// ===ADD NEW ITEM===
func addNewItem(itemName: Binding<String>) {
   
   guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate
      else {
         return
   }
   
   let managedContext =
      appDelegate.persistentContainer.viewContext
   
   let entity = NSEntityDescription.entity(forEntityName: "Item", in: managedContext)!
   
   let newItem = Item(entity: entity, insertInto: managedContext)
   newItem.name = itemName.wrappedValue
   newItem.dateAdded = Date()
   newItem.markedOff = false
   newItem.id = UUID()
   
   let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Item")
   fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Item.position, ascending: false)]
   
   do {
      let fetchReturn = try managedContext.fetch(fetchRequest)
      let items = fetchReturn as! [Item]
      
      // If new item is the first, set position = 0
      if items.count == 1 {
         newItem.position = 0
         print("Set position = 0")
      }
      else {
         // If item is not the first in the list, set position to the value of the top item + 1
         print("Set position = items[0].position = \(items[0].wrappedName) + 1")
         newItem.position = items[0].position + 1
      }
      
   } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
   }
   
   do {
      try managedContext.save()
      print("saved successfully -- \(newItem.wrappedName)")
   } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
      
   }
}



func markOffItem(thisItem: Item) {
   
   guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
   }
   
   let managedContext = appDelegate.persistentContainer.viewContext
   
   thisItem.markedOff.toggle()
   
   do {
      try managedContext.save()
      print("Checked off successfully")
   } catch let error as NSError {
      print("Could not save checked off status. \(error), \(error.userInfo)")
   }
}



func deleteItems() {
   
   guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
         return
   }
   
   let managedContext =
      appDelegate.persistentContainer.viewContext
   
   let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Item")
   
   do {
      let fetchReturn = try managedContext.fetch(fetchRequest)
      let items = fetchReturn as! [Item]
      
      for item in items {
         if item.markedOff == true {
            managedContext.delete(item)
         }
      }
      
      do {
         try managedContext.save()
         print("deleted successfully")
      } catch let error as NSError {
         print("Could not delete. \(error), \(error.userInfo)")
      }
      
   } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
   }
}



func deleteSwipedItem(at offsets: IndexSet) {
   
   guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
         return
   }
   
   let managedContext =
      appDelegate.persistentContainer.viewContext
   
   let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Item")
   fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Item.position, ascending: true)]
   
   
   
   do {
      let fetchReturn = try managedContext.fetch(fetchRequest) as! [Item]
      
      for offset in offsets {
         let item = fetchReturn[offset]
         managedContext.delete(item)
      }
      
      do {
         try managedContext.save()
         print("deleted successfully")
      } catch let error as NSError {
         print("Could not delete. \(error), \(error.userInfo)")
      }
      
   } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
   }
}



func editName(thisItem: Item, itemNewName: String) {
   
   guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
         return
   }
   
   let managedContext =
      appDelegate.persistentContainer.viewContext
   
   let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Item")
   
   fetchRequest.predicate = NSPredicate(format: "id = %@", thisItem.id! as CVarArg)
   
   do {
      let returnedItems = try managedContext.fetch(fetchRequest) as! [Item]
      
      if returnedItems.count == 1 {
         let itemToEdit = returnedItems[0]
         print("Got \(returnedItems.count) items and the first is \(itemToEdit.wrappedName)")
         itemToEdit.name = itemNewName
         print("Changed name to \(itemNewName)")
      }
      
      do {
         try managedContext.save()
         print("updated successfully")
      } catch let error as NSError {
         print("Could not save. \(error), \(error.userInfo)")
      }
      
   } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
   }
}



func move(IndexSet: IndexSet, destination: Int) {

   guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
         return
   }

   let managedContext =
      appDelegate.persistentContainer.viewContext


   let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Item")
   fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Item.position, ascending: true)]


   do {
      let items = try managedContext.fetch(fetchRequest) as! [Item]

      let firstIndex = IndexSet.min()!
      let lastIndex = IndexSet.max()!

      let firstRowToReorder = (firstIndex < destination) ? firstIndex : destination
      let lastRowToReorder = (lastIndex > (destination-1)) ? lastIndex : (destination-1)

      if firstRowToReorder != lastRowToReorder {

           var newOrder = firstRowToReorder
           if newOrder < firstIndex {
               // Moving dragged items up, so re-order dragged items first

               // Re-order dragged items
            for index in IndexSet {
                   items[index].setValue(newOrder, forKey: "position")
                   newOrder = newOrder + 1
               }

               // Re-order non-dragged items
               for rowToMove in firstRowToReorder..<lastRowToReorder {
                  if !IndexSet.contains(rowToMove) {
                       items[rowToMove].setValue(newOrder, forKey: "position")
                       newOrder = newOrder + 1
                   }
               }
           } else {
               // Moving dragged items down, so re-order dragged items last

               // Re-order non-dragged items
               for rowToMove in firstRowToReorder...lastRowToReorder {
                  if !IndexSet.contains(rowToMove) {
                       items[rowToMove].setValue(newOrder, forKey: "position")
                       newOrder = newOrder + 1
                   }
               }

               // Re-order dragged items
            for index in IndexSet {
                   items[index].setValue(newOrder, forKey: "position")
                   newOrder = newOrder + 1
               }
           }
      }


      do {
         try managedContext.save()

      } catch let error as NSError {
         print("Could not delete. \(error), \(error.userInfo)")
      }

   } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
   }
}







// ==============================================================
// ====================== FOR TESTING ===========================
// ==============================================================


func resetMOC() {
   
   guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
         return
   }
   
   let managedContext =
      appDelegate.persistentContainer.viewContext
   
   let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Item")
   
   do {
      let fetchReturn = try managedContext.fetch(fetchRequest)
      let items = fetchReturn as! [Item]
      
      for item in items {
         managedContext.delete(item)
      }
      
      
      do {
         try managedContext.save()
         print("deleted successfully")
      } catch let error as NSError {
         print("Could not delete. \(error), \(error.userInfo)")
      }
      
   } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
   }
}
