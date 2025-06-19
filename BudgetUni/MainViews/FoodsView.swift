//
//  FoodsView.swift
//  BudgetUni
//
//  Created by Jiamin Gu on 2025-06-15.
//

// this view features a map for user to
//search up destinations to spend money
import SwiftUI
import MapKit

struct FoodsView: View {
    let manager = CLLocationManager()
    @State private var cameraPosition: MapCameraPosition =
        .userLocation(fallback: .automatic)
    
    var body: some View {
        Map(position: $cameraPosition) {
            UserAnnotation()
        }
        // button at top right to bring user
        // back to their current location
        .mapControls{
            MapUserLocationButton()
        }
        .onAppear{
            // requests the user's location to showcase
            // areas of interest nearby
            manager.requestWhenInUseAuthorization()
        }
    }
    
}

#Preview {
    FoodsView()
}
