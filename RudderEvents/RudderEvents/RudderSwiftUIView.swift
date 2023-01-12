//
//  RudderSwiftUIView.swift
//  RudderEvents
//
//  Created by anand on 12/01/23.
//

import SwiftUI

public struct RudderSwiftUIView: View {
  public init() {}
  public var body: some View {
    NavigationView {
      List {
        Text("Hello")
      }
      .navigationTitle("Analytics Listing")
    }
  }
}

struct RudderSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        RudderSwiftUIView()
    }
}
