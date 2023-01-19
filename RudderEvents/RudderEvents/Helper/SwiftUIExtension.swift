//
//  SwiftUIExtension.swift
//  LearnSwiftUI
//
//  Created by Neha Jain on 16/01/23.
//

import Foundation
import SwiftUI

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
