//
//  Webservice.swift
//  LeagueOfSounds
//
//  Created by AK on 7/25/20.
//  Copyright © 2020 AK-Vitae. All rights reserved.
//

import Foundation

class Webservice {
    
    func getVersion(completion: @escaping (ClientVersion) -> ()){
        //https://jsonplaceholder.typicode.com/posts
        guard let url = URL(string: "https://ddragon.leagueoflegends.com/realms/na.json") else {
            fatalError("URL is not correct")
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let versions = try!
                JSONDecoder().decode(ClientVersion.self, from: data!)
            DispatchQueue.main.async {
                completion(versions)
            }
        }.resume()
    }
}
