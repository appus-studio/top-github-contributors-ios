//
//  ContributorListUserEntity.swift
//  TopContributors
//
//  Created by Andrew Mysyk on 4/24/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation

protocol ContributorListUserEntity {
    var login: String {get}
    var contributions: Int {get}
    var avatarURL: String {get}
}
