//
//  Functions.swift
//  Simple List
//
//  Created by Chris Filiatrault on 10/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

import SwiftUI
import CoreData


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
      
      if items.count == 1 {
         newItem.position = 1
         print("Set position = 1")
      } else {
         print("Set position = items[0].position = \(items[0].wrappedName) / 2")
         newItem.position = items[0].position * 1.1
      }
      
      
      
      
   } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
   }
   
   do {
      try managedContext.save()
      print("saved successfully -- \(newItem.wrappedName)")
      //self.loadItems()
   } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
      
   }
}



// ===MARK OFF ITEM===
// Mark off the tick circle in a list as having been added to the users basket
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
   //fetchRequest.predicate = NSPredicate(format: "markedOff = %@", true)
   
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
   fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Item.position, ascending: false)]
   
   
   
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



func move(at offsets: IndexSet, to destination: Int) {

guard let appDelegate =
   UIApplication.shared.delegate as? AppDelegate else {
      return
}

let managedContext =
   appDelegate.persistentContainer.viewContext


let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Item")
fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Item.position, ascending: false)]


do {
   let items = try managedContext.fetch(fetchRequest) as! [Item]
   
   for offset in offsets {
      let movedItem = items[offset]
      
      // Item is moving to last position
      if destination == items.count {
         movedItem.position = items[destination - 1].position * 0.999999
      
      // Item is moving to first position
      } else if destination == 0 {
         movedItem.position = items[0].position * 1.0000001
      
      // Item is moving in between first and last positions
      } else {
         let priorItem: Item = items[destination - 1]
         let followingItem: Item = items[destination]
         movedItem.position = (priorItem.position + followingItem.position) / 2
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
      //let objectUpdate = fetchReturn[0] as! NSManagedObject
      //objectUpdate.setValue(itemNewValue, forKey: "name")
      
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


func saveItemNames() {
   
   guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
         return
   }
   
   let managedContext =
      appDelegate.persistentContainer.viewContext
   
   let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Item")
   fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Item.position, ascending: false)]
   
   do {
      let items = try managedContext.fetch(fetchRequest) as! [Item]
      

      for item in items {
         
      }
      //let objectUpdate = fetchReturn[0] as! NSManagedObject
      //objectUpdate.setValue(itemNewValue, forKey: "name")
      
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

//
//func checkIfItemExists(name: String) -> Bool {
//
//   var result = false
//
//   for item in itemsFromFetchRequest {
//      if item.name == newItem {
//         result = true
//         return result
//      }
//   }
//   return result
//}
//
//

