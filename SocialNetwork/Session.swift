//
//  Session.swift
//  SocialNetwork
//
//  Created by Ieda Xavier on 16/08/22.
//

import Foundation

struct Session: Codable {
    var token: String = ""
    var user: User
}
