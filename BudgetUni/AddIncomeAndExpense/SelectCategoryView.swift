//
//  SelectCategoryView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-06-17.
//

// Imports

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

// Preview saved on right side (not part of app)
#Preview {
    SelectCategoryView(selectedCategory: .constant("Personal"))
}
