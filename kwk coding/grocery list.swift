//
//  grocery list.swift
//  kwk coding
//
//  Created by Otitodilichukwu Ikem on 6/30/23.
//

import SwiftUI

import SwiftUI



struct GroceryItem: Identifiable {

    let id = UUID()

    var name: String

    var isPurchased: Bool = false

}



struct GroceryList: Identifiable {

    let id = UUID()

    var name: String

    var items: [GroceryItem] = []

}



class GroceryListsViewModel: ObservableObject {

    @Published var groceryLists: [GroceryList] = []

    

    func addGroceryItem(_ itemName: String, to groceryList: GroceryList) {

        let newGroceryItem = GroceryItem(name: itemName)

        groceryLists[groceryLists.firstIndex(where: { $0.id == groceryList.id })!].items.append(newGroceryItem)

    }

    

    func toggleGroceryItem(_ groceryItem: GroceryItem) {

        if let groceryListIndex = groceryLists.firstIndex(where: { $0.items.contains(groceryItem) }) {

            if let groceryItemIndex = groceryLists[groceryListIndex].items.firstIndex(where: { $0.id == groceryItem.id }) {

                groceryLists[groceryListIndex].items[groceryItemIndex].isPurchased.toggle()

            }

        }

    }

}



struct ContentView: View {

    @StateObject private var viewModel = GroceryListsViewModel()

    @State private var isShowingAddItemSheet = false

    @State private var selectedItem: GroceryItem?

    

    var body: some View {

        NavigationView {

            List(viewModel.groceryLists) { groceryList in

                NavigationLink(destination: GroceryItemsView(groceryList: groceryList)) {

                    Text(groceryList.name)

                }

            }

            .navigationTitle("Grocery Lists")

            .navigationBarItems(trailing:

                Button(action: { isShowingAddItemSheet.toggle() }) {

                    Image(systemName: "plus")

                }

            )

        }

        .sheet(isPresented: $isShowingAddItemSheet) {

            AddGroceryItemView(viewModel: viewModel, isPresented: $isShowingAddItemSheet)

        }

    }

}



struct GroceryItemsView: View {

    @ObservedObject var groceryList: GroceryList

    @StateObject private var viewModel = GroceryListsViewModel()

    

    var body: some View {

        List {

            ForEach(groceryList.items) { groceryItem in

                HStack {

                    Text(groceryItem.name)

                    Spacer()

                    Image(systemName: groceryItem.isPurchased ? "checkmark.circle.fill" : "circle")

                        .foregroundColor(groceryItem.isPurchased ? .green : .gray)

                }

                .onTapGesture {

                    viewModel.toggleGroceryItem(groceryItem)

                }

            }

        }

        .navigationTitle(groceryList.name)

        .navigationBarItems(trailing:

            Button(action: {

                selectedItem = nil

                viewModel.groceryLists.removeAll(where: { $0.id == groceryList.id })

            }) {

                Image(systemName: "trash")

            }

        )

    }

}



struct AddGroceryItemView: View {

    @ObservedObject var viewModel: GroceryListsViewModel

    @Binding var isPresented: Bool

    @State private var itemName = ""

    

    var body: some View {

        NavigationView {

            VStack {

                TextField("Item name", text: $itemName)

                    .textFieldStyle(RoundedBorderTextFieldStyle())

                    .padding


