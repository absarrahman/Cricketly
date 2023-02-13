//
//  Secrets+Endpoints.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 13/2/23.
//

import Foundation


class Secrets {
    static let apiKey = "12ZsB3C2og5c7fhinci8yffaGN6OPMR8BvJpxqTJnCW6gLjrU97brzVm5wH1"
    static let baseUrl = "https://cricket.sportmonks.com/api/v2.0"
}

class APIEndPoints {
    
    static let playersEndPoint = "\(Secrets.baseUrl)/players"
    static let fixturesEndPoint = "\(Secrets.baseUrl)/fixtures"
    static let apiToken = "api_token=\(Secrets.apiKey)"
    
    
    static func getPlayerEndpointBased(on id: Int) -> String {
        "\(playersEndPoint)/\(id)"
    }
    
    static func getFixtureEndpointBased(on id: Int) -> String {
        "\(fixturesEndPoint)/\(id)"
    }
    
}
