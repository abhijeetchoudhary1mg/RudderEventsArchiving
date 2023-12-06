//
//  AnalyticsListing.swift
//  LearnSwiftUI
//
//  Created by Neha Jain on 16/01/23.
//

import SwiftUI
import Combine

struct City: Identifiable, Hashable {
  var id = UUID().uuidString
  var name: String
}

struct AnalyticsListing : View {
  
  @SwiftUI.State private var currentSelectedCity: City = City(name: "Category")
  @ObservedObject var viewModel = AnalyticsListingViewModel()
  var array = [City(name: "Category"), City(name: "Screen"), City(name: "Label"), City(name: "Action"), City(name: "Custom Dimensions"), City(name: "PLA Events")]
  @State private var searchText = ""
  @State var showsAlert = false
  @State private var showCancelButton: Bool = false
  var searchResults: [AnalyticsData] {
    return viewModel.getAnalyticsData(searchCategory: currentSelectedCity.name, searchText: searchText)
  }
  
  // MARK: - Private member
  
  private struct Defaults {
    static let downArrowIcon: String = "chevron_down"
    static let backIcon: String = "back"
    static let cityPicker: String = "City Picker"
    static let backButtonHorizontalSpacing: CGFloat = 16.0
  }
  
  
  var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    formatter.dateStyle = .short
    return formatter
  }
  
  var body: some View {
    
    NavigationView {
      VStack {
        VStack {
          HStack {
            HStack(spacing: 0) {
              Picker(selection: $currentSelectedCity, label: Text(Defaults.cityPicker)) {
                ForEach(array, id: \.self) { city in
                  Text(city.name).tag(city as City?)
                }
              }
              .font(Font(UIFont.systemFont(ofSize: 18.0)))
              .foregroundColor(Color.init(red: 59.0 / 255.0, green: 59.0 / 255.0, blue: 59.0 / 255.0))
              .accentColor(Color.init(red: 59.0 / 255.0, green: 59.0 / 255.0, blue: 59.0 / 255.0))
              .valueChanged(value: currentSelectedCity) { newValue in
                print(newValue)
              }

            }
            Button("Delete All", action: {
                self.showsAlert = true
              })
                .background(Color.red)
                .contentShape(Rectangle())
                .foregroundColor(.white)
                .alert(isPresented: self.$showsAlert, content: {
                  Alert(title: Text("Are you sure you want to delete all events?"), primaryButton: .default(Text("Yes"), action: {
                    viewModel.deleteAllData()
                  }), secondaryButton: .destructive(Text("No")))
                })
                .padding()
          }
          HStack {
            TextField("search", text: $searchText, onEditingChanged: { isEditing in
              self.showCancelButton = true
            }, onCommit: {
              print("onCommit")
            }).foregroundColor(.primary)
          }
          .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
          .foregroundColor(.secondary)
          .background(Color(.secondarySystemBackground))
          .cornerRadius(10.0)
          if showCancelButton  {
            Button("Cancel") {
              UIApplication.shared.endEditing(true) // this must be placed before the other commands here
              self.searchText = ""
              self.showCancelButton = false
            }
            .foregroundColor(Color(.systemBlue))
          }
        }.padding([.horizontal], 16)
        
        if searchResults.count > 0 {
          List {
            ForEach(searchResults, id: \.self) { data in
              HStack {
                VStack {
                  HStack {
                    let categoryTextColor: Color = data.isGAEventTracked ? .orange : .black
                    Text("Category: ")
                      .frame(maxWidth: .infinity, alignment: .leading)
                      .fixedSize(horizontal: false, vertical: true)
                          .frame(minWidth: 80)
                    Spacer(minLength: 60)
                    Text(data.category)
                      .font(.headline)
                      .frame(alignment: .trailing)
                      .frame(maxWidth: .infinity)
                      .fixedSize(horizontal: false, vertical: true)
                          .frame(minWidth: 80)
                          .foregroundColor(categoryTextColor)
                  }
                  HStack {
                    Text("Screen Name: ").frame(maxWidth: .infinity, alignment: .leading)
                      .frame(maxWidth: .infinity)
                      .fixedSize(horizontal: false, vertical: true)
                          .frame(minWidth: 80)
                    Spacer(minLength: 60)
                    Text(data.screenName)
                      .font(.footnote)
                      .frame(alignment: .trailing)
                      .frame(maxWidth: .infinity)
                      .foregroundColor(.green)
                      .fixedSize(horizontal: false, vertical: true)
                          .frame(minWidth: 80)
                  }
                  HStack {
                    Text("Action: ").frame(maxWidth: .infinity, alignment: .leading)
                      .fixedSize(horizontal: false, vertical: true)
                          .frame(minWidth: 80)
                    Spacer(minLength: 60)
                    Text(data.action)
                      .font(.caption)
                      .frame(maxWidth: .infinity)
                      .frame(alignment: .trailing)
                      .fixedSize(horizontal: false, vertical: true)
                          .frame(minWidth: 80)
                  }
                  HStack {
                    Text("Date: ").frame(maxWidth: .infinity, alignment: .leading)
                      .fixedSize(horizontal: false, vertical: true)
                          .frame(minWidth: 80)
                    Spacer(minLength: 60)
                    Text(dateFormatter.string(from: data.id))
                      .font(.subheadline).fontWeight(.light)
                      .frame(maxWidth: .infinity)
                      .frame(alignment: .trailing)
                      .fixedSize(horizontal: false, vertical: true)
                          .frame(minWidth: 80)
                  }
                }
                NavigationLink(destination: AnalyticsDetailView(analyticsData: data)) {
                  
                }
                
              }
              
            }
            
            .onDelete { indexSet in
              viewModel.deleteData(at: indexSet)
            }
          }.resignKeyboardOnDragGesture()
          
        }
        else {
          Spacer()
          Text("no records found")
          Spacer()
        }
      }.navTitle(title: "Rudder Analytic Events")
    }
      
      
  }
}

extension View {
  
  @ViewBuilder func valueChanged<T: Equatable>(value: T,
                                                      onChange: @escaping (T) -> Void) -> some View {
    if #available(iOS 14.0, *) {
      self.onChange(of: value, perform: onChange)
    }
    else {
      self.onReceive(Just(value)) { (value) in
        onChange(value)
      }
    }
  }
    
  func onWillAppear(_ perform: @escaping () -> Void) -> some View {
    self.modifier(WillAppearModifier(callback: perform))
  }
}

fileprivate struct WillAppearHandler: UIViewControllerRepresentable {
  func makeCoordinator() -> WillAppearHandler.Coordinator {
    Coordinator(onWillAppear: onWillAppear)
  }
  
  let onWillAppear: () -> Void
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<WillAppearHandler>) -> UIViewController {
    context.coordinator
  }
  
  func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<WillAppearHandler>) {
    //Nothing to do here...
  }
  
  typealias UIViewControllerType = UIViewController
  
  final class Coordinator: UIViewController {
    let onWillAppear: () -> Void
    
    init(onWillAppear: @escaping () -> Void) {
      self.onWillAppear = onWillAppear
      super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
      navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      self.tabBarController?.tabBar.isHidden = true
      onWillAppear()
    }
  }
}

fileprivate struct WillAppearModifier: ViewModifier {
  let callback: () -> Void
  
  func body(content: Content) -> some View {
    content
      .background(WillAppearHandler(onWillAppear: callback))
  }
}

// Update for iOS 15
// MARK: - UIApplication extension for resgning keyboard on pressing the cancel buttion of the search bar
extension UIApplication {
    /// Resigns the keyboard.
    ///
    /// Used for resigning the keyboard when pressing the cancel button in a searchbar based on [this](https://stackoverflow.com/a/58473985/3687284) solution.
    /// - Parameter force: set true to resign the keyboard.
    func endEditing(_ force: Bool) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

// 1. Activity View
struct ActivityView: UIViewControllerRepresentable {
    let text: String

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: [text], applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>) {}
}

struct ShareText: Identifiable {
    let id = UUID()
    let text: String
}
