//
//  MatchesViewModel.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 13/2/23.
//

import Foundation


enum FixtureType: Int {
    case live = 0
    case recent = 1
    case upcoming = 2
}

class MatchesViewModel {
    @Published var fixtureDataList: [FixtureCellModel] = []
    @Published var error: String?
    
    private func setDataBasedOnResult(_ result: Result<([FixtureModel]?), Error>, _ type: FixtureType) {
        switch result {
        case .success(let data):
            guard let fixtureList = data else { return }
            self.fixtureDataList = fixtureList.compactMap({ model in
                // TODO: Need cleanup. Create variables for the fields
                if (type != .recent) {
                    return FixtureCellModel(id: model.id ?? -1, isLive: false, localTeamCode: model.localteam?.code ?? "N/A", visitorTeamCode: model.visitorteam?.code ?? "N/A", localTeamRun: "", visitorTeamRun: "", localTeamWicket: "", visitorTeamWicket: "", localTeamOver: "", visitorTeamOver: "", matchNote: model.startingAt ?? "N/A", matchType: "\(model.league?.name ?? "N/A") - \(model.season?.name ?? "N/A")", localTeamImageUrl: model.localteam?.imagePath ?? "N/A", visitorTeamImageUrl: model.visitorteam?.imagePath ?? "N/A")
                }
                return FixtureCellModel(id: model.id ?? -1, isLive: false, localTeamCode: model.runs?[0].team?.code ?? "N/A", visitorTeamCode: model.runs?[1].team?.code ?? "N/A", localTeamRun: model.runs?[0].score?.description ?? "N/A", visitorTeamRun: model.runs?[1].score?.description ?? "N/A", localTeamWicket: model.runs?[0].wickets?.description ?? "N/A", visitorTeamWicket: model.runs?[1].wickets?.description ?? "N/A", localTeamOver: model.runs?[0].overs?.description ?? "N/A", visitorTeamOver: model.runs?[1].overs?.description ?? "N/A", matchNote: model.note ?? "N/A", matchType: "\(model.league?.name ?? "N/A") - \(model.season?.name ?? "N/A")", localTeamImageUrl: model.runs?[0].team?.imagePath ?? "N/A", visitorTeamImageUrl: model.runs?[1].team?.imagePath ?? "N/A")
            })
        case .failure(let error):
            self.error = error.localizedDescription
        }
    }
    
    func fetchFixtureData(for fixtureType: FixtureType) {
        switch fixtureType {
        case .live:
            print("LIVE")
            fixtureDataList = []
        case .upcoming:
            Service.shared.getUpcomingMatchFixture {[weak self] result in
                
                guard let self = self else { return }
                
                self.setDataBasedOnResult(result,.upcoming)
            }
        case .recent:
            Service.shared.getRecentMatchFixture {[weak self] result in
                
                guard let self = self else { return }
                
                self.setDataBasedOnResult(result,.recent)
                
            }
        }
    }
    
}
