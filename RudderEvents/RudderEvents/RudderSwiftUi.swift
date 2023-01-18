//
//  RudderSwiftUi.swift
//  
//
//  Created by anand on 13/01/23.
//

import SwiftUI

public struct RudderSwiftUi: View {
  
  @ObservedObject var viewModel = AnalyticsListingViewModel()
  
  var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    formatter.dateStyle = .short
    return formatter
  }
  
  @State private var analyticsDataArray = [AnalyticsData]()
  
  public init() {}
  
  func addDataIntoArray() {
   let analyticsData = AnalyticsData()
   analyticsDataArray.append(analyticsData)
   }
  
  
  // some View -- opaque return type
  //https://www.hackingwithswift.com/quick-start/beginners/how-to-use-opaque-return-types
  public var body: some View {
    NavigationView {
      if viewModel.getAnalyticsData().count > 0 {
        List {
          ForEach(viewModel.getAnalyticsData(), id: \.self) { data in
            HStack {
              VStack {
                Text(data.category)
                  .font(.headline)
                Text(dateFormatter.string(from: data.id))
                  .font(.subheadline).fontWeight(.light)
              }
              NavigationLink(destination: AnalyticsDetailView()) {
              }
            }
          }
          .onDelete { indexSet in
            viewModel.deleteData(at: indexSet)
          }
        }
      } else {
        Text("No records found")
      }
    }
    .onAppear(perform: addDataIntoArray)
  }
}

struct RudderSwiftUi_Previews: PreviewProvider {
    static var previews: some View {
        RudderSwiftUi()
    }
}

