//
//  UserDetails.swift
//  TopX
//
//  Created by Andrew Mysyk on 4/12/19.
//  Copyright © 2019 Andrew Mysyk. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let userDetails = try? newJSONDecoder().decode(UserDetails.self, from: jsonData)

import Foundation

struct UserDetails: Codable {
    let login: String
    let id: Int
    let avatarURL: String
    let gravatarID: String
    let location: String?
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case location
    }
}
