//
//  MapsSearchBar.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-06-17.
//

import SwiftUI

// this views contains a search bar
// that allows the user to search for places to eat
struct MapsSearchBar: View {
    @State private var destination = ""
    
    var body: some View {
        HStack {
            Spacer()
            GroupBox {
                HStack {
                    TextField("Search a place to eat!", text: $destination)
                        .frame(width: 200)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        Image(systemName:"magnifyingglass.circle")
                    }
                }
            }
            .shadow(radius: 1)
            Spacer()
        }
    }
}

#Preview {
    MapsSearchBar()
}
