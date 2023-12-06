//
//  AnalyticsDetailView.swift
//  LearnSwiftUI
//
//  Created by Neha Jain on 16/01/23.
//

import SwiftUI
struct AnalyticsDetailView: View {

  let analyticsData: AnalyticsData?

  @State var shareText: ShareText?

  var dateFormatter: DateFormatter {

    let formatter = DateFormatter()

    formatter.timeStyle = .short

    formatter.dateStyle = .short

    return formatter

  }

  
  var body: some View {

    if let data = analyticsData {

      NavigationView {

        ScrollView {

          VStack(spacing: 10) {


            Spacer()
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

            DetailView(heading: "ScreenName",

                       description: data.screenName)
            ForEach(Array(data.extras.keys), id: \.self) { key  in

              DetailView(heading: key,

                         description: data.extras[key]?.description ?? "")

            }

            Text("Custom Data")

              .padding()

              .overlay(

                RoundedRectangle(cornerRadius: 0)

                  .stroke(.black, lineWidth: 1)

              )

            ForEach(Array(data.customData.keys), id: \.self) { key  in

              DetailView(heading: key,

                         description: data.customData[key]?.description ?? "")

            }

          }

        }

      }.navigationBarItems(trailing: Button("Share", action: {
        shareText = ShareText(text: """
      \n Analytics Data \n
      Date: \(dateFormatter.string(from: data.id))\n
      Category: \(data.category)\n
      Label: \(data.label)\n
      Value: \(data.value)\n
      Action: \(data.action)\n
      screenName: \(data.screenName)\n
      customData: \(data.customData)\n
      """)
      }))
      .sheet(item: $shareText) { shareText in
        ActivityView(text: shareText.text)
      }.navigationBarTitle("Analytics Data", displayMode: .inline)

    } else {

      Text("No records found")

    }

  }

}

struct DetailView: View {

  var heading: String

  var description: String

  

  var body: some View {

    ZStack {

      HStack {

        Text(heading)

          .font(.headline)

          .frame(alignment: .topLeading)

          .padding()
          .contextMenu(ContextMenu(menuItems: {
            Button("Copy", action: {
              UIPasteboard.general.string = heading
            })
          }))
          

        Text(description)

          .font(.subheadline)

          .frame(alignment: .top)

          .padding()

          .lineLimit(nil)
          .contextMenu(ContextMenu(menuItems: {
            Button("Copy", action: {
              UIPasteboard.general.string = description
            })
          }))
      }

      .frame(maxWidth: .infinity, alignment: .topLeading)
    }

  }

}
