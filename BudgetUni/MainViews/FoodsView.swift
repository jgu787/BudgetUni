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
    @State private var region = MKCoordinateRegion()
    @State private var restaurants: [MKMapItem] = []
    @State private var selectedRestaurant: MKMapItem?
    
    var body: some View {
        Map(position: $cameraPosition) {
            UserAnnotation()
        }
        .mapControls{
            MapUserLocationButton()
        }
        .onAppear{
            manager.requestWhenInUseAuthorization()
        }
    }
    
}

#Preview {
    FoodsView()
}
