//
//  InitialViewController.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 3/2/23.
//

import UIKit
import Combine

class InitialViewController: UIViewController {
    
    let viewModel = BrowsePlayersViewModel()
    
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getAllPlayers()
        setupBinders()
        //        let playerList = RealmDBManager.shared.read(type: PlayerRealmModel.self)
        //        print("PLAYER LIST COUNT FROM READ: \(playerList.count)")
        //        if (playerList.isEmpty) {
        //            Service.shared.getAllPlayers { result in
        //                switch result {
        //                case .success(let success):
        //                    print(success?.first?.fullname)
        //                    guard let playerModels = success else { return }
        //
        //                    print("Model from server \(playerModels.count)")
        //                    var realDBModel: [PlayerRealmModel] = []
        //
        //
        //
        //                    for player in playerModels {
        //                        let playerRealmDB = PlayerRealmModel()
        //                        playerRealmDB.id = player.id ?? -1
        //                        playerRealmDB.fullname = player.fullname
        //                        playerRealmDB.imagePath = player.imagePath
        //                        playerRealmDB.countryName = player.country?.name
        //
        //                        realDBModel.append(playerRealmDB)
        //                    }
        //                    RealmDBManager.shared.addData(list: realDBModel) { error in
        //                        print(error)
        //                    }
        //                    DispatchQueue.main.async { [weak self] in
        //                        guard let self = self else { return }
        //                        self.navigationController?.pushViewController(Routes.getViewControllerBy(routeMap: .tabBarViewController), animated: true)
        //                    }
        //                case .failure(let failure):
        //                    print(failure)
        //                }
        //            }
        //        } else {
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
        //                guard let self = self else { return }
        //                self.navigationController?.pushViewController(Routes.getViewControllerBy(routeMap: .tabBarViewController), animated: true)
        //            }
        //        }
        
        
    }
    
    func setupBinders() {
        viewModel.$loadingStatus.sink {[weak self] status in
            if status == .finished {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                    guard let self = self else { return }
                    self.navigationController?.pushViewController(Routes.getViewControllerBy(routeMap: .tabBarViewController), animated: true)
                }
            }
        }.store(in: &cancellables)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.viewControllers.removeAll(where: {
            $0 == self
        })
    }
    
    
    
}
