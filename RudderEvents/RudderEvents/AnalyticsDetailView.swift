//
//  AnalyticsDetailView.swift
//  LearnSwiftUI
//
//  Created by Neha Jain on 16/01/23.
//

import SwiftUI

struct AnalyticsDetailView: View {
  let analyticsData: AnalyticsData?
  
  var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    formatter.dateStyle = .short
    return formatter
  }
  
  var body: some View {
    if let data = analyticsData {
      VStack {
        DetailView(heading: "Date",
                   description: dateFormatter.string(from: data.id))
        DetailView(heading: "Category",
                   description: data.category)
        DetailView(heading: "Label",
                   description: data.label)
        DetailView(heading: "Value",
                   description: data.value)
        DetailView(heading: "Action",
                   description: data.action)
      }
    } else {
      Text("No records found")
    }
  }
}

struct DetailView: View {
  var heading: String
  var description: String
  
  var body: some View {
    HStack {
      Text(heading)
        .font(.headline)
      Text(description)
        .font(.subheadline)
    }
    .padding(10)
  }
}
