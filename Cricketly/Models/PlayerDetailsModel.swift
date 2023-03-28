//
//  PlayerDetailsModel.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 13/2/23.
//

import Foundation

//
//// MARK: - PlayerDetailsModels
//class PlayerDetailsDataModel: Codable {
//    let data: PlayerDetailsModel?
//
//    init(data: PlayerDetailsModel?) {
//        self.data = data
//    }
//}
//
//// MARK: - PlayerDetailsModel
//class PlayerDetailsModel: Codable {
//    let resource: String?
//    let id, countryID: Int?
//    let firstname, lastname, fullname: String?
//    let imagePath: String?
//    let dateofbirth, gender, battingstyle, bowlingstyle: String?
//    let position: Position?
//    let updatedAt: String?
//    let career: [Career]?
//    let country: Country?
//
//    enum CodingKeys: String, CodingKey {
//        case resource, id
//        case countryID = "country_id"
//        case firstname, lastname, fullname
//        case imagePath = "image_path"
//        case dateofbirth, gender, battingstyle, bowlingstyle, position,country
//        case updatedAt = "updated_at"
//        case career
//    }
//
//    init(resource: String?, id: Int?, countryID: Int?, firstname: String?, lastname: String?, fullname: String?, imagePath: String?, dateofbirth: String?, gender: String?, battingstyle: String?, bowlingstyle: String?, position: Position?, updatedAt: String?, career: [Career]?) {
//        self.resource = resource
//        self.id = id
//        self.countryID = countryID
//        self.firstname = firstname
//        self.lastname = lastname
//        self.fullname = fullname
//        self.imagePath = imagePath
//        self.dateofbirth = dateofbirth
//        self.gender = gender
//        self.battingstyle = battingstyle
//        self.bowlingstyle = bowlingstyle
//        self.position = position
//        self.updatedAt = updatedAt
//        self.career = career
//    }
//}
//
//// MARK: - Career
//class Career: Codable {
//    let resource, type: String?
//    let seasonID, playerID: Int?
//    let bowling: [String: Double]?
//    let batting: [String: Double]?
//    let updatedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case resource, type
//        case seasonID = "season_id"
//        case playerID = "player_id"
//        case bowling, batting
//        case updatedAt = "updated_at"
//    }
//
//    init(resource: String?, type: String?, seasonID: Int?, playerID: Int?, bowling: [String: Double]?, batting: [String: Double]?, updatedAt: String?) {
//        self.resource = resource
//        self.type = type
//        self.seasonID = seasonID
//        self.playerID = playerID
//        self.bowling = bowling
//        self.batting = batting
//        self.updatedAt = updatedAt
//    }
//}


class PlayerDetailsDataModel: Codable {
    let data: PlayerDetailsModel?

    init(data: PlayerDetailsModel?) {
        self.data = data
    }
}

// MARK: - DataClass
class PlayerDetailsModel: Codable {
    let resource: String?
    let id, countryID: Int?
    let firstname, lastname, fullname: String?
    let imagePath: String?
    let dateofbirth, gender, battingstyle, bowlingstyle: String?
    let position: Position?
    let country: Country?
    let updatedAt: String?
    let career: [Career]?
    let teams: [Team]?
    let currentteams: [Team]?

    enum CodingKeys: String, CodingKey {
        case resource, id
        case countryID = "country_id"
        case firstname, lastname, fullname
        case imagePath = "image_path"
        case dateofbirth, gender, battingstyle, bowlingstyle, position, country
        case updatedAt = "updated_at"
        case career, teams, currentteams
    }

    init(resource: String?, id: Int?, countryID: Int?, firstname: String?, lastname: String?, fullname: String?, imagePath: String?, dateofbirth: String?, gender: String?, battingstyle: String?, bowlingstyle: String?, position: Position?, country: Country?, updatedAt: String?, career: [Career]?, teams: [Team]?, currentteams: [Team]?) {
        self.resource = resource
        self.id = id
        self.countryID = countryID
        self.firstname = firstname
        self.lastname = lastname
        self.fullname = fullname
        self.imagePath = imagePath
        self.dateofbirth = dateofbirth
        self.gender = gender
        self.battingstyle = battingstyle
        self.bowlingstyle = bowlingstyle
        self.position = position
        self.country = country
        self.updatedAt = updatedAt
        self.career = career
        self.teams = teams
        self.currentteams = currentteams
    }
}

// MARK: - Career
class Career: Codable {
    let resource: String?
    let type: String?
    let seasonID, playerID: Int?
    let bowling, batting: [String: Double?]?
    let updatedAt: String?
    let season: Season?

    enum CodingKeys: String, CodingKey {
        case resource, type
        case seasonID = "season_id"
        case playerID = "player_id"
        case bowling, batting
        case updatedAt = "updated_at"
        case season
    }

    init(resource: String?, type: String?, seasonID: Int?, playerID: Int?, bowling: [String: Double?]?, batting: [String: Double?]?, updatedAt: String?, season: Season?) {
        self.resource = resource
        self.type = type
        self.seasonID = seasonID
        self.playerID = playerID
        self.bowling = bowling
        self.batting = batting
        self.updatedAt = updatedAt
        self.season = season
    }
}



// MARK: - InSquad
class InSquad: Codable {
    let seasonID, leagueID: Int?

    enum CodingKeys: String, CodingKey {
        case seasonID = "season_id"
        case leagueID = "league_id"
    }

    init(seasonID: Int?, leagueID: Int?) {
        self.seasonID = seasonID
        self.leagueID = leagueID
    }
}

enum TeamResource: String, Codable {
    case teams = "teams"
}
