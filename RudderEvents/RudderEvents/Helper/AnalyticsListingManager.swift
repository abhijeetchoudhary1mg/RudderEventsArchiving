//
//  AnalyticsListingManager.swift
//  LearnSwiftUI
//
//  Created by Neha Jain on 16/01/23.
//

import UIKit
import SwiftUI

public class AnalyticsListingManager: NSObject {
  
  @objc public static let shared = AnalyticsListingManager()
  
  private let listingView = AnalyticsListing()
  private override init() { }
  
  @objc public func addRudderEventTapGesture() {
    let globalGesture = UITapGestureRecognizer(target: self, action: #selector(globalTapped))
    globalGesture.numberOfTapsRequired = 2
    globalGesture.numberOfTouchesRequired = 2
    UIApplication.shared.getKeyWindow()?.addGestureRecognizer(globalGesture)
  }
  
  @objc func globalTapped() {
    let swiftUIController = UIHostingController(rootView: listingView)
    UIApplication.topViewController()?.present(swiftUIController, animated: true)
  }

  @objc public func addDataToList(data: AnalyticsData) {
    listingView.viewModel.addDataIntoArray(analyticsData: data)
  }
}


extension UIApplication {
  
  func getKeyWindow() -> UIWindow? {
    if #available(iOS 13.0, *) {
      let windowScenes = self.connectedScenes.compactMap({ $0 as? UIWindowScene })
      if let windowScene = windowScenes.first(where: { $0.activationState == .foregroundActive }),
         let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
        return keyWindow
      }
      
      return nil
    }
    else {
      return UIApplication.shared.keyWindow
    }
  }
  
  class func topViewController(controller: UIViewController? = UIApplication.shared.getKeyWindow()?.rootViewController) -> UIViewController? {
    if let navigationController = controller as? UINavigationController {
      return topViewController(controller: navigationController.visibleViewController)
    }
    if let tabController = controller as? UITabBarController {
      if let selected = tabController.selectedViewController {
        return topViewController(controller: selected)
      }
    }
    if let presented = controller?.presentedViewController {
      return topViewController(controller: presented)
    }
    return controller
  }
  
}
