//
//  AddView.swift
//  iExpense
//
//  Created by Александр Полочанин on 9.11.23.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Business", "Personal"]
    
    var expenses: Expenses
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                Picker("Types", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: "BYN"))
                    .keyboardType(.decimalPad)
                    
            }
            .toolbar{
                Button("Done") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
            .navigationTitle("Add new expense")
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
