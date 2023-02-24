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
                self.loadingStatus = .finished
            case .failure(let error):
                print(error)
                self.loadingStatus = .loadingFailed
            }
        }
        
    }
}
