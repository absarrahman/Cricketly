//
//  MatchDetailsViewModel.swift
//  Cricketly
//
//  Created by BJIT  on 15/2/23.
//

import Foundation


class MatchDetailsViewModel {
    @Published var venueImageUrl: String?
    
    @Published var seriesInfoCellDataList: [MatchInfoTableViewCellModel] = []
    @Published var venueInfoCellDataList: [MatchInfoTableViewCellModel] = []
    
    @Published var error: Error?
    
    
    private func fetchFixtureDetailsFrom(id: Int, completion: @escaping (Result<FixtureDetailsModel?,Error>) -> ()) {
        Service.shared.getFixtureById(id: id) {[weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                self.venueImageUrl = data?.venue?.imagePath
                completion(.success(data))
            case .failure(let error):
                print("ERROR OCCURRED \(error)")
                completion(.failure(error))
            }
            
        }
    }
    
    func fetchMatchInfo(id: Int) {
        
        fetchFixtureDetailsFrom(id: id) {[weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                //                self.matchInfoCellDataList = [
                //                    [
                //                        // MATCH ROUND
                //                        MatchInfoTableViewCellModel(title: "Match", content: data?.round ?? "N/A"),
                //
                //                        // SERIES
                //
                //                        MatchInfoTableViewCellModel(title: "Series", content: "\(data?.league?.name ?? "N/A") \(data?.season?.name ?? "")"),
                //
                //                        // Date
                //                        // TODO: Need to parse date and time
                //                        MatchInfoTableViewCellModel(title: "Date", content: data?.startingAt ?? "N/A"),
                //
                //                        // Date
                //                        // TODO: Need to parse date and time
                //                        MatchInfoTableViewCellModel(title: "Date", content: data?.startingAt ?? "N/A"),
                //
                //                        // Time
                //                        // TODO: Need to parse date and time
                //                        MatchInfoTableViewCellModel(title: "Time", content: "[2:03pm]"),
                //
                //                        // Toss
                //                        MatchInfoTableViewCellModel(title: "Toss", content: "\(data?.tosswon?.name ?? "N/A") opt to \(data?.elected ?? "N/A")"),
                //
                //                        // Umpire
                //
                //                        MatchInfoTableViewCellModel(title: "Umpires", content: "\(data?.firstumpire?.fullname ?? "N/A"), \(data?.secondumpire?.fullname ?? "N/A")"),
                //
                //                        // Third umpire
                //                        MatchInfoTableViewCellModel(title: "Third", content: "\(data?.tvumpire?.fullname ?? "N/A")"),
                //
                //                        // Referee
                //                        MatchInfoTableViewCellModel(title: "Referee", content: "\(data?.referee?.fullname ?? "N/A")")
                //
                //                    ],
                //                    // venue
                //                    [
                //                        // Name
                //                        MatchInfoTableViewCellModel(title: "Stadium", content: "\(data?.venue?.name ?? "N/A")"),
                //                        // City
                //                        MatchInfoTableViewCellModel(title: "City", content: "\(data?.venue?.city ?? "N/A")"),
                //                        // Capacity
                //                        MatchInfoTableViewCellModel(title: "Capacity", content: "\(data?.venue?.capacity?.description ?? "N/A")"),
                //
                //                    ]
                //                ]
                self.seriesInfoCellDataList = [
                    // MATCH ROUND
                    MatchInfoTableViewCellModel(title: "Match", content: data?.round ?? "N/A"),
                    
                    // SERIES
                    
                    MatchInfoTableViewCellModel(title: "Series", content: "\(data?.league?.name ?? "N/A") \(data?.season?.name ?? "")"),
                    
                    // Date
                    // TODO: Need to parse date and time
                    MatchInfoTableViewCellModel(title: "Date", content: data?.startingAt ?? "N/A"),
                    
                    // Time
                    // TODO: Need to parse date and time
                    MatchInfoTableViewCellModel(title: "Time", content: "[2:03pm]"),
                    
                    // Toss
                    MatchInfoTableViewCellModel(title: "Toss", content: "\(data?.tosswon?.name ?? "N/A") opt to \(data?.elected ?? "N/A")"),
                    
                    // Umpire
                    
                    MatchInfoTableViewCellModel(title: "Umpires", content: "\(data?.firstumpire?.fullname ?? "N/A"), \(data?.secondumpire?.fullname ?? "N/A")"),
                    
                    // Third umpire
                    MatchInfoTableViewCellModel(title: "Third", content: "\(data?.tvumpire?.fullname ?? "N/A")"),
                    
                    // Referee
                    MatchInfoTableViewCellModel(title: "Referee", content: "\(data?.referee?.fullname ?? "N/A")")
                    
                ]
                self.venueInfoCellDataList = [
                    // Name
                    MatchInfoTableViewCellModel(title: "Stadium", content: "\(data?.venue?.name ?? "N/A")"),
                    // City
                    MatchInfoTableViewCellModel(title: "City", content: "\(data?.venue?.city ?? "N/A")"),
                    // Capacity
                    MatchInfoTableViewCellModel(title: "Capacity", content: "\(data?.venue?.capacity?.description ?? "N/A")"),
                    
                ]
            case .failure(let error):
                self.error = error
            }
        }
    }
    
}
