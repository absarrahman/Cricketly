//
//  FixtureDetailsModel.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 13/2/23.
//

import Foundation

// MARK: - FixtureDetailsDataModel
class FixtureDetailsDataModel: Codable {
    let data: FixtureDetailsModel?

    init(data: FixtureDetailsModel?) {
        self.data = data
    }
}

// MARK: - FixtureDetailsModel
class FixtureDetailsModel: Codable {
    let resource: String?
    let id, leagueID, seasonID, stageID: Int?
    let round: String?
    let localteamID, visitorteamID: Int?
    let startingAt, type: String?
    let live: Bool?
    let status: Status?
    let note: String?
    let venueID, tossWonTeamID, winnerTeamID: Int?
    let drawNoresult: String?
    let firstUmpireID, secondUmpireID, tvUmpireID, refereeID: Int?
    let manOfMatchID: Int?
    let manOfSeriesID: Int?
    let totalOversPlayed: Int?
    let elected: String?
    let superOver, followOn: Bool?
    let localteamDLData, visitorteamDLData: TeamDLData?
    let rpcOvers, rpcTarget: String?
    let league: Team?
    let season: Season?
    let localteam, visitorteam: Team?
    let batting: [Batting]?
    let bowling: [Bowling]?
    let runs: [Run]?
    let lineup: [Player]?
    let manofmatch: Player?
    let manofseries: Player?
    let referee, firstumpire, secondumpire, tvumpire: Firstumpire?
    let winnerteam, tosswon: Team?
    let venue: Venue?

    enum CodingKeys: String, CodingKey {
        case resource, id
        case leagueID = "league_id"
        case seasonID = "season_id"
        case stageID = "stage_id"
        case round
        case localteamID = "localteam_id"
        case visitorteamID = "visitorteam_id"
        case startingAt = "starting_at"
        case type, live, status
        case note
        case venueID = "venue_id"
        case tossWonTeamID = "toss_won_team_id"
        case winnerTeamID = "winner_team_id"
        case drawNoresult = "draw_noresult"
        case firstUmpireID = "first_umpire_id"
        case secondUmpireID = "second_umpire_id"
        case tvUmpireID = "tv_umpire_id"
        case refereeID = "referee_id"
        case manOfMatchID = "man_of_match_id"
        case manOfSeriesID = "man_of_series_id"
        case totalOversPlayed = "total_overs_played"
        case elected
        case superOver = "super_over"
        case followOn = "follow_on"
        case localteamDLData = "localteam_dl_data"
        case visitorteamDLData = "visitorteam_dl_data"
        case rpcOvers = "rpc_overs"
        case rpcTarget = "rpc_target"
        case league, season, localteam, visitorteam, batting, bowling, runs, lineup, manofmatch, manofseries, referee, firstumpire, secondumpire, tvumpire, winnerteam, tosswon, venue
    }

    init(resource: String?, id: Int?, leagueID: Int?, seasonID: Int?, stageID: Int?, round: String?, localteamID: Int?, visitorteamID: Int?, startingAt: String?, type: String?, live: Bool?, status: Status?, note: String?, venueID: Int?, tossWonTeamID: Int?, winnerTeamID: Int?, drawNoresult: String?, firstUmpireID: Int?, secondUmpireID: Int?, tvUmpireID: Int?, refereeID: Int?, manOfMatchID: Int?, manOfSeriesID: Int?, totalOversPlayed: Int?, elected: String?, superOver: Bool?, followOn: Bool?, localteamDLData: TeamDLData?, visitorteamDLData: TeamDLData?, rpcOvers: String?, rpcTarget: String?, league: Team?, season: Season?, localteam: Team?, visitorteam: Team?, batting: [Batting]?, bowling: [Bowling]?, runs: [Run]?, lineup: [Player]?, manofmatch: Player?, manofseries: Player?, referee: Firstumpire?, firstumpire: Firstumpire?, secondumpire: Firstumpire?, tvumpire: Firstumpire?, winnerteam: Team?, tosswon: Team?, venue: Venue?) {
        self.resource = resource
        self.id = id
        self.leagueID = leagueID
        self.seasonID = seasonID
        self.stageID = stageID
        self.round = round
        self.localteamID = localteamID
        self.visitorteamID = visitorteamID
        self.startingAt = startingAt
        self.type = type
        self.live = live
        self.status = status
        self.note = note
        self.venueID = venueID
        self.tossWonTeamID = tossWonTeamID
        self.winnerTeamID = winnerTeamID
        self.drawNoresult = drawNoresult
        self.firstUmpireID = firstUmpireID
        self.secondUmpireID = secondUmpireID
        self.tvUmpireID = tvUmpireID
        self.refereeID = refereeID
        self.manOfMatchID = manOfMatchID
        self.manOfSeriesID = manOfSeriesID
        self.totalOversPlayed = totalOversPlayed
        self.elected = elected
        self.superOver = superOver
        self.followOn = followOn
        self.localteamDLData = localteamDLData
        self.visitorteamDLData = visitorteamDLData
        self.rpcOvers = rpcOvers
        self.rpcTarget = rpcTarget
        self.league = league
        self.season = season
        self.localteam = localteam
        self.visitorteam = visitorteam
        self.batting = batting
        self.bowling = bowling
        self.runs = runs
        self.lineup = lineup
        self.manofmatch = manofmatch
        self.manofseries = manofseries
        self.referee = referee
        self.firstumpire = firstumpire
        self.secondumpire = secondumpire
        self.tvumpire = tvumpire
        self.winnerteam = winnerteam
        self.tosswon = tosswon
        self.venue = venue
    }
}

// MARK: - Batting
class Batting: Codable {
    let resource: BattingResource?
    let id, sort, fixtureID, teamID: Int?
    let active: Bool?
    let scoreboard: String?
    let playerID, ball, scoreID, score: Int?
    let fourX, sixX: Int?
    let catchStumpPlayerID, runoutByID: Int?
    let batsmanoutID: Int?
    let bowlingPlayerID: Int?
    let fowScore: Int?
    let fowBalls: Double?
    let rate: Int?
    let updatedAt: String?
    let team: Team?
    let batsman: Player?
    let bowler, catchstump: Player?
    let batsmanout: Player?
    let runoutby: Player?
    let result: BattingResult?

    enum CodingKeys: String, CodingKey {
        case resource, id, sort
        case fixtureID = "fixture_id"
        case teamID = "team_id"
        case active, scoreboard
        case playerID = "player_id"
        case ball
        case scoreID = "score_id"
        case score
        case fourX = "four_x"
        case sixX = "six_x"
        case catchStumpPlayerID = "catch_stump_player_id"
        case runoutByID = "runout_by_id"
        case batsmanoutID = "batsmanout_id"
        case bowlingPlayerID = "bowling_player_id"
        case fowScore = "fow_score"
        case fowBalls = "fow_balls"
        case rate
        case updatedAt = "updated_at"
        case team, batsman, bowler, catchstump, batsmanout, runoutby,result
    }

    init(resource: BattingResource?, id: Int?, sort: Int?, fixtureID: Int?, teamID: Int?, active: Bool?, scoreboard: String?, playerID: Int?, ball: Int?, scoreID: Int?, score: Int?, fourX: Int?, sixX: Int?, catchStumpPlayerID: Int?, runoutByID: Int?, batsmanoutID: Int?, bowlingPlayerID: Int?, fowScore: Int?, fowBalls: Double?, rate: Int?, updatedAt: String?, team: Team?, batsman: Player?, bowler: Player?, catchstump: Player?, batsmanout: Player?, runoutby: Player?, result: BattingResult?) {
        self.resource = resource
        self.id = id
        self.sort = sort
        self.fixtureID = fixtureID
        self.teamID = teamID
        self.active = active
        self.scoreboard = scoreboard
        self.playerID = playerID
        self.ball = ball
        self.scoreID = scoreID
        self.score = score
        self.fourX = fourX
        self.sixX = sixX
        self.catchStumpPlayerID = catchStumpPlayerID
        self.runoutByID = runoutByID
        self.batsmanoutID = batsmanoutID
        self.bowlingPlayerID = bowlingPlayerID
        self.fowScore = fowScore
        self.fowBalls = fowBalls
        self.rate = rate
        self.updatedAt = updatedAt
        self.team = team
        self.batsman = batsman
        self.bowler = bowler
        self.catchstump = catchstump
        self.batsmanout = batsmanout
        self.runoutby = runoutby
        self.result = result
    }
}

// MARK: - Result
class BattingResult: Codable {
    let resource: String?
    let id: Int?
    let name: String?
    let runs: Int?
    let four, six: Bool?
    let bye, legBye, noball, noballRuns: Int?
    let isWicket, ball, out: Bool?

    enum CodingKeys: String, CodingKey {
        case resource, id, name, runs, four, six, bye
        case legBye = "leg_bye"
        case noball
        case noballRuns = "noball_runs"
        case isWicket = "is_wicket"
        case ball, out
    }

    init(resource: String?, id: Int?, name: String?, runs: Int?, four: Bool?, six: Bool?, bye: Int?, legBye: Int?, noball: Int?, noballRuns: Int?, isWicket: Bool?, ball: Bool?, out: Bool?) {
        self.resource = resource
        self.id = id
        self.name = name
        self.runs = runs
        self.four = four
        self.six = six
        self.bye = bye
        self.legBye = legBye
        self.noball = noball
        self.noballRuns = noballRuns
        self.isWicket = isWicket
        self.ball = ball
        self.out = out
    }
}

// MARK: - Player
class Player: Codable {
    let resource: ManofmatchResource?
    let id, countryID: Int?
    let firstname, lastname, fullname: String?
    let imagePath: String?
    let dateofbirth: String?
    let gender: String?
    let battingstyle: String?
    let bowlingstyle: String?
    let position: Position?
    let updatedAt: String?
    let lineup: Lineup?

    enum CodingKeys: String, CodingKey {
        case resource, id
        case countryID = "country_id"
        case firstname, lastname, fullname
        case imagePath = "image_path"
        case dateofbirth, gender, battingstyle, bowlingstyle, position
        case updatedAt = "updated_at"
        case lineup
    }

    init(resource: ManofmatchResource?, id: Int?, countryID: Int?, firstname: String?, lastname: String?, fullname: String?, imagePath: String?, dateofbirth: String?, gender: String?, battingstyle: String?, bowlingstyle: String?, position: Position?, updatedAt: String?, lineup: Lineup?) {
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
        self.updatedAt = updatedAt
        self.lineup = lineup
    }
}


// MARK: - Lineup
class Lineup: Codable {
    let teamID: Int?
    let captain, wicketkeeper, substitution: Bool?

    enum CodingKeys: String, CodingKey {
        case teamID = "team_id"
        case captain, wicketkeeper, substitution
    }

    init(teamID: Int?, captain: Bool?, wicketkeeper: Bool?, substitution: Bool?) {
        self.teamID = teamID
        self.captain = captain
        self.wicketkeeper = wicketkeeper
        self.substitution = substitution
    }
}

// MARK: - Position
class Position: Codable {
    let resource: PositionResource?
    let id: Int?
    let name: PositionName?

    init(resource: PositionResource?, id: Int?, name: PositionName?) {
        self.resource = resource
        self.id = id
        self.name = name
    }
}

enum PositionName: String, Codable {
    case allrounder = "Allrounder"
    case batsman = "Batsman"
    case bowler = "Bowler"
    case wicketkeeper = "Wicketkeeper"
}

enum PositionResource: String, Codable {
    case positions = "positions"
}

enum ManofmatchResource: String, Codable {
    case players = "players"
}

enum BattingResource: String, Codable {
    case battings = "battings"
}


// MARK: - Team
class Team: Codable {
    let resource: LeagueResource?
    let id: Int?
    let name: String?
    let code: String?
    let imagePath: String?
    let countryID: Int?
    let nationalTeam: Bool?
    let updatedAt: String?
    let seasonID: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case resource, id, name, code
        case imagePath = "image_path"
        case countryID = "country_id"
        case nationalTeam = "national_team"
        case updatedAt = "updated_at"
        case seasonID = "season_id"
        case type
    }

    init(resource: LeagueResource?, id: Int?, name: String?, code: String?, imagePath: String?, countryID: Int?, nationalTeam: Bool?, updatedAt: String?, seasonID: Int?, type: String?) {
        self.resource = resource
        self.id = id
        self.name = name
        self.code = code
        self.imagePath = imagePath
        self.countryID = countryID
        self.nationalTeam = nationalTeam
        self.updatedAt = updatedAt
        self.seasonID = seasonID
        self.type = type
    }
}


// MARK: - Bowling
class Bowling: Codable {
    let resource: BowlingResource?
    let id, sort, fixtureID, teamID: Int?
    let active: Bool?
    let scoreboard: String?
    let playerID: Int?
    let overs: Double?
    let medians, runs, wickets, wide: Int?
    let noball: Int?
    let rate: Double?
    let updatedAt: String?
    let team: Team?
    let bowler: Player?

    enum CodingKeys: String, CodingKey {
        case resource, id, sort
        case fixtureID = "fixture_id"
        case teamID = "team_id"
        case active, scoreboard
        case playerID = "player_id"
        case overs, medians, runs, wickets, wide, noball, rate
        case updatedAt = "updated_at"
        case team, bowler
    }

    init(resource: BowlingResource?, id: Int?, sort: Int?, fixtureID: Int?, teamID: Int?, active: Bool?, scoreboard: String?, playerID: Int?, overs: Double?, medians: Int?, runs: Int?, wickets: Int?, wide: Int?, noball: Int?, rate: Double?, updatedAt: String?, team: Team?, bowler: Player?) {
        self.resource = resource
        self.id = id
        self.sort = sort
        self.fixtureID = fixtureID
        self.teamID = teamID
        self.active = active
        self.scoreboard = scoreboard
        self.playerID = playerID
        self.overs = overs
        self.medians = medians
        self.runs = runs
        self.wickets = wickets
        self.wide = wide
        self.noball = noball
        self.rate = rate
        self.updatedAt = updatedAt
        self.team = team
        self.bowler = bowler
    }
}

enum BowlingResource: String, Codable {
    case bowlings = "bowlings"
}

// MARK: - Firstumpire
class Firstumpire: Codable {
    let resource: String?
    let id, countryID: Int?
    let firstname, lastname, fullname, dateofbirth: String?
    let gender: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case resource, id
        case countryID = "country_id"
        case firstname, lastname, fullname, dateofbirth, gender
        case updatedAt = "updated_at"
    }

    init(resource: String?, id: Int?, countryID: Int?, firstname: String?, lastname: String?, fullname: String?, dateofbirth: String?, gender: String?, updatedAt: String?) {
        self.resource = resource
        self.id = id
        self.countryID = countryID
        self.firstname = firstname
        self.lastname = lastname
        self.fullname = fullname
        self.dateofbirth = dateofbirth
        self.gender = gender
        self.updatedAt = updatedAt
    }
}

// MARK: - TeamDLData
class TeamDLData: Codable {
    let score, overs, wicketsOut: String?

    enum CodingKeys: String, CodingKey {
        case score, overs
        case wicketsOut = "wickets_out"
    }

    init(score: String?, overs: String?, wicketsOut: String?) {
        self.score = score
        self.overs = overs
        self.wicketsOut = wicketsOut
    }
}

// MARK: - Run
class Run: Codable {
    let resource: String?
    let id, fixtureID, teamID, inning: Int?
    let score, wickets: Int?
    let overs: Double?
    let pp1, pp2, pp3: String?
    //let pp3: JSONNull?
    let updatedAt: String?
    let team: Team?

    enum CodingKeys: String, CodingKey {
        case resource, id
        case fixtureID = "fixture_id"
        case teamID = "team_id"
        case inning, score, wickets, overs, pp1, pp2, pp3
        case updatedAt = "updated_at"
        case team
    }

    init(resource: String?, id: Int?, fixtureID: Int?, teamID: Int?, inning: Int?, score: Int?, wickets: Int?, overs: Double?, pp1: String?, pp2: String?, pp3: String?, updatedAt: String?, team: Team?) {
        self.resource = resource
        self.id = id
        self.fixtureID = fixtureID
        self.teamID = teamID
        self.inning = inning
        self.score = score
        self.wickets = wickets
        self.overs = overs
        self.pp1 = pp1
        self.pp2 = pp2
        self.pp3 = pp3
        self.updatedAt = updatedAt
        self.team = team
    }
}

// MARK: - Season
class Season: Codable {
    let resource: String?
    let id, leagueID: Int?
    let name, code, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case resource, id
        case leagueID = "league_id"
        case name, code
        case updatedAt = "updated_at"
    }

    init(resource: String?, id: Int?, leagueID: Int?, name: String?, code: String?, updatedAt: String?) {
        self.resource = resource
        self.id = id
        self.leagueID = leagueID
        self.name = name
        self.code = code
        self.updatedAt = updatedAt
    }
}

// MARK: - Venue
class Venue: Codable {
    let resource: String?
    let id, countryID: Int?
    let name, city: String?
    let imagePath: String?
    let capacity: Int?
    let floodlight: Bool?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case resource, id
        case countryID = "country_id"
        case name, city
        case imagePath = "image_path"
        case capacity, floodlight
        case updatedAt = "updated_at"
    }

    init(resource: String?, id: Int?, countryID: Int?, name: String?, city: String?, imagePath: String?, capacity: Int?, floodlight: Bool?, updatedAt: String?) {
        self.resource = resource
        self.id = id
        self.countryID = countryID
        self.name = name
        self.city = city
        self.imagePath = imagePath
        self.capacity = capacity
        self.floodlight = floodlight
        self.updatedAt = updatedAt
    }
}


