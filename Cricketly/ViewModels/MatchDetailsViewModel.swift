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
    let matchStatus: String
}

class MatchDetailsViewModel {
    var venueImageUrl: String?
    
    var matchStatus: Status = .ns
    var isSquadAvailable = false
    var isScoreboardAvailable = false
    
    // INFO
    var seriesInfoCellDataList: [MatchInfoTableViewCellModel] = []
    var venueInfoCellDataList: [MatchInfoTableViewCellModel] = []
    
    // Scoreboard
    var firstTeamBattingCellModels: [ScoreTableViewCellModel] = []
    var secondTeamBattingCellModels: [ScoreTableViewCellModel] = []
    var firstTeamBowlingCellModels: [ScoreTableViewCellModel] = []
    var secondTeamBowlingCellModels: [ScoreTableViewCellModel] = []
    
    
    //    //TEAM NAMES
    //    @Published var localTeamName: String = ""
    //    @Published var visitorTeamName: String = ""
    var teamModels: [TeamViewDataModel] = []
    
    
    // SQUAD
    var localTeamSquadCellModels: [SquadCollectionCellModel] = []
    var visitorTeamSquadCellModels: [SquadCollectionCellModel] = []
    
    @Published var error: Error?
    
    @Published var loadingStatus: LoadingStatus = .notStarted
    
    func fetchMatchStatusBy(id: Int) {
        fetchFixtureDetailsFrom(id: id) {[weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                guard let data = data, let runs = data.runs, let lineup = data.lineup else { return }
                self.isSquadAvailable = !lineup.isEmpty
                self.isScoreboardAvailable = !runs.isEmpty
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchFixtureDetailsFrom(id: Int, completion: @escaping (Result<FixtureDetailsModel?,Error>) -> ()) {
        
        loadingStatus = .loading
        
        Service.shared.getFixtureById(id: id) {[weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                self.venueImageUrl = data?.venue?.imagePath
                
                if (data?.runs?.count ?? 0) != 0 {
                    let firstTeamBatting = data?.batting?.first { batting in
                        batting.teamID == data?.runs?.first?.teamID
                    }
                    let secondTeamBatting = data?.batting?.first { batting in
                        batting.teamID == data?.runs?.last?.teamID
                    }
                    
                    let localTeamDataModel = TeamViewDataModel(teamName: firstTeamBatting?.team?.name ?? "", teamImgUrl: firstTeamBatting?.team?.imagePath ?? "", teamScore: "\(data?.runs?[0].score?.description ?? "")-\(data?.runs?[0].wickets?.description ?? "") \n \(data?.runs?[0].overs?.description ?? "")", teamCode: firstTeamBatting?.team?.code ?? "", teamID: firstTeamBatting?.team?.id ?? -1, matchStatus: data?.status?.rawValue ?? "")
                    
                    let visitorTeamDataModel = TeamViewDataModel(teamName: secondTeamBatting?.team?.name ?? "", teamImgUrl: secondTeamBatting?.team?.imagePath ?? "", teamScore: "\(data?.runs?[1].score?.description ?? "")-\(data?.runs?[1].wickets?.description ?? "") \n \(data?.runs?[1].overs?.description ?? "")", teamCode: secondTeamBatting?.team?.code ?? "", teamID: secondTeamBatting?.team?.id ?? -1, matchStatus: data?.status?.rawValue ?? "")
                    
                    self.teamModels = [localTeamDataModel, visitorTeamDataModel]
                }
                
                completion(.success(data))
                self.loadingStatus = .finished
                print("DONE")
            case .failure(let error):
                print("ERROR OCCURRED \(error)")
                completion(.failure(error))
                self.loadingStatus = .loadingFailed
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
    
    fileprivate func getPlayerNoteUsing(batting: Batting) -> String {
        let result = batting.result?.name ?? ""
        var catchStumpName = ""
        var bowlerName = ""
        if let catchStumpLastName = batting.catchstump?.lastname {
            catchStumpName = "c \(catchStumpLastName) "
        }
        if let bowlerLastName = batting.bowler?.lastname {
            bowlerName = "b \(bowlerLastName)"
        }
        return "\(result)\n\(catchStumpName)\(bowlerName)"
    }
    
    fileprivate func generateScoreBoard(_ firstTeamBatting: [Batting]?, _ secondTeamBatting: [Batting]?, _ firstTeamBowling: [Bowling]?, _ secondTeamBowling: [Bowling]?) {
        
        firstTeamBattingCellModels = firstTeamBatting?.compactMap({ batting in
            ScoreTableViewCellModel(id: batting.playerID ?? -1, imgUrl: batting.batsman?.imagePath ?? "", playerName: batting.batsman?.lastname ?? "", playerNote: getPlayerNoteUsing(batting: batting), stackInfos: [
                batting.score?.description,
                batting.ball?.description,
                batting.fourX?.description,
                batting.sixX?.description,
                batting.rate?.description
            ])
        }) ?? []
        
        secondTeamBattingCellModels = secondTeamBatting?.compactMap({ batting in
            ScoreTableViewCellModel(id: batting.playerID ?? -1, imgUrl: batting.batsman?.imagePath ?? "", playerName: batting.batsman?.lastname ?? "", playerNote: getPlayerNoteUsing(batting: batting), stackInfos: [
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
                let firstTeamBatting = data?.batting?.filter({ batting in
                    batting.teamID == data?.runs?.first?.teamID
                })
                let secondTeamBatting = data?.batting?.filter({ batting in
                    batting.teamID == data?.runs?.last?.teamID
                })
                
                // last batting == first bowling
                let firstTeamBowling = data?.bowling?.filter({ bowling in
                    bowling.teamID == data?.runs?.last?.teamID
                })
                
                let secondTeamBowling = data?.bowling?.filter({ bowling in
                    bowling.teamID == data?.runs?.first?.teamID
                })
                
                self.generateScoreBoard(firstTeamBatting, secondTeamBatting, firstTeamBowling, secondTeamBowling)
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchSquadDetails(id: Int)  {
        
        fetchFixtureDetailsFrom(id: id) {[weak self] results in
            guard let self = self else { return }
            
            switch results {
            case .success(let data):
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
