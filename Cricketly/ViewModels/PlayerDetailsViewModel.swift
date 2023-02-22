//
//  PlayerDetailsViewModel.swift
//  Cricketly
//
//  Created by BJIT  on 20/2/23.
//

import Foundation

//"matches": 3,
//                   "overs": 10.5,
//                   "innings": 3,
//                   "average": 47.5,
//                   "econ_rate": 9.05,
//                   "medians": 0,
//                   "runs": 95,
//                   "wickets": 2,
//                   "wide": 1,
//                   "noball": 0,
//                   "strike_rate": 5.25,
//                   "four_wickets": 0,
//                   "five_wickets": 0,
//                   "ten_wickets": 0,
//                   "rate": 837.9966666666666
struct BowlingCareerModel {
    let matches: Int
    let overs: Double
    let innings: Int
    let average: Double
    let econRate: Double
    let medians: Int
    let runs: Int
    let wickets: Int
    let wide: Int
    let noBall: Int
    let strikeRate: Double
    let rate: Double
}

struct CareerCollectionCellModel {
    let careerType: String
    let season: String
    let bowlingCareer: BowlingCareerModel
    init(career: Career) {
        self.careerType = career.type ?? ""
        self.bowlingCareer = BowlingCareerModel(matches: Int(career.bowling?["matches"] ?? 0), overs: career.bowling?["overs"] ?? 0, innings: Int(career.bowling?["innings"] ?? 0), average: career.bowling?["average"] ?? 0, econRate: career.bowling?["econ_rate"] ?? 0, medians: Int(career.bowling?["medians"] ?? 0), runs: Int(career.bowling?["runs"] ?? 0), wickets: Int(career.bowling?["wickets"] ?? 0), wide: Int(career.bowling?["wide"] ?? 0), noBall: Int(career.bowling?["noball"] ?? 0), strikeRate: career.bowling?["strike_rate"] ?? 0, rate: career.bowling?["rate"] ?? 0)
        self.season = CommonFunctions.getFormattedYear(from: career.updatedAt ?? "") ?? ""
    }
}

class PlayerDetailsViewModel {
    var playerName: String?
    var playerCountry: String?
    var countryImgUrl: String?
    var playerImgUrl: String?
    @Published var loadStatus: LoadingStatus = .notStarted
    var personalInfoCellsModel: [MatchInfoTableViewCellModel] = []
    
    var careerData: [CareerCollectionCellModel] = []
    
    func fetchPlayerBasicInfo(id: Int) {
        loadStatus = .loading
        Service.shared.getPlayerById(id: id) {[weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self.playerName = data.fullname
                self.playerCountry = data.country?.name
                self.countryImgUrl = data.country?.imagePath
                self.playerImgUrl = data.imagePath
                self.loadStatus = .finished
            case .failure(let error):
                print(error)
                self.loadStatus = .loadingFailed
            }
        }
    }
    
    func fetchPlayerInfo(id: Int) {
        loadStatus = .loading
        Service.shared.getPlayerById(id: id) {[weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self.personalInfoCellsModel = [
                    // BORN
                    MatchInfoTableViewCellModel(title: "Born", content: data.dateofbirth ?? "N/A"),
                    // Nickname
                    MatchInfoTableViewCellModel(title: "Nickname", content: data.lastname ?? "N/A"),
                    // ROLE
                    MatchInfoTableViewCellModel(title: "Role", content: data.position?.name?.rawValue ?? "N/A"),
                    
                    //Batting style
                    MatchInfoTableViewCellModel(title: "Batting Style", content: data.battingstyle?.capitalized ?? "N/A"),
                    
                    //Bowling Style
                    MatchInfoTableViewCellModel(title: "Bowling Style", content: data.bowlingstyle?.capitalized ?? "N/A")
                    
                ]
                self.loadStatus = .finished
            case .failure(let error):
                print(error)
                self.loadStatus = .loadingFailed
            }
        }
    }
    
    func fetchPlayerCareerInfo(id: Int) {
        loadStatus = .loading
        
        Service.shared.getPlayerById(id: id) {[weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self.careerData = data.career?.compactMap({ career in
                    CareerCollectionCellModel(career: career)
                }) ?? []
                self.loadStatus = .finished
            case .failure(let error):
                print(error)
                self.loadStatus = .loadingFailed
            }
        }
        
    }
}
