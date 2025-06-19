//
//  SaveButtonView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-06-11.
//

import SwiftUI

struct SaveButtonView: View {
    @State private var isValid: Bool = true
    var buttonName: String = "Save"
    var height: Int = 50
    var width: Int = 200
    var cornerRadius: Int = 15
    var font: Font = .title
    var action: () -> Void
    
    var body: some View {
        // Save button
        Button(action: action) {
            // integrate the rounded rectangle as part of the button
            RoundedRectangle(cornerRadius: CGFloat(cornerRadius))
                .frame(width: CGFloat(width),height: CGFloat(height))
                .foregroundStyle(.black)
                .overlay(
                    Text(buttonName)
                        .font(font)
                        .foregroundStyle(.white)
                )
        }
        .disabled(!isValid)
    }
}

#Preview {
    SaveButtonView() {
        print("")
    }
}
