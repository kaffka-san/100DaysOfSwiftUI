//
//  ContentView.swift
//  iExpense
//
//  Created by Anastasia Lenina on 21.06.2023.
//

import SwiftUI



struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpenses = false
    @State private var amountColor = Color.black
    var personalExpensesNotEmpty : Bool {
        !expenses.personalItems.isEmpty
    }
    var businessExpensesNotEmpty : Bool {
        !expenses.businessItems.isEmpty
    }
    var body: some View {
        NavigationView {
            List{
                if personalExpensesNotEmpty{
                    SectionView(itemArray: expenses.personalItems,
                                deleteFunc: deletePersonalItems,
                                headerText: "Personal expenses")
                }
                if businessExpensesNotEmpty{
                    SectionView(itemArray: expenses.businessItems,
                                deleteFunc: deleteBusinessItems(at:),
                                headerText: "Business expenses")
                }
            }
            .navigationTitle("iExpense")
            .toolbar{
                Button {
                    showingAddExpenses = true
                } label: {
                    Image(systemName: "plus")
                }
                
            }
            .sheet(isPresented: $showingAddExpenses) {
                AddView(expenses: expenses)
            }
        }
    }
    func deleteItems(at offsets: IndexSet, on array: [ExpenseItem]){
        var indexes = IndexSet()
        for offset in offsets{
            let object = array[offset]
            if let indexObject = expenses.items.firstIndex(of: object){
                indexes.insert(indexObject)
            }
        }
        expenses.items.remove(atOffsets: indexes)
    }
    func deletePersonalItems(at offsets: IndexSet){
        deleteItems(at: offsets, on: expenses.personalItems)
    }
    func deleteBusinessItems(at offsets: IndexSet){
        deleteItems(at: offsets, on: expenses.businessItems)
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
