//
//  HomeViewModel.swift
//  Cricketly
//
//  Created by BJIT  on 24/2/23.
//

import Foundation

class HomeViewModel {
    @Published var liveLoadingStatus: LoadingStatus = .notStarted
    @Published var upcomingLoadingStatus: LoadingStatus = .notStarted
    @Published var isRecentLoaded: LoadingStatus = .notStarted
    @Published var isNewsLoaded: LoadingStatus = .notStarted
    
    var liveMatches: [FixtureCellModel] = []
    var upcomingMatches: [FixtureCellModel] = []
    var recentMatches: [FixtureCellModel] = []
    
    var newsList: [Article] = []
    
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
    
    fileprivate func fetchLiveData() {
        liveLoadingStatus = .loading
        self.liveMatches = []
        Service.shared.getLiveMatch {[weak self] results in
            
            guard let self = self else {
                return
            }
            
            switch results {
            case .success(let data):
                guard let data = data else {
                    self.liveLoadingStatus = .finished
                    return
                }
                
                for dataModel in data {
                    let cellModel = self.getLiveFixtureModel(model: dataModel)
                    self.liveMatches.append(cellModel)
                }
                
                self.liveLoadingStatus = .finished
                
            case .failure(let error):
                print(error)
                self.liveLoadingStatus = .loadingFailed
            }
        }
    }
    
    
    fileprivate func fetchUpcomingData() {
        Service.shared.getUpcomingMatchFixture {[weak self] results in
            
            guard let self = self else {
                return
            }
            
            switch results {
            case .success(let data):
                guard let data = data else {
                    self.upcomingLoadingStatus = .finished
                    return
                }
                
                if (data.count > 2) {
                    for i in 0...2 {
                        let cellModel = self.getUpcomingFixtureModel(model: data[i])
                        self.upcomingMatches.append(cellModel)
                    }
                } else {
                    for dataModel in data {
                        let cellModel = self.getUpcomingFixtureModel(model: dataModel)
                        self.upcomingMatches.append(cellModel)
                    }
                }
                
                self.upcomingLoadingStatus = .finished
                
            case .failure(let error):
                print(error)
                self.upcomingLoadingStatus = .loadingFailed
            }
        }
    }
    
    fileprivate func fetchRecentData() {
        Service.shared.getRecentMatchFixture {[weak self] results in
            
            guard let self = self else {
                return
            }
            
            switch results {
            case .success(let data):
                guard let data = data else {
                    self.isRecentLoaded = .finished
                    return
                }
                
                if (data.count > 2) {
                    for i in 0...2 {
                        let cellModel = self.getRecentFixtureModel(model: data[i])
                        self.recentMatches.append(cellModel)
                    }
                } else {
                    for dataModel in data {
                        let cellModel = self.getRecentFixtureModel(model: dataModel)
                        self.recentMatches.append(cellModel)
                    }
                }
                
                self.isRecentLoaded = .finished
                
            case .failure(let error):
                print(error)
                self.isRecentLoaded = .loadingFailed
            }
        }
    }
    
    func fetchNewsData()  {
        isNewsLoaded = .loading
        Service.shared.getAllNews {[weak self] results in
            guard let self = self else {
                return
            }
            switch results {
            case .success(let data):
                guard let data = data else { return }
                self.newsList = data
                self.isNewsLoaded = .finished
            case .failure(let error):
                print(error)
                self.isNewsLoaded = .finished
            }
        }
    }
    
    func fetchData() {
        
        upcomingLoadingStatus = .loading
        isRecentLoaded = .loading
        
        Timer.scheduledTimer(withTimeInterval: Constants.timerInterval, repeats: true) {[weak self] timer in
            guard let self = self else {
                return
            }
            self.fetchLiveData()
        }
        fetchUpcomingData()
        
        fetchRecentData()
        
        fetchNewsData()
    }
}
