//
//  DataVersion.swift
//  LeagueOfSounds
//
//  Created by AK on 7/24/20.
//  Copyright © 2020 AK-Vitae. All rights reserved.
//

import Foundation

struct ClientVersion: Codable {
    
    //Need to clean up using the appbrewery guidance
    var patch: String
    
    enum CodingKeys: String, CodingKey {
        case patch = "v"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.patch = try container.decode(String.self, forKey: .patch)
    }
}
