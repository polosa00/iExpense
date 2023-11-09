//
//  ContentView.swift
//  iExpense
//
//  Created by Александр Полочанин on 9.11.23.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
            }
        }
        
        items = []
    }
    
    
    
}

struct ContentView: View {
    @State private var showingAddExpense = false
    
    @State private var expenses = Expenses()
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(expenses.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                                
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: "BYN"))
                        }
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
