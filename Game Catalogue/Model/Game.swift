import UIKit

struct Games: Codable {
    let count: Int
    let nextPage: String
    let previousPage: String?
    let games: [Game]
    
    enum CodingKeys: String, CodingKey {
        case count
        case nextPage = "next"
        case previousPage = "previous"
        case games = "results"
    }
}

struct Game: Codable {
    let id: Int
    let slugName: String
    let gameName: String
    let gamePhoto: String
    let ratingGame: Double
    let releasedDate: String
    let ratingsGame: [Ratings]
    
    enum CodingKeys: String, CodingKey {
        case id
        case slugName = "slug"
        case gameName = "name"
        case releasedDate = "released"
        case gamePhoto = "background_image"
        case ratingGame = "rating"
        case ratingsGame = "ratings"
    }
}

struct Ratings: Codable {
    let id: Int
    let title: String
    let count: Int
    let percent: Double
}
