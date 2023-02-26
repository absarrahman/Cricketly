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
    
    var timer: Timer = Timer()
    
    private func setDataBasedOnResult(_ result: Result<([FixtureModel]?), Error>, _ type: FixtureType) {
        switch result {
        case .success(let data):
            guard let fixtureList = data else { return }
            self.fixtureDataList = fixtureList.compactMap({ model in
                // TODO: Need cleanup. Create variables for the fields
                switch type {
                case .live:
                    return getLiveFixtureModel(model: model)
                case .recent:
                    return getRecentFixtureModel(model: model)
                case .upcoming:
                    return getUpcomingFixtureModel(model: model)
                }
            })
        case .failure(let error):
            self.error = error.localizedDescription
        }
    }
    
    func getLiveFixtureModel(model: FixtureModel) -> FixtureCellModel {
        guard let totalBattingTeamRuns = model.runs, let firstBattingTeamRuns = totalBattingTeamRuns.first else { return getUpcomingFixtureModel(model: model) }
        
        // Only first batting team ongoing (1st Innings)
        if (totalBattingTeamRuns.first?.teamID == totalBattingTeamRuns.last?.teamID) {
            return FixtureCellModel(id: model.id ?? -1, isLive: true, localTeamCode: firstBattingTeamRuns.team?.code ?? "N/A", visitorTeamCode: CommonFunctions.getVisitorTeamCode(battingTeam: firstBattingTeamRuns.team, localTeam: model.localteam, visitorTeam: model.visitorteam).code, localTeamRun: firstBattingTeamRuns.score?.description ?? "", visitorTeamRun: "Not started batting yet", localTeamWicket: firstBattingTeamRuns.wickets?.description ?? "", visitorTeamWicket: "", localTeamOver: firstBattingTeamRuns.overs?.description ?? "", visitorTeamOver: "", matchNote: model.note ?? "", matchType: model.type ?? "", localTeamImageUrl: firstBattingTeamRuns.team?.imagePath ?? "", visitorTeamImageUrl: CommonFunctions.getVisitorTeamCode(battingTeam: firstBattingTeamRuns.team, localTeam: model.localteam, visitorTeam: model.visitorteam).imgUrl, isUpcoming: false)
        }
        // Second innings
        return FixtureCellModel(id: model.id ?? -1, isLive: true, localTeamCode: firstBattingTeamRuns.team?.code ?? "N/A", visitorTeamCode: totalBattingTeamRuns.last?.team?.code ?? "", localTeamRun: firstBattingTeamRuns.score?.description ?? "", visitorTeamRun: totalBattingTeamRuns.last?.score?.description ?? "", localTeamWicket: firstBattingTeamRuns.wickets?.description ?? "", visitorTeamWicket: totalBattingTeamRuns.last?.wickets?.description ?? "", localTeamOver: firstBattingTeamRuns.overs?.description ?? "", visitorTeamOver: totalBattingTeamRuns.last?.overs?.description ?? "", matchNote: model.note ?? "", matchType: model.type ?? "", localTeamImageUrl: firstBattingTeamRuns.team?.imagePath ?? "", visitorTeamImageUrl: totalBattingTeamRuns.last?.team?.imagePath ?? "", isUpcoming: false)
    }
    
    
    func getUpcomingFixtureModel(model: FixtureModel) -> FixtureCellModel {
        FixtureCellModel(id: model.id ?? -1, isLive: false, localTeamCode: model.localteam?.code ?? "N/A", visitorTeamCode: model.visitorteam?.code ?? "N/A", localTeamRun: "", visitorTeamRun: "", localTeamWicket: "", visitorTeamWicket: "", localTeamOver: "", visitorTeamOver: "", matchNote: model.startingAt ?? "N/A", matchType: "\(model.league?.name ?? "N/A") - \(model.season?.name ?? "N/A")", localTeamImageUrl: model.localteam?.imagePath ?? "N/A", visitorTeamImageUrl: model.visitorteam?.imagePath ?? "N/A", isUpcoming: true)
    }
    
    func getRecentFixtureModel(model: FixtureModel) -> FixtureCellModel {
        guard let runs = model.runs else { return getUpcomingFixtureModel(model: model) }
        
        if (runs.isEmpty) {
            return getUpcomingFixtureModel(model: model)
        }
        
        // ONLY ONE TEAM PLAYED
        if (runs.first?.teamID ?? -1 == runs.last?.teamID ?? -1) {
            return FixtureCellModel(id: model.id ?? -1, isLive: false, localTeamCode: runs.first?.team?.code ?? "N/A", visitorTeamCode: CommonFunctions.getVisitorTeamCode(battingTeam: runs.first?.team, localTeam: model.localteam, visitorTeam: model.visitorteam).code, localTeamRun: runs.first?.score?.description ?? "", visitorTeamRun: "", localTeamWicket: runs.first?.wickets?.description ?? "", visitorTeamWicket: "", localTeamOver: runs.first?.overs?.description ?? "", visitorTeamOver: "", matchNote: model.note ?? "", matchType: model.type ?? "", localTeamImageUrl: runs.first?.team?.imagePath ?? "", visitorTeamImageUrl: CommonFunctions.getVisitorTeamCode(battingTeam: runs.first?.team, localTeam: model.localteam, visitorTeam: model.visitorteam).imgUrl, isUpcoming: false)
        }
        return FixtureCellModel(id: model.id ?? -1, isLive: false, localTeamCode: model.runs?[0].team?.code ?? "N/A", visitorTeamCode: model.runs?[1].team?.code ?? "N/A", localTeamRun: model.runs?[0].score?.description ?? "N/A", visitorTeamRun: model.runs?[1].score?.description ?? "N/A", localTeamWicket: model.runs?[0].wickets?.description ?? "N/A", visitorTeamWicket: model.runs?[1].wickets?.description ?? "N/A", localTeamOver: model.runs?[0].overs?.description ?? "N/A", visitorTeamOver: model.runs?[1].overs?.description ?? "N/A", matchNote: model.note ?? "N/A", matchType: "\(model.league?.name ?? "N/A") - \(model.season?.name ?? "N/A")", localTeamImageUrl: model.runs?[0].team?.imagePath ?? "N/A", visitorTeamImageUrl: model.runs?[1].team?.imagePath ?? "N/A", isUpcoming: false)
    }
    
    func fetchFixtureData(for fixtureType: FixtureType) {
        timer.invalidate()
        switch fixtureType {
        case .live:
            print("LIVE")
            timer = Timer.scheduledTimer(withTimeInterval: Constants.timerInterval, repeats: true) { timer in
                Service.shared.getLiveMatch { [weak self] result in
                    guard let self = self else { return }
                    self.setDataBasedOnResult(result, .live)
                }
            }
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
