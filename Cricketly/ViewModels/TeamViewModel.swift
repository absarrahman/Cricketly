//
//  TeamViewModel.swift
//  Cricketly
//
//  Created by BJIT  on 24/2/23.
//

import Foundation

class TeamViewModel {
    @Published var loadingStatus: LoadingStatus = .notStarted
    var teamsData: [SquadCollectionCellModel] = []
    var filteredTeamData: [SquadCollectionCellModel]  = []
    var teamName = ""
    
    func fetchTeamData() {
        loadingStatus = .loading
        
        Service.shared.getAllTeams {[weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self.teamsData = data.compactMap({ teamModel in
                    SquadCollectionCellModel(id: teamModel.id ?? -1, name: teamModel.name ?? "", position: teamModel.code ?? "", isCaptain: false, isWicketKeeper: false, imageUrl: teamModel.imagePath ?? "")
                })
                self.filteredTeamData = self.teamsData
                self.loadingStatus = .finished
            case .failure(let error):
                print(error)
                self.loadingStatus = .loadingFailed
            }
        }
        
    }
    
    func searchTeam(query: String) {
        if (query.isEmpty) {
            filteredTeamData = teamsData
            return
        }
        filteredTeamData = teamsData.filter({ model in
            model.name.lowercased().contains(query.lowercased()) || model.position.lowercased().contains(query.lowercased())
        })
        
    }
    
    func fetchTeamDataBasedOn(id: Int) {
        loadingStatus = .loading
        
        Service.shared.getTeamSquadBasedOn(id: id) {[weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                guard let data = data, let squad = data.squad else { return }
                self.teamName = data.name ?? ""
                self.teamsData = squad.compactMap({ teamModel in
                    SquadCollectionCellModel(id: teamModel.id ?? -1, name: teamModel.fullname ?? "", position: teamModel.position?.name?.rawValue.capitalized ?? "", isCaptain: false, isWicketKeeper: false, imageUrl: teamModel.imagePath ?? "")
                })
                self.loadingStatus = .finished
            case .failure(let error):
                print(error)
                self.loadingStatus = .loadingFailed
            }
        }
    }
}
