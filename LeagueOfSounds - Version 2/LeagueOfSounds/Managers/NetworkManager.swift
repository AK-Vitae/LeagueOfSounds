//
//  NetworkManager.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 2/27/23.
//

import UIKit

struct DataDragonEndpoint {
    let path: String
    let queryItems: [URLQueryItem] = []
    let httpScheme = "https"
    let host = "ddragon.leagueoflegends.com"
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = httpScheme
        components.host = host
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
    
    private let baseURL = URL(string: "https://ddragon.leagueoflegends.com")!
    
    func getApiVersions() async throws -> [String] {
        let url = baseURL.appendingPathComponent("api/versions.json")
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw LolError.invalidResponse
        }
        
        let versions = try decoder.decode([String].self, from: data)
        return versions
    }
    
    func getChampions(for currentApiVersion: String?) async throws -> Champions {
        let version = currentApiVersion ?? Constants.defaultApiVersion
        let url = baseURL.appendingPathComponent("cdn/\(version)/data/en_US/champion.json")
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw LolError.invalidResponse
        }
        
        let champions = try decoder.decode(Champions.self, from: data)
        return champions
    }
    
    func downloadImage(currentApiVersion: String?, for championId: String) async -> UIImage? {
        let version = currentApiVersion ?? Constants.defaultApiVersion
        let urlString = "cdn/\(version)/img/champion/\(championId).png"
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            return image
        }
        
        guard let url = URL(string: urlString, relativeTo: baseURL) else {
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
