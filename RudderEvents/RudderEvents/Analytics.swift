//
//  Analytics.swift
//  experi3frame
//
//  Created by anand on 13/01/23.
//

import Foundation

public struct AnalyticsData: Hashable {
  
  public init() {}
  
  public var category = "long name of the category to test"
  public var action = ""
  public var label = ""
  public var value = ""
  public var id = Date()
}
