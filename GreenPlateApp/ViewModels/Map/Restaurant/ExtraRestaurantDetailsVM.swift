//
//  ExtraRestaurantDetailsVM.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/3/23.
//

import Foundation

@MainActor
final class ExtraRestaurantDetailsVM: ObservableObject {
    private let reviewsApiClient = ReviewsApiClient()
    private let restaurantHoursClient = RestaurantHoursApiClient()
    @Published var reviewsArray = [ReviewDetails]()
    @Published var hoursArray: [Hours]?
    @Published var isDataLoaded = false
    @Published var triggerAlert = false
    @Published var alertMessage = ""

    var formattedHours: String {
        let currentDayOfWeek = RestaurantHelper.getCurrentDayOfWeek()
        if let hoursForDay = hoursArray?[0].open {
            let index = hoursForDay.firstIndex(where: { $0.day == currentDayOfWeek })
            let startHours = RestaurantHelper.convertMilitaryTimeToNormalTime(militaryTime: hoursForDay[index ?? 0].start)
            let endHours = RestaurantHelper.convertMilitaryTimeToNormalTime(militaryTime: hoursForDay[index ?? 0].end)
            if let startHours = startHours, let endHours = endHours {
                return startHours + " - " + endHours
            }
        }
        return "No hours available."
    }
    
    func getReviews(fromId id: String) async {
        do {
            let reviewData = try await reviewsApiClient.getReviews(restaurantId: id)
            if let reviewData = reviewData {
                self.reviewsArray = reviewData
            }
        } catch ApiError.invalidURL {
            self.triggerAlert = true
            self.alertMessage = "Unresolved issue. We're working on fixing it."
        } catch ApiError.invalidResponse {
            self.triggerAlert = true
            self.alertMessage = "Server error. Try again later."
        } catch ApiError.invalidData {
            self.triggerAlert = true
            self.alertMessage = "There was a problem finding all of the information."
        } catch {
            self.triggerAlert = true
            self.alertMessage = "Unexpected problem. Try again."
        }
    }
    
    func getTimes(fromId id: String) async {
        do {
            let hourData = try await restaurantHoursClient.getHours(restaurantId: id)
            if let hourData = hourData {
                self.hoursArray = hourData
            }
        } catch ApiError.invalidURL {
            self.triggerAlert = true
            self.alertMessage = "Unresolved issue. We're working on fixing it."
        } catch ApiError.invalidResponse {
            self.triggerAlert = true
            self.alertMessage = "Server error. Try again later."
        } catch ApiError.invalidData {
            self.triggerAlert = true
            self.alertMessage = "Problem getting restaurant hours."
        } catch {
            self.triggerAlert = true
            self.alertMessage = "Unexpected problem. Try again."
        }
    }
}
