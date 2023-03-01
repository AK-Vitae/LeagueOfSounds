//
//  LolError.swift
//  LeagueOfSounds
//
//  Created by Ramadugu, Akshith on 3/1/23.
//

import Foundation

enum LolError: String, Error {
    case invalidURL = "This url leads to an invalid request."
    case unableToComplete =  "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data from the server was invalid. Please try again"
    case unableToFavorite = "There was an error favoriting this error. Please try again"
    case alreadyInFavorites = "You have already favorited this user."
}
