//
//  RankingModel.swift
//  Cricketly
//
//  Created by BJIT  on 24/2/23.
//

import Foundation

// MARK: - RankDataModel
class RankDataModel: Codable {
    let data: [RankModel]?

    init(data: [RankModel]?) {
        self.data = data
    }
}

// MARK: - Datum
class RankModel: Codable {
    let resource, type: String?
    let gender, updatedAt: String?
    let team: [Team]?

    enum CodingKeys: String, CodingKey {
        case resource, type, gender
        case updatedAt = "updated_at"
        case team
    }

    init(resource: String?, type: String?, gender: String?, updatedAt: String?, team: [Team]?) {
        self.resource = resource
        self.type = type
        self.gender = gender
        self.updatedAt = updatedAt
        self.team = team
    }
}



// MARK: - Ranking
class Ranking: Codable {
    let position, matches, points, rating: Int?

    init(position: Int?, matches: Int?, points: Int?, rating: Int?) {
        self.position = position
        self.matches = matches
        self.points = points
        self.rating = rating
    }
}

enum Resource: String, Codable {
    case teams = "teams"
}
