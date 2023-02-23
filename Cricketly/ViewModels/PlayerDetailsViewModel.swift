//
//  PlayerDetailsViewModel.swift
//  Cricketly
//
//  Created by BJIT  on 20/2/23.
//

import Foundation

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


//"batting": {
//                   "matches": 1,
//                   "innings": 1,
//                   "runs_scored": 9,
//                   "not_outs": 0,
//                   "highest_inning_score": 9,
//                   "strike_rate": 90,
//                   "balls_faced": 10,
//                   "average": 9,
//                   "four_x": 0,
//                   "six_x": 0,
//                   "fow_score": 137,
//                   "fow_balls": 18.1,
//                   "hundreds": 0,
//                   "fifties": 0
//               },

struct BattingCareerModel {
    let matches: Int
    let innings: Int
    let runsScored: Int
    let notOuts: Int
    let highestInningScore: Int
    let strikeRate: Double
    let ballsFaced: Int
    let average: Double
    let fourX: Int
    let sixX: Int
    let hundereds: Int
    let fifties: Int
}

struct CareerCollectionCellModel {
    let careerType: String
    let season: String
    let bowlingCareer: BowlingCareerModel
    let battingCareer: BattingCareerModel
    init(career: Career) {
        self.careerType = career.type ?? ""
        self.bowlingCareer = BowlingCareerModel(matches: Int((career.bowling?["matches"] ?? 0) ?? 0), overs: (career.bowling?["overs"] ?? 0) ?? 0, innings: Int((career.bowling?["innings"] ?? 0) ?? 0), average: (career.bowling?["average"] ?? 0) ?? 0, econRate: (career.bowling?["econ_rate"] ?? 0) ?? 0, medians: Int((career.bowling?["medians"] ?? 0) ?? 0), runs: Int((career.bowling?["runs"] ?? 0) ?? 0), wickets: Int((career.bowling?["wickets"] ?? 0) ?? 0), wide: Int((career.bowling?["wide"] ?? 0) ?? 0), noBall: Int((career.bowling?["noball"] ?? 0) ?? 0), strikeRate: (career.bowling?["strike_rate"] ?? 0) ?? 0, rate: (career.bowling?["rate"] ?? 0) ?? 0)
        self.battingCareer = BattingCareerModel(matches: Int((career.batting?["matches"] ?? 0) ?? 0), innings: Int((career.batting?["innings"] ?? 0) ?? 0), runsScored: Int((career.batting?["runs_scored"] ?? 0) ?? 0), notOuts: Int((career.batting?["not_outs"] ?? 0) ?? 0), highestInningScore: Int((career.batting?["highest_inning_score"] ?? 0) ?? 0), strikeRate: (career.batting?["strike_rate"] ?? 0) ?? 0, ballsFaced: Int((career.batting?["balls_faced"] ?? 0) ?? 0), average: (career.batting?["average"] ?? 0) ?? 0, fourX: Int((career.batting?["four_x"] ?? 0) ?? 0), sixX: Int((career.batting?["six_x"] ?? 0) ?? 0), hundereds: Int((career.batting?["hundreds"] ?? 0) ?? 0), fifties: Int((career.batting?["fifties"] ?? 0) ?? 0))
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
