import UIKit

var listGame: [Game]? = []

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
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case count
        case percent
    }
}

func getData(page_size: String = "10") {

    var components = URLComponents(string: "https://api.rawg.io/api/games")!

    components.queryItems = [
        URLQueryItem(name: "page_size", value: page_size)
    ]
    
    let request = URLRequest(url: components.url!)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        
        guard let response = response as? HTTPURLResponse, let data = data else { return }
        
        if response.statusCode == 200 {
            decodeJSON(data: data)
        } else {
            print("ERROR: \(data), HTTP Status: \(response.statusCode)")
        }
        
    }
    
    task.resume()
}

private func decodeJSON(data: Data) {
    
    let decoder = JSONDecoder()
    
    do {
        let games = try decoder.decode(Games.self, from: data)
        
        DispatchQueue.main.async {
            games.games.forEach { game in
                listGame? = [
                    Game(
                        id: game.id, slugName: game.slugName, gameName: game.gameName, gamePhoto: game.gamePhoto,
                        ratingGame: game.ratingGame, releasedDate: game.releasedDate, ratingsGame: game.ratingsGame
                    )
                ]
            }
        }
    } catch let DecodingError.dataCorrupted(context) {
        print(context)
    } catch let DecodingError.keyNotFound(key, context) {
        print("Key '\(key)' not found:", context.debugDescription)
        print("codingPath:", context.codingPath)
    } catch let DecodingError.valueNotFound(value, context) {
        print("Value '\(value)' not found:", context.debugDescription)
        print("codingPath:", context.codingPath)
    } catch let DecodingError.typeMismatch(type, context)  {
        print("Type '\(type)' mismatch:", context.debugDescription)
        print("codingPath:", context.codingPath)
    } catch {
        print("error: ", error)
    }
}
