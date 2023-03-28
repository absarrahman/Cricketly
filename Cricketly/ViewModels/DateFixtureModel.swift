//
//  DateFixtureModel.swift
//  Cricketly
//
//  Created by BJIT  on 26/2/23.
//

import Foundation

class DateFixtureModel {
    @Published var loadingStatus: LoadingStatus = .notStarted
    var fixtureDataList: [FixtureCellModel] = []
    func fetchFixtureData(startDate: Date, endDate: Date)  {
        loadingStatus = .loading
        
        Service.shared.getAllFixtures(startDate: startDate.ISO8601Format(), endDate: endDate.ISO8601Format()) {[weak self] results in
            
            guard let self = self else {
                return
            }
            
            switch results {
            case .success(let data):
                guard let data = data else { return }
                self.fixtureDataList = data.compactMap({ model in
                    FixtureCellModel(id: model.id ?? -1, isLive: false, localTeamCode: model.localteam?.code ?? "N/A", visitorTeamCode: model.visitorteam?.code ?? "N/A", localTeamRun: "", visitorTeamRun: "", localTeamWicket: "", visitorTeamWicket: "", localTeamOver: "", visitorTeamOver: "", matchNote: model.startingAt ?? "N/A", matchType: "\(model.league?.name ?? "N/A") - \(model.season?.name ?? "N/A")", localTeamImageUrl: model.localteam?.imagePath ?? "N/A", visitorTeamImageUrl: model.visitorteam?.imagePath ?? "N/A", isUpcoming: true)
                })
                self.loadingStatus = .finished
            case .failure(let error):
                print(error)
                self.loadingStatus = .loadingFailed
            }
        }
        
    }
    
}
