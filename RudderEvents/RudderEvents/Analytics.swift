//
//  Analytics.swift
//  experi3frame
//
//  Created by anand on 13/01/23.
//

import Foundation

public class AnalyticsData: NSObject {
  
  public override init() {}
  
  @objc public var category = "long name of the category to test"
  @objc public var action = ""
  @objc public var label = ""
  @objc public var value = ""
  @objc public var id = Date()
}
