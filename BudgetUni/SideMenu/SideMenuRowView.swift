//
//  SideMenuRowView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-15.
//
// creates each tab in the side menu

import SwiftUI

struct SideMenuRowView: View {
    let option: SideMenuOptionModel
    @Binding var selectedOption: SideMenuOptionModel?
    
    private var isSelected: Bool {
        return selectedOption == option
    }
    
    var body: some View {
        HStack {
            Image(systemName: option.SystemImageName)
                .imageScale(.small)
            Text(option.title)
                .font(.subheadline)
            Spacer()
        }
        .padding(.leading)
        // turns the tab blue if selected
        .foregroundStyle(isSelected ? .blue : .primary)
        .frame(width: 216, height:44)
        .background(isSelected ? .blue.opacity(0.15): .clear)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    SideMenuRowView(option: .home, selectedOption: .constant(.home))
}
