//
//  HistoryView.swift
//  BudgetUni
//
//  Created by Yang Ming Huang on 2025-06-10.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    
    @Environment(\.modelContext) private var context
    
    // Query fetches data from database
    @Query(filter: #Predicate<BudgetingTools> { _ in true }, animation: .default) private var items: [BudgetingTools]
    
    var body: some View {
        VStack(spacing: 35) {
            
            Text("Spending").font(.title)
            
            Divider()
            
            List {
                ForEach(items) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        Text("$\(item.expenseAmount, specifier: "%.2f")")
                            .foregroundColor(.red)
                    }
                }
                .onDelete { indexes in
                    for index in indexes {
                        deleteItem(items[index])
                    }
                }
            }
            
            Divider()
        }
        .padding()
    }

    // Delete item
    func deleteItem(_ item: BudgetingTools) {
        context.delete(item)
        do {
            try context.save()
            print("Deleted item: \(item.name)")
        } catch {
            print("Failed to delete item: \(error.localizedDescription)")
        }
    }
}

#Preview {
    HistoryView()
}
