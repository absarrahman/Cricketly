//
//  Service.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 13/2/23.
//


import Alamofire
import Foundation

enum LoadingStatus {
    case loadingFailed, loading, finished, notStarted
}

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
    
    
    func getAllPlayers(completion: @escaping (Result<([PlayerModel]?), Error>) -> ()) {
        
        let endpoint = APIEndPoints.playersEndPoint
        let parameters = [
            "api_token": Secrets.apiKey,
            "fields[players]": "id,fullname,image_path",
            "include": "country"
        ]
        
        fetchDataFromAPI(from: endpoint,using: parameters) { (result: Result<PlayersDataModel, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func getPlayerById(id: Int, completion: @escaping (Result<(PlayerDetailsModel?), Error>) -> ())  {
        let endpoint = APIEndPoints.getPlayerEndpointBased(on: id)
        let parameters = [
            "api_token": Secrets.apiKey,
            "include": "country,career,career.season,teams,currentteams"
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
                completion(.success(playerData.data))
                
            } catch {
                print("Error occurred \(error)")
                completion(.failure(error))
            }
            
            
        }
    }
    
    func getAllFixtures(startDate: String, endDate: String, isRecent: Bool = false, completion: @escaping (Result<([FixtureModel]?), Error>) -> ()) {
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
            "include": "batting.team,batting.bowler,batting.batsman,manofseries,manofmatch,tosswon,venue,localteam,visitorteam,runs.team,season,league,firstumpire,secondumpire,tvumpire,referee,batting.batsmanout,batting.catchstump,batting.runoutby,bowling.team,bowling.bowler,lineup,winnerteam,batting.result"
        ]
        
        fetchDataFromAPI(from: endpoint,using: parameters) { (result: Result<FixtureDetailsDataModel, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getLiveMatch(completion: @escaping (Result<([FixtureModel]?), Error>) -> ()) {
        let endpoint = APIEndPoints.liveEndPoint
        let parameters = [
            "api_token": Secrets.apiKey,
            "fields[fixtures]": "id,season_id,round,localteam_id,visitorteam_id,starting_at,league_id,type,status,note,toss_won_team_id,winner_team_id,man_of_match_id,man_of_series_id,elected,total_overs_played",
            "include": "localteam,visitorteam,runs.team,venue,season,league"
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
    
    func getUpcomingMatchFixture(completion: @escaping (Result<([FixtureModel]?), Error>)->()) {
        let startDate = CommonFunctions.getCurrentDate()
        let endDate = CommonFunctions.getNextUpcomingDate()
        getAllFixtures(startDate: startDate, endDate: endDate,completion: completion)
    }
    
    func getRecentMatchFixture(completion: @escaping (Result<([FixtureModel]?), Error>)->()) {
        let startDate = CommonFunctions.getPreviousDate()
        let endDate = CommonFunctions.getCurrentDate()
        getAllFixtures(startDate: startDate, endDate: endDate, isRecent: true, completion: completion)
    }
}
