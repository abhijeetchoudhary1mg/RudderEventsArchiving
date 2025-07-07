//
//  AnalyticsListingViewModel.swift
//  LearnSwiftUI
//
//  Created by Neha Jain on 16/01/23.
//

import Foundation

final class AnalyticsListingViewModel: ObservableObject {

  @Published private(set) var analyticsDataArray = [AnalyticsData]()

  func addDataIntoArray(analyticsData: AnalyticsData) {
    DispatchQueue.main.async { [weak self] in
      self?.analyticsDataArray.append(analyticsData)
    }
  }

  func getAnalyticsData(searchCategory: String?, searchText: String? = nil) -> [AnalyticsData] {
    if let searchText = searchText,
       !searchText.isEmpty {
      switch searchCategory {
      case "Label":
        let labelResults = analyticsDataArray.filter({ $0.label.isEmpty == false && $0.label.lowercased().contains(searchText.lowercased()) })
        return labelResults
      case "Category":
        let labelResults = analyticsDataArray.filter({ $0.category.isEmpty == false && $0.category.lowercased().contains(searchText.lowercased())})
        return labelResults
      case "Screen":
        let labelResults = analyticsDataArray.filter({ $0.screenName.isEmpty == false && $0.screenName.lowercased().contains(searchText.lowercased())})
        return labelResults
      case "Action":
        let labelResults = analyticsDataArray.filter({ $0.action.isEmpty == false && $0.action.lowercased().contains(searchText.lowercased())})
        return labelResults
      case "Custom Dimensions":
        let labelResults = analyticsDataArray.filter({ !($0.customData.keys.filter({ ($0.isEmpty == false) && $0.lowercased().contains(searchText.lowercased()) }).isEmpty)
        })
        return labelResults
      case "PLA Events":
        if let labelResults = getPlaEvents(searchText: searchText) {
          return labelResults
        }
      default:
        break
      }
    }
    else if searchCategory == "PLA Events" {
      if let labelResults = getPlaEvents(searchText: "") {
        return labelResults
      }
    }
    return analyticsDataArray
  }

  func getPlaEvents(searchText: String) -> [AnalyticsData]? {
    return analyticsDataArray.filter({ !($0.customData.keys.filter({ ($0 == "onlineSalesEvent") || $0.lowercased().contains(searchText.lowercased()) }).isEmpty)
    })
    return nil
  }

  func deleteData(at offsets: IndexSet) {
    analyticsDataArray.remove(atOffsets: offsets)
  }

  func deleteAllData() {
    analyticsDataArray.removeAll()
  }
}
