//
//  BrowsePlayersViewModel.swift
//  Cricketly
//
//  Created by BJIT  on 20/2/23.
//

import Foundation

class BrowsePlayersViewModel {
    
    @Published var playerModels: [SquadCollectionCellModel] = []
    @Published var loadingStatus: LoadingStatus = .notStarted
    
    fileprivate func setDataToPlayerModelsFrom(_ playersFromDB: [PlayerRealmModel]) {
        playerModels = playersFromDB.compactMap({ player in
            SquadCollectionCellModel(id: player.id, name: player.fullname ?? "", position: player.countryName ?? "", isCaptain: false, isWicketKeeper: false, imageUrl: player.imagePath ?? "")
        })
    }
    
    func getAllPlayers() {
        let playersFromDB = RealmDBManager.shared.read(type: PlayerRealmModel.self).sorted(by: { p1, p2 in
            //p1.fullname ?? "" < p2.fullname ?? ""
            guard let p1Name = p1.fullname, let p2Name = p2.fullname else { return false }
            return p1Name < p2Name
        })
        if playersFromDB.isEmpty {
            
            loadingStatus = .loading
            
            Service.shared.getAllPlayers {[weak self] results in
                
                guard let self = self else {
                    return
                }
                
                switch results {
                case .success(let data):
                    guard let playersData = data else {
                        return
                    }
                    
                    let playerDBModels:[PlayerRealmModel] = playersData.compactMap { playerModel in
                        let playerDBModel = PlayerRealmModel()
                        playerDBModel.fullname = playerModel.fullname
                        playerDBModel.imagePath = playerModel.imagePath
                        playerDBModel.id = playerModel.id ?? -1
                        playerDBModel.countryName = playerModel.country?.name
                        return playerDBModel
                    }
                    
                    RealmDBManager.shared.addData(list: playerDBModels) { error in
                        print("ERROR OCCURRED \(error)")
                        self.loadingStatus = .loadingFailed
                    }
                    
                    self.setDataToPlayerModelsFrom(playerDBModels)
                    self.loadingStatus = .finished
                case .failure(let error):
                    print("ERROR OCCURRED \(error)")
                    self.loadingStatus = .loadingFailed
                }
            }
        } else {
            setDataToPlayerModelsFrom(playersFromDB)
            loadingStatus = .finished
        }
    }
    
    func searchPlayers(query: String) {
        let queryResults = RealmDBManager.shared.filter(type: PlayerRealmModel.self) { playerModel in
            query.isEmpty ? true : playerModel.fullname?.contains(query) ?? true
        }
        
        setDataToPlayerModelsFrom(queryResults)
        
    }
    
}
