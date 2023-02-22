//
//  StandingsModel.swift
//  Cricketly
//
//  Created by BJIT  on 22/2/23.
//

import Foundation

// MARK: - StandingsDataModel
class StandingsDataModel: Codable {
    let data: [StandingModel]?

    init(data: [StandingModel]?) {
        self.data = data
    }
}

// MARK: - Datum
class StandingModel: Codable {
    let resource: String?
    let legendID: Int?
    let teamID, stageID, seasonID, leagueID: Int?
    let position, points, played, won: Int?
    let lost, draw, noresult, runsFor: Int?
    let oversFor: Double?
    let runsAgainst: Int?
    let oversAgainst, nettoRunRate: Double?
    let recentForm: [String]?
    let updatedAt: String?
    let season: Season?
    let legend: Legend?
    let team: Team?

    enum CodingKeys: String, CodingKey {
        case resource
        case legendID = "legend_id"
        case teamID = "team_id"
        case stageID = "stage_id"
        case seasonID = "season_id"
        case leagueID = "league_id"
        case position, points, played, won, lost, draw, noresult
        case runsFor = "runs_for"
        case oversFor = "overs_for"
        case runsAgainst = "runs_against"
        case oversAgainst = "overs_against"
        case nettoRunRate = "netto_run_rate"
        case recentForm = "recent_form"
        case updatedAt = "updated_at"
        case season, legend, team
    }

    init(resource: String?, legendID: Int?, teamID: Int?, stageID: Int?, seasonID: Int?, leagueID: Int?, position: Int?, points: Int?, played: Int?, won: Int?, lost: Int?, draw: Int?, noresult: Int?, runsFor: Int?, oversFor: Double?, runsAgainst: Int?, oversAgainst: Double?, nettoRunRate: Double?, recentForm: [String]?, updatedAt: String?, season: Season?, legend: Legend?, team: Team?) {
        self.resource = resource
        self.legendID = legendID
        self.teamID = teamID
        self.stageID = stageID
        self.seasonID = seasonID
        self.leagueID = leagueID
        self.position = position
        self.points = points
        self.played = played
        self.won = won
        self.lost = lost
        self.draw = draw
        self.noresult = noresult
        self.runsFor = runsFor
        self.oversFor = oversFor
        self.runsAgainst = runsAgainst
        self.oversAgainst = oversAgainst
        self.nettoRunRate = nettoRunRate
        self.recentForm = recentForm
        self.updatedAt = updatedAt
        self.season = season
        self.legend = legend
        self.team = team
    }
}

// MARK: - Legend
class Legend: Codable {
    let resource: String?
    let id, stageID, seasonID, leagueID: Int?
    let position: Int?
    let description, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case resource, id
        case stageID = "stage_id"
        case seasonID = "season_id"
        case leagueID = "league_id"
        case position, description
        case updatedAt = "updated_at"
    }

    init(resource: String?, id: Int?, stageID: Int?, seasonID: Int?, leagueID: Int?, position: Int?, description: String?, updatedAt: String?) {
        self.resource = resource
        self.id = id
        self.stageID = stageID
        self.seasonID = seasonID
        self.leagueID = leagueID
        self.position = position
        self.description = description
        self.updatedAt = updatedAt
    }
}
