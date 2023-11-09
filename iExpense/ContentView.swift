//
//  ContentView.swift
//  iExpense
//
//  Created by Александр Полочанин on 9.11.23.
//

import SwiftUI

struct ExpenseItem {
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]()
}

struct ContentView: View {
    @State private var expenses = Expenses()
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(expenses.items, id: \.name) { item in
                        Text(item.name)
                    }
                    .onDelete(perform: removeExpense)
                }
            }
            .navigationTitle("IExpense")
            .toolbar {
                Button("Add Item" , systemImage: "plus") {
                    let testItem = ExpenseItem(name: "test", type: "test", amount: 0)
                    expenses.items.append(testItem)
                }
            }
            
        }
        
    }
    
    func removeExpense(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
