//
//  RestaurantHelper.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 9/12/23.
//

import Foundation
import SwiftUI

struct RestaurantHelper {
//    static func convertDataToHours(from hoursArray: [Hours]?) -> String {
//        let currentDayOfWeek = getCurrentDayOfWeek()
//        if let hoursForDay = hoursArray?[0].open {
//            let index = hoursForDay.firstIndex(where: { $0.day == currentDayOfWeek })
//            let startHours = convertMilitaryTimeToNormalTime(militaryTime: hoursForDay[index ?? 0].start)
//            let endHours = convertMilitaryTimeToNormalTime(militaryTime: hoursForDay[index ?? 0].end)
//            if let startHours = startHours, let endHours = endHours {
//                return startHours + "-" + endHours
//            }
//        }
//        return "No hours available."
//    }
    
    static func getCurrentDayOfWeek() -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: currentDate)
        return (weekday + 5) % 7
    }
    
    static func convertMilitaryTimeToNormalTime(militaryTime: String) -> String? {
        let startIndex = militaryTime.index(militaryTime.startIndex, offsetBy: 0)
        let endIndex = militaryTime.index(militaryTime.startIndex, offsetBy: 2)
        let hourSubstring = militaryTime[startIndex..<endIndex]
        let startIndexMinutes = militaryTime.index(militaryTime.startIndex, offsetBy: 2)
        let endIndexMinutes = militaryTime.index(militaryTime.startIndex, offsetBy: 4)
        let minutesSubstring = militaryTime[startIndexMinutes..<endIndexMinutes]
        if let hour = Int(hourSubstring), let minutes = Int(minutesSubstring) {
            let isPM = hour >= 12
            let formattedHour: Int
            if hour == 0 || hour == 12 {
                formattedHour = 12
            } else {
                formattedHour = isPM ? hour - 12 : hour
            }
            let amPmString = isPM ? "PM" : "AM"
            return String(format: "%d:%02d %@", formattedHour, minutes, amPmString)
        }
        return nil
    }
    
//    static func convertRatingToStars(from rating: Double) -> Text {
//        var starsText = Text("")
//        let flooredRating = Int(floor(rating))
//        for _ in 0..<flooredRating {
//            starsText = starsText + Text(Image(systemName: "star.fill")).foregroundColor(.yellow)
//        }
//        if ceil(rating) > floor(rating) {
//            starsText = starsText + Text(Image(systemName: "star.leadinghalf.filled")).foregroundColor(.yellow)
//        }
//        let remainingStars = 5 - Int(ceil(rating))
//        for _ in 0..<remainingStars {
//            starsText = starsText + Text(Image(systemName: "star")).foregroundColor(.gray)
//        }
//        return starsText
//    }
    
//    static func convertPriceToDollarSign(using price: String) -> Text {
//        if price.count == 1 {
//            return Text("$") + Text("$$").foregroundColor(.gray)
//        } else if price.count == 2 {
//            return Text("$$") + Text("$").foregroundColor(.gray)
//        } else {
//            return Text(price)
//        }
//    }
}
