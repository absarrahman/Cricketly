//
//  IccRankingViewModel.swift
//  Cricketly
//
//  Created by BJIT  on 24/2/23.
//

import Foundation


class IccRankingViewModel {
    @Published var loadStatus: LoadingStatus = .notStarted
    
    var testRanks: [RankModel] = []
    var t20Ranks: [RankModel] = []
    var odiRanks: [RankModel] = []
    
    
    func fetchAllRanks() {
        loadStatus = .loading
        Service.shared.getAllRanking {[weak self] results in
            
            guard let self = self else {
                return
            }
            
            switch results {
            case .success(let data):
                guard let data = data else { return }
                //self.allRanks = data
                self.testRanks = data.filter({ rankModel in
                    rankModel.gender == "men" && rankModel.type == "TEST"
                })
                self.t20Ranks = data.filter({ rankModel in
                    rankModel.gender == "men" && rankModel.type == "T20I"
                })
                self.odiRanks = data.filter({ rankModel in
                    rankModel.gender == "men" && rankModel.type == "ODI"
                })
                self.loadStatus = .finished
            case .failure(let error):
                print(error)
                self.loadStatus = .loadingFailed
            }
        }
    }
    
}
