//
//  FixtureModel.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 13/2/23.
//


import Foundation


// MARK: - FixturesDataModel
class FixturesDataModel: Codable {
    let data: [FixtureModel]?

    init(data: [FixtureModel]?) {
        self.data = data
    }
}

// MARK: - FixtureModel
class FixtureModel: Codable {
    let resource: DatumResource?
    let id, leagueID, seasonID: Int?
    let round: String?
    let localteamID, visitorteamID: Int?
    let startingAt: String?
    let type: String?
    let status: Status?
    let note: String?
    let tossWonTeamID, winnerTeamID, manOfMatchID, manOfSeriesID: Int?
    let totalOversPlayed: Int?
    let elected: String?
    let league: Team?
    let season: Season?
    let localteam, visitorteam: Team?
    let runs: [Run]?
    let venue: Venue?

    enum CodingKeys: String, CodingKey {
        case resource, id
        case leagueID = "league_id"
        case seasonID = "season_id"
        case round
        case localteamID = "localteam_id"
        case visitorteamID = "visitorteam_id"
        case startingAt = "starting_at"
        case type, status, note
        case tossWonTeamID = "toss_won_team_id"
        case winnerTeamID = "winner_team_id"
        case manOfMatchID = "man_of_match_id"
        case manOfSeriesID = "man_of_series_id"
        case totalOversPlayed = "total_overs_played"
        case elected
        case league, season, localteam, visitorteam, runs, venue
    }

    init(resource: DatumResource?, id: Int?, leagueID: Int?, seasonID: Int?, round: String?, localteamID: Int?, visitorteamID: Int?, startingAt: String?, type: String?, status: Status?, note: String?, tossWonTeamID: Int?, winnerTeamID: Int?, manOfMatchID: Int?, manOfSeriesID: Int?, totalOversPlayed: Int?, elected: String?, league: Team?, season: Season?, localteam: Team?, visitorteam: Team?, runs: [Run]?, venue: Venue?) {
        self.resource = resource
        self.id = id
        self.leagueID = leagueID
        self.seasonID = seasonID
        self.round = round
        self.localteamID = localteamID
        self.visitorteamID = visitorteamID
        self.startingAt = startingAt
        self.type = type
        self.status = status
        self.note = note
        self.tossWonTeamID = tossWonTeamID
        self.winnerTeamID = winnerTeamID
        self.manOfMatchID = manOfMatchID
        self.manOfSeriesID = manOfSeriesID
        self.totalOversPlayed = totalOversPlayed
        self.elected = elected
        self.league = league
        self.season = season
        self.localteam = localteam
        self.visitorteam = visitorteam
        self.runs = runs
        self.venue = venue
    }
}


enum LeagueResource: String, Codable {
    case leagues = "leagues"
    case teams = "teams"
}


enum DatumResource: String, Codable {
    case fixtures = "fixtures"
}



enum Status: String, Codable {
    case aban = "Aban."
    case finished = "Finished"
    case ns = "NS"
    case postponed = "Postp."
    case cancelled = "Cancl."
}

