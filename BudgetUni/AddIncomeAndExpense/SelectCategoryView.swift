//
//  SelectCategoryView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-06-17.
//

import SwiftUI

struct SelectCategoryView: View {
    @Binding var selectedCategory: String
    
    // options for category user can choose
    let options = ["Food","Living","Personal","Education",
                   "Misc"]
    
    var body: some View {
        HStack {
            Text("Category:")
                .bold()
            
            Spacer()
            
            // picker to select category
            Picker("Category", selection: $selectedCategory) {
                ForEach(options, id: \.self) { option in
                    Button(option) {
                        selectedCategory = option
                    }.tag(option)
                    
                }
            }
        }
    }
}

#Preview {
    SelectCategoryView(selectedCategory: .constant("Personal"))
}
