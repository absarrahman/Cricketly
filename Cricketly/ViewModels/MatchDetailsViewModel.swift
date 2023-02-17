//
//  MatchDetailsViewModel.swift
//  Cricketly
//
//  Created by BJIT  on 15/2/23.
//

import Foundation

struct TeamViewDataModel {
    let teamName: String
    let teamImgUrl: String
    let teamScore: String
    let teamCode: String
    let teamID: Int
}

class MatchDetailsViewModel {
    @Published var venueImageUrl: String?
    
    // INFO
    @Published var seriesInfoCellDataList: [MatchInfoTableViewCellModel] = []
    @Published var venueInfoCellDataList: [MatchInfoTableViewCellModel] = []
    
    // Scoreboard
    @Published var firstTeamBattingCellModels: [ScoreTableViewCellModel] = []
    @Published var secondTeamBattingCellModels: [ScoreTableViewCellModel] = []
    @Published var firstTeamBowlingCellModels: [ScoreTableViewCellModel] = []
    @Published var secondTeamBowlingCellModels: [ScoreTableViewCellModel] = []
    
    
//    //TEAM NAMES
//    @Published var localTeamName: String = ""
//    @Published var visitorTeamName: String = ""
    @Published var teamModels: [TeamViewDataModel] = []
    
    
    // SQUAD
    @Published var localTeamSquadCellModels: [SquadCollectionCellModel] = []
    @Published var visitorTeamSquadCellModels: [SquadCollectionCellModel] = []
    
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
    
    fileprivate func generateScoreBoard(_ firstTeamBatting: [Batting]?, _ secondTeamBatting: [Batting]?, _ firstTeamBowling: [Bowling]?, _ secondTeamBowling: [Bowling]?) {
        
        firstTeamBattingCellModels = firstTeamBatting?.compactMap({ batting in
            ScoreTableViewCellModel(id: batting.playerID ?? -1, imgUrl: batting.batsman?.imagePath ?? "", playerName: batting.batsman?.lastname ?? "", playerNote: "", stackInfos: [
                batting.score?.description,
                batting.ball?.description,
                batting.fourX?.description,
                batting.sixX?.description,
                batting.rate?.description
            ])
        }) ?? []
        
        secondTeamBattingCellModels = secondTeamBatting?.compactMap({ batting in
            ScoreTableViewCellModel(id: batting.playerID ?? -1, imgUrl: batting.batsman?.imagePath ?? "", playerName: batting.batsman?.lastname ?? "", playerNote: "", stackInfos: [
                batting.score?.description,
                batting.ball?.description,
                batting.fourX?.description,
                batting.sixX?.description,
                batting.rate?.description
            ])
        }) ?? []
        
        firstTeamBowlingCellModels = firstTeamBowling?.compactMap({ bowling in
            ScoreTableViewCellModel(id: bowling.playerID ?? -1, imgUrl: bowling.bowler?.imagePath ?? "", playerName: bowling.bowler?.lastname ?? "", playerNote: "", stackInfos: [
                bowling.overs?.description,
                bowling.medians?.description,
                bowling.runs?.description,
                bowling.wickets?.description,
                bowling.rate?.description
            ])
        }) ?? []
        
        secondTeamBowlingCellModels = secondTeamBowling?.compactMap({ bowling in
            ScoreTableViewCellModel(id: bowling.playerID ?? -1, imgUrl: bowling.bowler?.imagePath ?? "", playerName: bowling.bowler?.lastname ?? "", playerNote: "", stackInfos: [
                bowling.overs?.description,
                bowling.medians?.description,
                bowling.runs?.description,
                bowling.wickets?.description,
                bowling.rate?.description
            ])
        }) ?? []
    }
    
    func fetchMatchScore(id: Int) {
        fetchFixtureDetailsFrom(id: id) {[weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                print(data?.batting)
                let firstTeamBatting = data?.batting?.filter({ batting in
                    batting.teamID == data?.runs?.first?.teamID
                })
                let secondTeamBatting = data?.batting?.filter({ batting in
                    batting.teamID == data?.runs?.last?.teamID
                })
                
                let localTeamDataModel = TeamViewDataModel(teamName: firstTeamBatting?.first?.team?.name ?? "", teamImgUrl: firstTeamBatting?.first?.team?.imagePath ?? "", teamScore: "\(data?.runs?[0].score?.description ?? "")-\(data?.runs?[0].wickets?.description ?? "") \n \(data?.runs?[0].overs?.description ?? "")", teamCode: firstTeamBatting?.first?.team?.code ?? "", teamID: firstTeamBatting?.first?.team?.id ?? -1)
                
                let visitorTeamDataModel = TeamViewDataModel(teamName: secondTeamBatting?.first?.team?.name ?? "", teamImgUrl: secondTeamBatting?.first?.team?.imagePath ?? "", teamScore: "\(data?.runs?[1].score?.description ?? "")-\(data?.runs?[1].wickets?.description ?? "") \n \(data?.runs?[1].overs?.description ?? "")", teamCode: secondTeamBatting?.first?.team?.code ?? "", teamID: secondTeamBatting?.first?.team?.id ?? -1)
                self.teamModels = [localTeamDataModel, visitorTeamDataModel]
//                self.localTeamName = "\(firstTeamBatting?.first?.team?.name ?? "") \n \(data?.runs?[0].score?.description ?? "")-\(data?.runs?[0].wickets?.description ?? "")"
//                self.visitorTeamName = "\(secondTeamBatting?.first?.team?.name ?? "") \n \(data?.runs?[1].score?.description ?? "")-\(data?.runs?[1].wickets?.description ?? "")"
//                print(firstTeamBatting?.count,secondTeamBatting?.count)
                
                // last batting == first bowling
                let firstTeamBowling = data?.bowling?.filter({ bowling in
                    bowling.teamID == data?.runs?.last?.teamID
                })
                
                let secondTeamBowling = data?.bowling?.filter({ bowling in
                    bowling.teamID == data?.runs?.first?.teamID
                })
                
                self.generateScoreBoard(firstTeamBatting, secondTeamBatting, firstTeamBowling, secondTeamBowling)
                
//                let firstTeamBatting = data?.batting?.filter({ batting in
//                    batting.teamID == data?.runs?.first?.teamID
//                })
//                let secondTeamBatting = data?.batting?.filter({ batting in
//                    batting.teamID == data?.runs?.last?.teamID
//                })
                
                let localTeamSquad = data?.lineup?.filter({ player in
                    player.lineup?.teamID == data?.runs?.first?.teamID
                })
                
                let visitorTeamSquad = data?.lineup?.filter({ player in
                    player.lineup?.teamID == data?.runs?.last?.teamID
                })
                
                self.localTeamSquadCellModels = localTeamSquad?.compactMap({ player in
                    SquadCollectionCellModel(id: player.id ?? -1, name: player.lastname ?? "", position: player.position?.name?.rawValue ?? "", isCaptain: player.lineup?.captain ?? false, isWicketKeeper: player.lineup?.wicketkeeper ?? false, imageUrl: player.imagePath ?? "")
                }) ?? []
                
                self.visitorTeamSquadCellModels = visitorTeamSquad?.compactMap({ player in
                    SquadCollectionCellModel(id: player.id ?? -1, name: player.lastname ?? "", position: player.position?.name?.rawValue ?? "", isCaptain: player.lineup?.captain ?? false, isWicketKeeper: player.lineup?.wicketkeeper ?? false, imageUrl: player.imagePath ?? "")
                }) ?? []
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}