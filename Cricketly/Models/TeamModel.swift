//
//  TeamModel.swift
//  Cricketly
//
//  Created by BJIT  on 24/2/23.
//

import Foundation

// MARK: - TeamDetailsDataModel
class TeamDataModel: Codable {
    let data: [TeamModel]?

    init(data: [TeamModel]?) {
        self.data = data
    }
}

// MARK: - Datum
class TeamModel: Codable {
    let resource: String?
    let id: Int?
    let name, code: String?
    let imagePath: String?
    let countryID: Int?
    let nationalTeam: Bool?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case resource, id, name, code
        case imagePath = "image_path"
        case countryID = "country_id"
        case nationalTeam = "national_team"
        case updatedAt = "updated_at"
    }

    init(resource: String?, id: Int?, name: String?, code: String?, imagePath: String?, countryID: Int?, nationalTeam: Bool?, updatedAt: String?) {
        self.resource = resource
        self.id = id
        self.name = name
        self.code = code
        self.imagePath = imagePath
        self.countryID = countryID
        self.nationalTeam = nationalTeam
        self.updatedAt = updatedAt
    }
}
