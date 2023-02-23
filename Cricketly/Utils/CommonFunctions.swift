//
//  CommonFunctions.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 3/2/23.
//

import UIKit

class CommonFunctions {
    
    static let dateComponentFormatter: DateComponentsFormatter = {
        let componentsFormatter = DateComponentsFormatter()
        componentsFormatter.allowedUnits = [.day, .hour, .minute, .second]
        componentsFormatter.maximumUnitCount = 7
        componentsFormatter.unitsStyle = .full
        componentsFormatter.zeroFormattingBehavior = .default
        return componentsFormatter
    }()
    
    static func getDifference(from timeString: String) -> DateComponents? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let time = formatter.date(from: timeString) else { return nil }
        
        
        let difference = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: time)
        
        return difference
    }
    
    static var getWindowSafeAreaInsets: UIEdgeInsets? {
        get {
            let window = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            return window?.safeAreaInsets
        }
    }
    
    static func getCurrentDate() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let dateString = df.string(from: date)
        print(dateString)
        return dateString
    }
    
    static func getNextUpcomingDate() -> String{
        let today = Date()
        print(today)
        let modifiedDate = Calendar.current.date(byAdding: .day, value: 60, to: today)!
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let dateString = df.string(from: modifiedDate)
        print(dateString)
        return dateString
    }
    
    static func getVisitorTeamCode(battingTeam: Team?, localTeam: Team?, visitorTeam: Team?) -> (id: Int, code: String, name: String, imgUrl: String) {
        guard let battingTeam = battingTeam, let localTeam = localTeam, let visitorTeam = visitorTeam else { return (-1,"N/A","","") }
        
        return (battingTeam.id ?? -1) != (visitorTeam.id ?? -1) ? ((visitorTeam.id ?? -1),(visitorTeam.code ?? ""),(visitorTeam.imagePath ?? ""),(visitorTeam.imagePath ?? "")) : ((localTeam.id ?? -1),(localTeam.code ?? ""),(localTeam.name ?? ""),(localTeam.imagePath ?? ""))
    }
    
    static func getPreviousDate() -> String {
        let today = Date()
        print(today)
        //        let modifiedDate = Calendar.current.date(byAdding: .day, value: 20, to: today)!
        
        let modifiedDate = Calendar.current.date(byAdding: .day, value: -60, to: today)!
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let dateString = df.string(from: modifiedDate)
        print(dateString)
        return dateString
    }
    
    static func getFormattedYear(from timeString: String) -> String? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let time = formatter.date(from: timeString) else { return nil }
        
        
        let formattedTime = Calendar.current.dateComponents([.year], from: time)
        
        return formattedTime.year?.description
    }
    
    static func calculateWinningPercentage(winCount: Int?, tiesCount: Int?, totalGames: Int?) -> Double {
        guard let winCount = winCount, let tiesCount = tiesCount, let totalGames = totalGames else { return 0 }
        return ((Double(winCount) + (0.5 * Double(tiesCount))) / Double(totalGames))
    }
    
    static func getFormattedDateAndTime(date: Date) -> (date: String, time: String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        
        let localizedDateString = dateFormatter.string(from: date)
        let localizedTimeString = timeFormatter.string(from: date)
        
        return (localizedDateString,localizedTimeString)
    }
    
    
}
