//
//  ContentView.swift
//  iExpense
//
//  Created by Александр Полочанин on 9.11.23.
//

import SwiftUI

struct ExpenseItem: Identifiable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]()
}

struct ContentView: View {
    @State private var showingAddExpense = false
    
    @State private var expenses = Expenses()
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(expenses.items) { item in
                        Text(item.name)
                    }
                    .onDelete(perform: removeExpense)
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
            .navigationTitle("IExpense")
            .toolbar {
                Button("Add Item" , systemImage: "plus") {
                    showingAddExpense = true
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
