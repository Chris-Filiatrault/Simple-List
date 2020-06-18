//
//  Misc.swift
//  Simple List
//
//  Created by Chris Filiatrault on 10/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//


//
//  IAPManager.swift
//  Simple List
//
//  Created by Chris Filiatrault on 16/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

/*
 In-app purchase pipeline
 Doesn't have a one-size-fits-all approach to increase security.
 
 Define purchase in App Store Connect ✅
 Initialise IAPManager with a singleton ✅
 Define various cases for errors (noProductID etc) ✅
 Create IAPManager extension for error messages ✅
 Create function and plist for reading product IDs ✅
 Function to request IDs from the app store ✅
 Handle app store response ✅
 Get product prices in local currencies as a string ✅
 
 
 
 
 Load Identifiers ✅
 Fetch Products
 Provide UI element to buy
 Request payment
 Receive response
 Receive receipt
 Decrypt & validate receipt (method up to developers)
 Unlock content for end user
 Finish transaction (must be done!)
 */
//
//
//import Foundation
//import StoreKit
//
//class IAPManager: NSObject {
//
//
//    // Define error cases
//    enum IAPManagerError: Error {
//        case noProductIDsFound
//        case noProductsFound
//        case paymentWasCancelled
//        case productRequestFailed
//    }
//
//
//    // MARK: - Properties
//
//
//    var onReceiveProductsHandler: ((Result<[SKProduct], IAPManagerError>) -> Void)?
//
//    var onBuyProductHandler: ((Result<Bool, Error>) -> Void)?
//
//    var totalRestoredPurchases = 0
//
//
//   // Initialise singleton
//   static let shared = IAPManager()
//    private override init() {
//        super.init()
//    }
//
//
//    // MARK: - General Methods
//
//    fileprivate func getProductIDs() -> [String]? {
//        guard let url = Bundle.main.url(forResource: "IAP_ProductIDs", withExtension: "plist") else { return nil }
//        do {
//            let data = try Data(contentsOf: url)
//            let productIDs = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? [String] ?? []
//            return productIDs
//        } catch {
//            print(error.localizedDescription)
//            return nil
//        }
//    }
//
//
//    func getPriceFormatted(for product: SKProduct) -> String? {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .currency
//        formatter.locale = product.priceLocale
//        return formatter.string(from: product.price)
//    }
//
//
//    func startObserving() {
//        SKPaymentQueue.default().add(self)
//    }
//
//
//    func stopObserving() {
//        SKPaymentQueue.default().remove(self)
//    }
//
//
//    func canMakePayments() -> Bool {
//        return SKPaymentQueue.canMakePayments()
//    }
//
//
//    // MARK: - Get IAP Products
//
//    func getProducts(withHandler productsReceiveHandler: @escaping (_ result: Result<[SKProduct], IAPManagerError>) -> Void) {
//        // Keep the handler (closure) that will be called when requesting for
//        // products on the App Store is finished.
//        onReceiveProductsHandler = productsReceiveHandler
//
//        // Get the product identifiers.
//        guard let productIDs = getProductIDs() else {
//            productsReceiveHandler(.failure(.noProductIDsFound))
//            return
//        }
//
//        // Initialize a product request.
//        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
//
//        // Set self as the its delegate.
//        request.delegate = self
//
//        // Make the request.
//        request.start()
//    }
//
//
//
//    // MARK: - Purchase Products
//
//    func buy(product: SKProduct, withHandler handler: @escaping ((_ result: Result<Bool, Error>) -> Void)) {
//        let payment = SKPayment(product: product)
//        SKPaymentQueue.default().add(payment)
//
//        // Keep the completion handler.
//        onBuyProductHandler = handler
//    }
//
//
//    func restorePurchases(withHandler handler: @escaping ((_ result: Result<Bool, Error>) -> Void)) {
//        onBuyProductHandler = handler
//        totalRestoredPurchases = 0
//        SKPaymentQueue.default().restoreCompletedTransactions()
//    }
//}
//
//
//// MARK: - SKPaymentTransactionObserver
//extension IAPManager: SKPaymentTransactionObserver {
//    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
//        transactions.forEach { (transaction) in
//            switch transaction.transactionState {
//            case .purchased:
//                onBuyProductHandler?(.success(true))
//                SKPaymentQueue.default().finishTransaction(transaction)
//
//            case .restored:
//                totalRestoredPurchases += 1
//                SKPaymentQueue.default().finishTransaction(transaction)
//
//            case .failed:
//                if let error = transaction.error as? SKError {
//                    if error.code != .paymentCancelled {
//                        onBuyProductHandler?(.failure(error))
//                    } else {
//                        onBuyProductHandler?(.failure(IAPManagerError.paymentWasCancelled))
//                    }
//                    print("IAP Error:", error.localizedDescription)
//                }
//                SKPaymentQueue.default().finishTransaction(transaction)
//
//            case .deferred, .purchasing: break
//            @unknown default: break
//            }
//        }
//    }
//
//
//    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
//        if totalRestoredPurchases != 0 {
//            onBuyProductHandler?(.success(true))
//        } else {
//            print("IAP: No purchases to restore!")
//            onBuyProductHandler?(.success(false))
//        }
//    }
//
//
//    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
//        if let error = error as? SKError {
//            if error.code != .paymentCancelled {
//                print("IAP Restore Error:", error.localizedDescription)
//                onBuyProductHandler?(.failure(error))
//            } else {
//                onBuyProductHandler?(.failure(IAPManagerError.paymentWasCancelled))
//            }
//        }
//    }
//}
//
//
//
//
//// MARK: - SKProductsRequestDelegate
//extension IAPManager: SKProductsRequestDelegate {
//    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//        // Get the available products contained in the response.
//        let products = response.products
//
//        // Check if there are any products available.
//        if products.count > 0 {
//            // Call the following handler passing the received products.
//            onReceiveProductsHandler?(.success(products))
//        } else {
//            // No products were found.
//            onReceiveProductsHandler?(.failure(.noProductsFound))
//        }
//    }
//
//
//    func request(_ request: SKRequest, didFailWithError error: Error) {
//        onReceiveProductsHandler?(.failure(.productRequestFailed))
//    }
//
//
//    func requestDidFinish(_ request: SKRequest) {
//        // Implement this method OPTIONALLY and add any custom logic
//        // you want to apply when a product request is finished.
//    }
//}
//
//
//
//
//// MARK: - IAPManagerError Localized Error Descriptions
//extension IAPManager.IAPManagerError: LocalizedError {
//    var errorDescription: String? {
//        switch self {
//        case .noProductIDsFound: return "No In-App Purchase product identifiers were found."
//        case .noProductsFound: return "No In-App Purchases were found."
//        case .productRequestFailed: return "Unable to fetch available In-App Purchase products at the moment."
//        case .paymentWasCancelled: return "In-App Purchase process was cancelled."
//        }
//    }
//}


//
//
//// UIKIT Implementation from github
//
//import UIKit
//import SwiftUI
//import GoogleMobileAds
//
//
//class GADBannerViewController: UIViewController {
//    
//    let bannerView = GADBannerView(adSize: kGADAdSizeBanner)
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // This app using sample id.
//        // https://developers.google.com/admob/ios/test-ads#sample_ad_units
//        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
//        
//        bannerView.delegate = self
//        bannerView.translatesAutoresizingMaskIntoConstraints = false
//        bannerView.rootViewController = self
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        bannerView.load(GADRequest())
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        bannerView.removeFromSuperview()
//    }
//    
//}
//
//
//
//// MARK: - GADBannerViewDelegate
//extension GADBannerViewController: GADBannerViewDelegate {
//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        
//        guard let viewController = bannerView.rootViewController else {
//            return
//        }
//        
//        guard bannerView.superview == nil else {
//            return
//        }
//        
//        
//        viewController.view.addSubview(bannerView)
//        viewController.view.bringSubviewToFront(bannerView)
//        
//        viewController.view.addConstraints([
//            NSLayoutConstraint(item: bannerView,
//                               attribute: .bottom,
//                               relatedBy: .equal,
//                               toItem: viewController.view.safeAreaLayoutGuide,
//                               attribute: .bottom,
//                               multiplier: 1,
//                               constant: 0),
//            NSLayoutConstraint(item: bannerView,
//                               attribute: .centerX,
//                               relatedBy: .equal,
//                               toItem: viewController.view,
//                               attribute: .centerX,
//                               multiplier: 1,
//                               constant: 0)
//        ])
//        
//    }
//    
//    func adView(_ bannerView: GADBannerView,
//                didFailToReceiveAdWithError error: GADRequestError) {
//        print(error.localizedDescription)
//    }
//    
//    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
//    }
//    
//    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
//    }
//    
//    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
//    }
//    
//    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
//    }
//}
//
//
//
//
//struct GADBannerViewControllerRepresentable: UIViewControllerRepresentable {
//    
//    typealias UIViewControllerType = GADBannerViewController
//    static let adsBannerSize: CGSize = CGSize(width: 320, height: 50)
//    
//    
//    func makeUIViewController(context: Context) -> UIViewControllerType {
//        return .init()
//    }
//    
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//    }
//    
//}
