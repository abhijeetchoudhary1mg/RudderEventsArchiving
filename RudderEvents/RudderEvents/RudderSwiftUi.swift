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
  
  public var body: some View {
    NavigationView {
      if viewModel.getAnalyticsData().count > 0 {
        VStack {
          List {
            ForEach(viewModel.getAnalyticsData(), id: \.self) { data in
              HStack {
                VStack {
                  Text(data.category)
                    .font(.headline)
                  Text(dateFormatter.string(from: data.id))
                    .font(.subheadline).fontWeight(.light)
                }
                NavigationLink(destination: AnalyticsDetailView(analyticsData: data)) {
                }
              }
            }
            .onDelete { indexSet in
              viewModel.deleteData(at: indexSet)
            }
          }
          Button {
            viewModel.deleteAllData()
          } label: {
            Text("Delete")
              .padding()
              .foregroundColor(.white)
              .lineLimit(nil)
              .font(.headline)
              .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: 60,
                alignment: .center
              )
          }
          .background(Color.red)
          .contentShape(Rectangle())
        }
        .navTitle(title: "Analytic Events")
      } else {
        Text("No records found")
      }
    }
    .onAppear(perform: addDataIntoArray)
  }
}


extension View {

  @ViewBuilder func navTitle(title: String) -> some View {
    if #available(iOS 14.0, *) {
      self.navigationTitle(title)
    }
    else {
      self.navigationBarTitle(title)
    }
  }
}
