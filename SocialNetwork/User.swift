//
//  Model.swift
//  SocialNetwork
//
//  Created by Ieda Xavier on 09/08/22.
//

import Foundation

struct User: Codable {
    var id = UUID()
    var name: String = ""
    var email: String = ""
    var avatar: String?
}
