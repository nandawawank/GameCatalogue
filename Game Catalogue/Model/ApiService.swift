import UIKit

class ApiService {
    
    func getListGame(page_size: String = "10", completion: @escaping ([Game]) -> Void) {
        var components = URLComponents(string: "https://api.rawg.io/api/games")!

        components.queryItems = [
            URLQueryItem(name: "page_size", value: page_size)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("Failed : Some think wrong!")
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                
                do {
                    let listGame = try decoder.decode(Games.self, from: data).games
                    completion(listGame)
                } catch {
                    print("Invalid Response")
                }
            }
            
        }
        task.resume()
    }
    
    func searchGame(game_name: String, completion: @escaping ([Game]) -> Void) {
        var components = URLComponents(string: "https://api.rawg.io/api/games")!
        
        components.queryItems = [
            URLQueryItem(name: "search", value: game_name)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("Failed : Some think wrong!")
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                
                do {
                    let gameSearch = try decoder.decode(Games.self, from: data).games
                    completion(gameSearch)
                } catch {
                    print("Invalid Reponse")
                }
            }
        }
        
        task.resume()
    }
}
