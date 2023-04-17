//
//  AnalyticsDataModel.swift
//  RudderAnalyticsDataList
//
//  Created by Neha Jain on 11/01/23.
//

import Foundation

public class AnalyticsData: NSObject {

  public override init() {}
  
  @objc
  public init(category: String?,
              action: String?,
              label: String?,
              screen: String?,
              customDimention: [String: AnyObject]?) {

    if let category = category {
      self.category = category
    }

    if let action = action {
      self.action = action
    }

    if let label = label {
      self.label = label
    }

    if let screen = screen {
      self.screenName = screen
    }

    if let customDimention = customDimention {
      self.customData = customDimention
    }
  }

  @objc public var category = ""
  @objc public var action = ""
  @objc public var label = ""
  @objc public var value = ""
  @objc public var screenName = ""
  let id = Date()
  @objc public var customData = [String: AnyObject]()
}
