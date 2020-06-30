//
//  move.swift
//  Simple List
//
//  Created by Chris Filiatrault on 30/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

import SwiftUI
import CoreData


// ==================================================================
// ====================== STARTING POINT ============================
// ==================================================================




// ==================================================================
// ==================================================================
// ==================================================================



//
//
//func move(IndexSet: IndexSet, destination: Int) {
//
//   guard let appDelegate =
//      UIApplication.shared.delegate as? AppDelegate else {
//         return
//   }
//
//   let managedContext =
//      appDelegate.persistentContainer.viewContext
//
//
//   let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Item")
//   fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Item.position, ascending: false)]
//
//
//   do {
//      let items = try managedContext.fetch(fetchRequest) as! [Item]
//
//      let firstIndex = IndexSet.min()!
//      let lastIndex = IndexSet.max()!
//
//      let firstRowToReorder = (firstIndex < destination) ? firstIndex : destination
//      let lastRowToReorder = (lastIndex > (destination-1)) ? lastIndex : (destination-1)
//
//      if firstRowToReorder != lastRowToReorder {
//
//           var newOrder = firstRowToReorder
//           if newOrder < firstIndex {
//               // Moving dragged items up, so re-order dragged items first
//
//               // Re-order dragged items
//            for index in IndexSet {
//               items.reversed()[index].setValue(newOrder, forKey: "position")
//                   newOrder = newOrder + 1
//               }
//
//               // Re-order non-dragged items
//               for rowToMove in firstRowToReorder..<lastRowToReorder {
//                  if !IndexSet.contains(rowToMove) {
//                     items.reversed()[rowToMove].setValue(newOrder, forKey: "position")
//                       newOrder = newOrder + 1
//                   }
//               }
//           } else {
//               // Moving dragged items down, so re-order dragged items last
//
//               // Re-order non-dragged items
//               for rowToMove in firstRowToReorder...lastRowToReorder {
//                  if !IndexSet.contains(rowToMove) {
//                     items.reversed()[rowToMove].setValue(newOrder, forKey: "position")
//                       newOrder = newOrder + 1
//                   }
//               }
//
//               // Re-order dragged items
//            for index in IndexSet {
//               items.reversed()[index].setValue(newOrder, forKey: "position")
//                   newOrder = newOrder + 1
//               }
//           }
//      }
//
//
//      do {
//         try managedContext.save()
//
//      } catch let error as NSError {
//         print("Could not delete. \(error), \(error.userInfo)")
//      }
//
//   } catch let error as NSError {
//      print("Could not fetch. \(error), \(error.userInfo)")
//   }
//}
//
//
//







//func move(IndexSet: IndexSet, destination: Int) {
//
//   guard let appDelegate =
//      UIApplication.shared.delegate as? AppDelegate else {
//         return
//   }
//
//   let managedContext =
//      appDelegate.persistentContainer.viewContext
//
//
//   let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Item")
//   fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Item.position, ascending: true)]
//
//
//   do {
//      let items = try managedContext.fetch(fetchRequest) as! [Item]
//
//      let firstIndex = IndexSet.min()!
//      let lastIndex = IndexSet.max()!
//
//      let firstRowToReorder = (firstIndex < destination) ? firstIndex : destination
//      let lastRowToReorder = (lastIndex > (destination-1)) ? lastIndex : (destination-1)
//
//      if firstRowToReorder != lastRowToReorder {
//
//           var newOrder = firstRowToReorder
//           if newOrder < firstIndex {
//               // Moving dragged items up, so re-order dragged items first
//
//               // Re-order dragged items
//            for index in IndexSet {
//                   items[index].setValue(newOrder, forKey: "position")
//                   newOrder = newOrder + 1
//               }
//
//               // Re-order non-dragged items
//               for rowToMove in firstRowToReorder..<lastRowToReorder {
//                  if !IndexSet.contains(rowToMove) {
//                       items[rowToMove].setValue(newOrder, forKey: "position")
//                       newOrder = newOrder + 1
//                   }
//               }
//           } else {
//               // Moving dragged items down, so re-order dragged items last
//
//               // Re-order non-dragged items
//               for rowToMove in firstRowToReorder...lastRowToReorder {
//                  if !IndexSet.contains(rowToMove) {
//                       items[rowToMove].setValue(newOrder, forKey: "position")
//                       newOrder = newOrder + 1
//                   }
//               }
//
//               // Re-order dragged items
//            for index in IndexSet {
//                   items[index].setValue(newOrder, forKey: "position")
//                   newOrder = newOrder + 1
//               }
//           }
//      }
//
//
//      do {
//         try managedContext.save()
//
//      } catch let error as NSError {
//         print("Could not delete. \(error), \(error.userInfo)")
//      }
//
//   } catch let error as NSError {
//      print("Could not fetch. \(error), \(error.userInfo)")
//   }
//}




// reversed
//func move(IndexSet: IndexSet, destination: Int) {
//
//   guard let appDelegate =
//      UIApplication.shared.delegate as? AppDelegate else {
//         return
//   }
//
//   let managedContext =
//      appDelegate.persistentContainer.viewContext
//
//
//   let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Item")
//   fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Item.position, ascending: true)]
//
//
//   do {
//      let items = try managedContext.fetch(fetchRequest) as! [Item]
//
//      let firstIndex = IndexSet.reversed().min()!
//      let lastIndex = IndexSet.reversed().max()!
//
//      let firstRowToReorder = (firstIndex < destination) ? firstIndex : destination
//      let lastRowToReorder = (lastIndex > (destination-1)) ? lastIndex : (destination-1)
//
//      if firstRowToReorder != lastRowToReorder {
//
//           var newOrder = firstRowToReorder
//           if newOrder < firstIndex {
//               // Moving dragged items up, so re-order dragged items first
//
//               // Re-order dragged items
//            for index in IndexSet.reversed() {
//                   items[index].setValue(newOrder, forKey: "position")
//                   newOrder = newOrder + 1
//               }
//
//               // Re-order non-dragged items
//               for rowToMove in firstRowToReorder..<lastRowToReorder {
//                  if !IndexSet.reversed().contains(rowToMove) {
//                       items[rowToMove].setValue(newOrder, forKey: "position")
//                       newOrder = newOrder + 1
//                   }
//               }
//           } else {
//               // Moving dragged items down, so re-order dragged items last
//
//               // Re-order non-dragged items
//               for rowToMove in firstRowToReorder...lastRowToReorder {
//                  if !IndexSet.reversed().contains(rowToMove) {
//                       items[rowToMove].setValue(newOrder, forKey: "position")
//                       newOrder = newOrder + 1
//                   }
//               }
//
//               // Re-order dragged items
//            for index in IndexSet.reversed() {
//                   items[index].setValue(newOrder, forKey: "position")
//                   newOrder = newOrder + 1
//               }
//           }
//      }
//
//
//      do {
//         try managedContext.save()
//
//      } catch let error as NSError {
//         print("Could not delete. \(error), \(error.userInfo)")
//      }
//
//   } catch let error as NSError {
//      print("Could not fetch. \(error), \(error.userInfo)")
//   }
//}








// Tried to set my own firstIndex and lastIndex, but I think I need to work with the IndexSet

//
//func move(IndexSet: IndexSet, destination: Int) {
//
//   guard let appDelegate =
//      UIApplication.shared.delegate as? AppDelegate else {
//         return
//   }
//
//   let managedContext =
//      appDelegate.persistentContainer.viewContext
//
//
//   let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Item")
//   fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Item.position, ascending: false)]
//
//
//   do {
//      let items = try managedContext.fetch(fetchRequest) as! [Item]
//
//
//      for i in IndexSet {
//         print(i)
//      }
//      print("Num items is \(items.count)")
//
//      let empty: [Int] = []
//      print("Empty")
//      print(empty.count)
//
//      if items.count > 0 {
//
//         let firstIndex = Int(items[0].position)
//         let lastIndex = Int(items[items.count-1].position)
////         print("First")
////         print(firstIndex)
////         print("Last")
////         print(lastIndex)
////
//
////      let firstIndex = IndexSet.min()!
////      print(firstIndex)
////      let lastIndex = IndexSet.max()!
////      print(lastIndex)
//
//      let firstRowToReorder = (firstIndex < destination) ? firstIndex : destination
//      let lastRowToReorder = (lastIndex > (destination-1)) ? lastIndex : (destination-1)
//
//      if firstRowToReorder != lastRowToReorder {
//
//           var newOrder = firstRowToReorder
//           if newOrder < firstIndex {
//               // Moving dragged items up, so re-order dragged items first
//
//               // Re-order dragged items
//            for index in IndexSet {
//                   items[index].setValue(newOrder, forKey: "position")
//                   newOrder = newOrder + 1
//               }
//
//               // Re-order non-dragged items
//               for rowToMove in firstRowToReorder..<lastRowToReorder {
//                  if !IndexSet.contains(rowToMove) {
//                       items[rowToMove].setValue(newOrder, forKey: "position")
//                       newOrder = newOrder + 1
//                   }
//               }
//           } else {
//               // Moving dragged items down, so re-order dragged items last
//
//               // Re-order non-dragged items
//               for rowToMove in firstRowToReorder...lastRowToReorder {
//                  if !IndexSet.contains(rowToMove) {
//                       items[rowToMove].setValue(newOrder, forKey: "position")
//                       newOrder = newOrder + 1
//                   }
//               }
//
//               // Re-order dragged items
//            for index in IndexSet {
//                   items[index].setValue(newOrder, forKey: "position")
//                   newOrder = newOrder + 1
//               }
//           }
//      }
//      }
//
//
//      do {
//         try managedContext.save()
//
//      } catch let error as NSError {
//         print("Could not delete. \(error), \(error.userInfo)")
//      }
//
//   } catch let error as NSError {
//      print("Could not fetch. \(error), \(error.userInfo)")
//   }
//}







//
//private func reorder(IndexSet: IndexSet, to destination: Int, within: [T] ) {
//
//
//    let firstIndex = IndexSet.min()!
//    let lastIndex = IndexSet.max()!
//
//    let firstRowToReorder = (firstIndex < destination) ? firstIndex : destination
//    let lastRowToReorder = (lastIndex > (destination-1)) ? lastIndex : (destination-1)
//
//    if firstRowToReorder != lastRowToReorder {
//
//         var newOrder = firstRowToReorder
//         if newOrder < firstIndex {
//             // Moving dragged items up, so re-order dragged items first
//
//             // Re-order dragged items
//             for index in IndexSet {
//                 within[index].setValue(newOrder, forKey: "order")
//                 newOrder = newOrder + 1
//             }
//
//             // Re-order non-dragged items
//             for rowToMove in firstRowToReorder..<lastRowToReorder {
//                 if !IndexSet.contains(rowToMove) {
//                     within[rowToMove].setValue(newOrder, forKey: "order")
//                     newOrder = newOrder + 1
//                 }
//             }
//         } else {
//             // Moving dragged items down, so re-order dragged items last
//
//             // Re-order non-dragged items
//             for rowToMove in firstRowToReorder...lastRowToReorder {
//                 if !IndexSet.contains(rowToMove) {
//                     within[rowToMove].setValue(newOrder, forKey: "order")
//                     newOrder = newOrder + 1
//                 }
//             }
//
//             // Re-order dragged items
//             for index in IndexSet {
//                 within[index].setValue(newOrder, forKey: "order")
//                 newOrder = newOrder + 1
//             }
//         }
//    }
//}








// ==================================================================
// ========================= REVERSED ===============================
// ==================================================================

//func move(IndexSet: IndexSet, destination: Int) {
//
//   guard let appDelegate =
//      UIApplication.shared.delegate as? AppDelegate else {
//         return
//   }
//
//   let managedContext =
//      appDelegate.persistentContainer.viewContext
//
//
//   let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Item")
//   fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Item.position, ascending: true)]
//
//
//   do {
//      let items = try managedContext.fetch(fetchRequest) as! [Item]
//
//      let firstIndex = IndexSet.reversed().min()!
//      let lastIndex = IndexSet.reversed().max()!
//
//      let firstRowToReorder = (firstIndex < destination) ? firstIndex : destination
//      let lastRowToReorder = (lastIndex > (destination-1)) ? lastIndex : (destination-1)
//
//      if firstRowToReorder != lastRowToReorder {
//
//           var newOrder = firstRowToReorder
//           if newOrder < firstIndex {
//               // Moving dragged items up, so re-order dragged items first
//
//               // Re-order dragged items
//            for index in IndexSet.reversed() {
//                   items[index].setValue(newOrder, forKey: "position")
//                   newOrder = newOrder + 1
//               }
//
//               // Re-order non-dragged items
//               for rowToMove in firstRowToReorder..<lastRowToReorder {
//                  if !IndexSet.reversed().contains(rowToMove) {
//                       items[rowToMove].setValue(newOrder, forKey: "position")
//                       newOrder = newOrder + 1
//                   }
//               }
//           } else {
//               // Moving dragged items down, so re-order dragged items last
//
//               // Re-order non-dragged items
//               for rowToMove in firstRowToReorder...lastRowToReorder {
//                  if !IndexSet.reversed().contains(rowToMove) {
//                       items[rowToMove].setValue(newOrder, forKey: "position")
//                       newOrder = newOrder + 1
//                   }
//               }
//
//               // Re-order dragged items
//            for index in IndexSet.reversed() {
//                   items[index].setValue(newOrder, forKey: "position")
//                   newOrder = newOrder + 1
//               }
//           }
//      }
//
//
//      do {
//         try managedContext.save()
//
//      } catch let error as NSError {
//         print("Could not delete. \(error), \(error.userInfo)")
//      }
//
//   } catch let error as NSError {
//      print("Could not fetch. \(error), \(error.userInfo)")
//   }
//}
