//
//  Post.swift
//  SocialNetwork
//
//  Created by Ieda Xavier on 10/08/22.
//

import Foundation
import SwiftUI

struct Post: Codable {
    var id : UUID
    var content : String = ""
    var userid : UUID
    var createdat: String
    var updatedat: String?

    enum CodingKeys: String, CodingKey {
        case id, content
        case userid = "user_id"
        case createdat = "created_at"
        case updatedat = "updated_at"
    }
}
