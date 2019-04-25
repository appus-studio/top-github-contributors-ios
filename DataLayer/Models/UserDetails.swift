//
//  UserDetails.swift
//  TopContributorsKit
//
//  Created by Andrew Mysyk on 4/24/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation

public struct UserDetails: Codable {
    public let login: String
    public let id: Int
    public let avatarURL: String
    public let gravatarID: String
    public let location: String?
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case location
    }
}
