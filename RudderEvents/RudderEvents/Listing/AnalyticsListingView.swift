//
//  AnalyticsListing.swift
//  LearnSwiftUI
//
//  Created by Neha Jain on 16/01/23.
//

import SwiftUI

struct AnalyticsListing : View {

  @ObservedObject var viewModel = AnalyticsListingViewModel()
  
  var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    formatter.dateStyle = .short
    return formatter
  }

  var body: some View {
    NavigationView {
      if viewModel.getAnalyticsData().count > 0 {
          List {
            ForEach(viewModel.getAnalyticsData(), id: \.self) { data in
              HStack {
                VStack {
                  Text(data.category)
                    .font(.headline)
                    .frame(alignment: .leading)
                    .lineLimit(nil)
                  Text(dateFormatter.string(from: data.id))
                    .font(.subheadline).fontWeight(.light)
                    .frame(alignment: .leading)
                }
                NavigationLink(destination: AnalyticsDetailView(analyticsData: data)) {
                }
              }
            }
            .onDelete { indexSet in
              viewModel.deleteData(at: indexSet)
            }
          }
        .navTitle(title: "Analytic Events")
        .offset(y: 30)
        .navigationBarItems(trailing: deleteButton)
      } else {
        Text("No records found")
      }
    }
  }

  var deleteButton: some View {
    Button(action: {viewModel.deleteAllData()}) {
      Text("Delete")
    }
  }
}
