//
//  AnalyticsListingViewModel.swift
//  LearnSwiftUI
//
//  Created by Neha Jain on 16/01/23.
//

import Foundation

final class AnalyticsListingViewModel: ObservableObject {

  @Published private var analyticsDataArray = [AnalyticsData]()

  func addDataIntoArray(analyticsData: AnalyticsData) {
    analyticsDataArray.append(analyticsData)
  }

  func getAnalyticsData() -> [AnalyticsData] {
    return analyticsDataArray
  }

  func deleteData(at offsets: IndexSet) {
    analyticsDataArray.remove(atOffsets: offsets)
  }
  
  func deleteAllData() {
    analyticsDataArray.removeAll()
  }
}
