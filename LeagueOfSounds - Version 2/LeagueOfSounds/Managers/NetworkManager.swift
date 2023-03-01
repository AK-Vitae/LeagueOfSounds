//
//  NetworkManager.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 2/27/23.
//

import UIKit

struct DataDragonEndpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension DataDragonEndpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "ddragon.leagueoflegends.com"
        components.path = "/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
}

class NetworkManager {
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
    
    // https://ddragon.leagueoflegends.com/api/versions.json
    func getApiVersions() async throws -> [String] {
        let dataDragonEndpoint = DataDragonEndpoint(path: "api/versions.json")
        
        guard let url = dataDragonEndpoint.url else {
            throw LolError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw LolError.invalidResponse
        }
        
        do {
            let versions = try decoder.decode([String].self, from: data)
            return versions
        } catch {
            throw LolError.invalidData
        }
    }
    
    // https://ddragon.leagueoflegends.com/cdn/13.4.1/data/en_US/champion.json
    func getChampions(for currentApiVersion: String?) async throws -> Champions {
        
        let version = currentApiVersion ?? Constants.defaultApiVersion
        
        let dataDragonEndpoint = DataDragonEndpoint(path: "cdn/\(version)/data/en_US/champion.json")
        
        guard let url = dataDragonEndpoint.url else {
            throw LolError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw LolError.invalidResponse
        }
        
        do {
            let champions = try decoder.decode(Champions.self, from: data)
            return champions
        } catch {
            throw LolError.invalidData
        }
    }
    
    // https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/Aatrox.png
    func downloadImage(currentApiVersion: String?, for championId: String) async -> UIImage? {
        
        let version = currentApiVersion ?? Constants.defaultApiVersion
        
        let dataDragonEndpoint = DataDragonEndpoint(path: "cdn/\(version)/img/champion/\(championId).png")
        
        let cacheKey = NSString(string: dataDragonEndpoint.url?.absoluteString ?? "https://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/Aatrox.png")
        
        if let image = cache.object(forKey: cacheKey) {
            return image
        }
        
        guard let url = dataDragonEndpoint.url else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}
