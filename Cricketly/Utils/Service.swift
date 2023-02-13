//
//  Service.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 13/2/23.
//


import Alamofire
import Foundation

class Service {
    
    enum ServiceError: Error {
        case noDataError
        case jsonDecodingError
        
        var localizedDescription: String {
            switch self {
            case .noDataError:
                return NSLocalizedString("No data found", comment: "")
            case .jsonDecodingError:
                return NSLocalizedString("JSON decoding failed", comment: "")
            }
        }
    }
    
    static let shared = Service()
    
    let sessionManager = Session(configuration: .default)
    
    
    private init() {}
    
    private func fetchDataFromAPI<T: Codable> (
        from endpoint: String,
        using parameters: [String:String] = [:],
        completion: @escaping (Result<T, Error>) -> ()
    ) {
        
        sessionManager.request(endpoint,parameters: parameters).validate().response { responseData in
            print("RESPONSE DATA IS \(responseData)")
            guard let data = responseData.data else {
                completion(.failure(ServiceError.noDataError))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
                
            } catch {
                completion(.failure(ServiceError.jsonDecodingError))
                print("Error occurred \(error)")
                
            }
        }
        
    }
    
    
    func getAllPlayers() {
        
        let endpoint = APIEndPoints.playersEndPoint
        let parameters = [
            "api_token": Secrets.apiKey,
            "fields[players]": "id,fullname,image_path"
        ]
        
        sessionManager.request(endpoint,parameters: parameters).response { responseData in
            print("RESPONSE DATA IS \(responseData)")
            guard let data = responseData.data else {
                return
            }
            
            do {
                let playerData = try JSONDecoder().decode(PlayersDataModel.self, from: data)
                
                //dump(dictionary)
                print(playerData.data!.count)
                print(playerData.data![0].fullname)
                
            } catch {
                print("Error occurred \(error)")
            }
            
            
        }
    }
    
    func getPlayerById(id: Int)  {
        //?\(apiToken)&include=career
        let endpoint = APIEndPoints.getPlayerEndpointBased(on: id)
        let parameters = [
            "api_token": Secrets.apiKey,
            "include": "career"
        ]
        sessionManager.request(endpoint,parameters: parameters).validate().response { responseData in
            print("RESPONSE DATA IS \(responseData)")
            guard let data = responseData.data else {
                return
            }
            
            do {
                let playerData = try JSONDecoder().decode(PlayerDetailsDataModel.self, from: data)
                
                //dump(dictionary)
                print(playerData.data!.fullname)
                //print(playerData.data![0].fullname)
                
            } catch {
                print("Error occurred \(error)")
            }
            
            
        }
    }
    
    func getAllFixtures(startDate: String, endDate: String, completion: @escaping (Result<([FixtureModel]?), Error>) -> (), isRecent: Bool = false) {
        //2023-01-15, 2023-02-8
        // TODO: Add start date and end date
        let endpoint = APIEndPoints.fixturesEndPoint
        let parameters = [
            "api_token": Secrets.apiKey,
            "sort": isRecent ? "-starting_at" : "starting_at",
            "filter[starts_between]": "\(startDate),\(endDate)",
            "fields[fixtures]": "id,round,localteam_id,visitorteam_id,starting_at,type,status,note,toss_won_team_id,winner_team_id,man_of_match_id,man_of_series_id,elected,total_overs_played,league_id,season_id",
            "include": "runs.team, localteam,visitorteam,venue,season,league"
        ]
        
        fetchDataFromAPI(from: endpoint,using: parameters) { (result: Result<FixturesDataModel, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getFixtureById(id: Int, completion: @escaping (Result<(FixtureDetailsModel?), Error>) -> ()) {
        let endpoint = APIEndPoints.getFixtureEndpointBased(on: id)
        let parameters = [
            "api_token": Secrets.apiKey,
            "include": "batting.team,batting.bowler,batting.batsman,manofseries,manofmatch,tosswon,venue,localteam,visitorteam,runs.team,season,league,firstumpire,secondumpire,tvumpire,referee,batting.batsmanout,batting.catchstump,batting.runoutby,bowling.team,bowling.bowler,lineup,winnerteam"
        ]
        
        fetchDataFromAPI(from: endpoint,using: parameters) { (result: Result<FixtureDetailsDataModel, Error>) in
            switch result {
            case .failure(let error):
                debugPrint(error)
                completion(.failure(error))
            case .success(let data):
                //dump(data)
                completion(.success(data.data))
            }
        }
    }
    
    func getUpcomingMatchFixture(completion: @escaping (Result<([FixtureModel]?), Error>)->()) {
        getAllFixtures(startDate: "2023-02-12", endDate: "2023-03-7",completion: completion)
    }
    
    func getRecentMatchFixture(completion: @escaping (Result<([FixtureModel]?), Error>)->()) {
        getAllFixtures(startDate: "2023-01-15", endDate: "2023-02-7",completion: completion,isRecent: true)
    }
}
