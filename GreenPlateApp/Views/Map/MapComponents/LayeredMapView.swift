//
//  MapView.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/30/23.
//

import SwiftUI
import MapKit

struct LayeredMapView: View {
    @StateObject private var restaurantFinderVM = RestaurantFinderVM()
    @StateObject var mapVM: MapVM
    @ObservedObject private var locationManager: LocationManager
    @GestureState var dragOffset: CGFloat = 0
    @State var searchText = ""
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        self._mapVM = StateObject(wrappedValue: MapVM(restaurantRegion: locationManager.locationRegion))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                GeometryReader { outerView in
                    self.map
                    self.searchBar
                    self.carouselSectionView(
                        outerView: outerView
                    )
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            .alert(isPresented: $restaurantFinderVM.triggerAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(restaurantFinderVM.alertMessage),
                    dismissButton: .default(Text("OK")) {
                        restaurantFinderVM.triggerAlert = false
                    })
            }
            .navigationBar("GreenPlate")
        }
        .task {
            let urlString = restaurantFinderVM.generateUrlFromLocation()
            await restaurantFinderVM.findRestaurants(usingUrl: urlString)
            mapVM.setRestaurantRegion(restaurantsArray: restaurantFinderVM.restaurantArray)
        }
    }
}

extension LayeredMapView {
    private var map: some View {
        MapView(
            mapVM: mapVM,
            restaurants: restaurantFinderVM.restaurantArray
        )
        .gesture(DragGesture()
            .onChanged { _ in
                if !mapVM.isUserInteracting {
                    mapVM.userIsInteracting()
                }
            }
        )
    }
    
    private var searchBar: some View {
        SearchBarView(
            searchText: $searchText,
            searchDescription: "Locations",
            handleSearch: self.handleSearchRequest
        )
        .padding(.horizontal, 10)
        .padding(.top, 15)
    }
}

extension LayeredMapView {
    private func carouselSectionView(outerView: GeometryProxy) -> some View {
            CarouselSectionView(
                mapVM: mapVM,
                outerView: outerView,
                restaurantFinderVM: restaurantFinderVM
            )
            .onAppear {
                mapVM.setRestaurantRegion(restaurantsArray: restaurantFinderVM.restaurantArray)
            }
            .offset(x: -CGFloat(mapVM.currentRestaurantCardIndex) * outerView.size.width)
            .offset(x: dragOffset)
            .gesture(
                DragGesture()
                    .updating($dragOffset, body: { (value, state, transaction) in
                        state = value.translation.width
                    })
                    .onEnded({ (value) in
                        let threshold = outerView.size.width * 0.5
                        let newIndex = Int(-value.translation.width / threshold) + mapVM.currentRestaurantCardIndex
                        mapVM.handleUserSwipe(newIndex: newIndex, restaurants: restaurantFinderVM.restaurantArray)
                    })
            )
            .animation(.interpolatingSpring(mass: 0.6, stiffness: 100, damping: 10, initialVelocity: 0.3), value: dragOffset)
        }
}

extension LayeredMapView {
    private func handleSearchRequest() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        if searchText != "" {
            let urlString = restaurantFinderVM.generateUrlFromSearch(searchLocation: searchText)
            Task {
                await restaurantFinderVM.findRestaurants(usingUrl: urlString)
                mapVM.updateIndex()
                mapVM.setRestaurantRegion(restaurantsArray: restaurantFinderVM.restaurantArray)
            }
            self.searchText = ""
        }
    }
}
