//
//  SideMenuHeaderView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-05-15.
//

import SwiftUI

struct SideMenuHeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .imageScale(.large)
                .foregroundStyle(.white)
                .frame(width:48,height:48)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.vertical)
            VStack(alignment: .leading, spacing:6){
                Text("BudgetUni")
                    .font(.headline)
                
            }
        }
    }
}

#Preview {
    SideMenuHeaderView()
}
