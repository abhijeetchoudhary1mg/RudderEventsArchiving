//
//  AnalyticsDataModel.swift
//  RudderAnalyticsDataList
//
//  Created by Neha Jain on 11/01/23.
//

import Foundation

public class AnalyticsData: NSObject {

  private struct Defaults {
   static let isGAEventTrackedKey = "isGAEventTracked"
  }

  public override init() {}
  
  @objc
  public init(category: String?,
              action: String?,
              label: String?,
              screen: String?,
              customDimention: [String: AnyObject]?,
              extras: [String: AnyObject]? = nil) {

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

    if let extras = extras {
      self.extras = extras
    }

    if let isGAEventTracked = customDimention?[Defaults.isGAEventTrackedKey] as? Bool {
      self.isGAEventTracked = isGAEventTracked
      self.customData.removeValue(forKey: Defaults.isGAEventTrackedKey)
    }
  }

  @objc public var category = ""
  @objc public var action = ""
  @objc public var label = ""
  @objc public var value = ""
  @objc public var screenName = ""
  let id = Date()
  @objc public var customData = [String: AnyObject]()
  @objc public var extras = [String: AnyObject]()
  @objc public var isGAEventTracked = false
}
