//
//  PlayerDetailsViewModel.swift
//  Cricketly
//
//  Created by BJIT  on 20/2/23.
//

import Foundation



class PlayerDetailsViewModel {
    var playerName: String?
    var playerCountry: String?
    var countryImgUrl: String?
    var playerImgUrl: String?
    @Published var loadStatus: LoadingStatus = .notStarted
    var personalInfoCellsModel: [MatchInfoTableViewCellModel] = []
    
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
}
