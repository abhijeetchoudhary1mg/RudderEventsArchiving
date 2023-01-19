//
//  AnalyticsDataModel.swift
//  RudderAnalyticsDataList
//
//  Created by Neha Jain on 11/01/23.
//

import Foundation

public class AnalyticsData: NSObject {
  
  public override init() {}
  
  @objc public var category = "To test"
  @objc public var action = ""
  @objc public var label = ""
  @objc public var value = ""
  let id = Date()
  @objc public var customData = [String: String]()

//  func hash(into hasher: inout Hasher) {
//    return hasher.combine(id)
//  }
//
//  static func == (lhs: AnalyticsData, rhs: AnalyticsData) -> Bool {
//    return lhs.id == rhs.id
//  }
}
