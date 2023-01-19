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

  // some View -- opaque return type
  //https://www.hackingwithswift.com/quick-start/beginners/how-to-use-opaque-return-types
  var body: some View {
    NavigationView {
      if viewModel.getAnalyticsData().count > 0 {
        VStack {
          List {
            ForEach(viewModel.getAnalyticsData(), id: \.self) { data in
              HStack {
                VStack {
                  Text(data.category)
                    .font(.headline)
                    .frame(alignment: .leading)
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
  }
}

