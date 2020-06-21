////
////  IAPManager.swift
////  Simple List
////
////  Created by Chris Filiatrault on 16/6/20.
////  Copyright © 2020 Chris Filiatrault. All rights reserved.
////
//
///*
// In-app purchase pipeline
// Doesn't have a one-size-fits-all approach to increase security.
//
// Define purchase in App Store Connect ✅
// Load Identifiers ✅
// Fetch Products
// Provide UI element to buy
// Request payment
// Receive response
// Receive receipt
// Decrypt & validate receipt (method up to developers)
// Unlock content for end user
// Finish transaction (must be done!)
// */
//
//
//
//import SwiftUI
//import Combine
//import StoreKit
//
//
//
//final class ProductsDB: ObservableObject, Identifiable {
//
//   static let shared = ProductsDB()
//   var items: [SKProduct] = [] {
//      willSet {
//         DispatchQueue.main.async {
//            self.objectWillChange.send()
//         }
//      }
//   }
//}
//
//class IAPManager: NSObject {
//
//   // Singleton IAPManager to ensure we always refer to the same one
//   static let shared = IAPManager()
//   var totalRestoredPurchases: Int = 0
//
//   private override init() {
//      super.init()
//   }
//
//   func buyV5(product: SKProduct) {
//      let payment = SKPayment(product: product)
//      SKPaymentQueue.default().add(payment)
//   }
//
//   func canMakePayments() -> Bool {
//      return SKPaymentQueue.canMakePayments()
//   }
//
//   func startObserving() {
//      SKPaymentQueue.default().add(self)
//   }
//
//   func stopObserving() {
//      SKPaymentQueue.default().remove(self)
//   }
//
//   // Get the products from App Store Connect
//   // The extension below adds functionality to SKProductsRequest
//   func getProductsV5() {
//      let productIDs = Set(returnProductIDs())
//      let request = SKProductsRequest(productIdentifiers: Set(productIDs))
//      request.delegate = self
//      request.start()
//   }
//
//   let purchasePublisher = PassthroughSubject<(String, Bool), Never>()
//
//   // This function returns the IDs created on App Store Connect
//   // Note that if I wanted to add more in-app purchases later, I'd have to avoid hard-coding in the IDs like below, to avoid the need to re-release the app (lose all reviews etc presumably)
//   func returnProductIDs() -> [String] {
//      return ["com.cfiliatrault_SimpleList_RemoveAds"]
//   }
//
//
//   // Get the local price and currency
//   func formatPrice(for product: SKProduct) -> String? {
//      let formatter = NumberFormatter()
//      formatter.numberStyle = .currency
//      formatter.locale = product.priceLocale
//      return formatter.string(from: product.price)
//   }
//
//   func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
//      if totalRestoredPurchases != 0 {
//         purchasePublisher.send(("IAP: Purchases successfully restored!", true))
//      } else {
//         purchasePublisher.send(("IAP: No purchases to restore!", true))
//      }
//   }
//
//   func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
//      if let error = error as? SKError {
//         if error.code != .paymentCancelled {
//            purchasePublisher.send(("IAP Restore Error: " + error.localizedDescription, false))
//         } else {
//            purchasePublisher.send(("IAP Error: " + error.localizedDescription, false))
//         }
//      }
//   }
//
//   func restorePurchasesV5() {
//      totalRestoredPurchases = 0
//      SKPaymentQueue.default().restoreCompletedTransactions()
//      print("restorePurchasesV5 function complete")
//   }
//
//   func purchaseV5(product: SKProduct) -> Bool {
//      if !IAPManager.shared.canMakePayments() {
//         print("Can't make payments")
//         return false
//      } else {
//         let payment = SKPayment(product: product)
//         SKPaymentQueue.default().add(payment)
//         print("Payment added to queue for \(product.localizedTitle)")
//         UserDefaults.standard.set(true, forKey: "purchased")
//      }
//      print("totalRestoredPurchases: \(totalRestoredPurchases)")
//      return true
//   }
//   
//}
//
//// Get products from App Store connect
//extension IAPManager: SKProductsRequestDelegate, SKRequestDelegate {
//   func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//      let badProducts = response.invalidProductIdentifiers
//      let goodProducts = response.products
//
//      if !goodProducts.isEmpty {
//         ProductsDB.shared.items = response.products
//         print("Got products: ", ProductsDB.shared.items)
//      }
//
//      print("badProducts ", badProducts)
//
//   }
//
//   // This method handles failures when requesting a product that doesn't exist
//   func request(_ request: SKRequest, didFailWithError error: Error) {
//      print("didFailWithError ", error)
//      purchasePublisher.send(("Purchase request failed ", true))
//   }
//
//   // To know that a request finished
//   func requestDidFinish(_ request: SKRequest) {
//      print("request did finish ")
//   }
//
//}
//
//extension IAPManager: SKPaymentTransactionObserver {
//   func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
//      transactions.forEach { (transaction) in
//         switch transaction.transactionState {
//         case .purchased:
//            SKPaymentQueue.default().finishTransaction(transaction)
//            purchasePublisher.send(("Purchased ", true))
//            print("Successfully purchased")
//            UserDefaults.standard.set(true, forKey: "purchased")
//         case .restored:
//            totalRestoredPurchases += 1
//            SKPaymentQueue.default().finishTransaction(transaction)
//            purchasePublisher.send(("Restored ", true))
//            UserDefaults.standard.set(true, forKey: "purchased")
//            print("Successfully restored")
//            
//         case .failed:
//            if let error = transaction.error as? SKError {
//               purchasePublisher.send(("Payment Error \(error.code) ", false))
//               print("Payment Failed \(error.code)")
//            }
//            SKPaymentQueue.default().finishTransaction(transaction)
//         case .deferred:
//            print("Ask Mom ...")
//            purchasePublisher.send(("Payment Diferred ", false))
//         case .purchasing:
//            print("working on it...")
//            purchasePublisher.send(("Payment in Process ", false))
//            
//         default:
//            break
//         }
//      }
//   }
//}
//
//
//
