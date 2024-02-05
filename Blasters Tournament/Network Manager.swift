//
//  Network Manager.swift
//  Blasters Tournament
//
//  Created by Mayank Sharma on 05/02/24.
//

import Foundation



class NetworkManager {
    static let shared = NetworkManager()
    func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Data Error", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
            completion(.success(data))
        }.resume()
    }
}


    let dictData: [[String: Any]] = [["id":1,"name":"Boba Fett","icon":"http://icons.iconarchive.com/icons/creativeflip/starwars-longshadow-flat/128/Boba-Fett-icon.png"],["id":2,"name":"C3PO","icon":"http://icons.iconarchive.com/icons/creativeflip/starwars-longshadow-flat/128/C3PO-icon.png"],["id":3,"name":"Chewbacca","icon":"http://icons.iconarchive.com/icons/creativeflip/starwars-longshadow-flat/128/Chewbacca-icon.png"],["id":4,"name":"Darth Vader","icon":"http://icons.iconarchive.com/icons/creativeflip/starwars-longshadow-flat/128/Darth-Vader-icon.png"],["id":5,"name":"Emperor","icon":"http://icons.iconarchive.com/icons/creativeflip/starwars-longshadow-flat/128/Emperor-icon.png"],["id":6,"name":"Han Solo","icon":"http://icons.iconarchive.com/icons/creativeflip/starwars-longshadow-flat/128/Han-Solo-icon.png"],["id":7,"name":"Princess Leia","icon":"http://icons.iconarchive.com/icons/creativeflip/starwars-longshadow-flat/128/Leia-icon.png"],["id":8,"name":"Luke Skywalker","icon":"http://icons.iconarchive.com/icons/creativeflip/starwars-longshadow-flat/128/Luke-Skywalker-icon.png"],["id":9,"name":"Obi Wan Kenobi","icon":"http://icons.iconarchive.com/icons/creativeflip/starwars-longshadow-flat/128/Obi-Wan-icon.png"],["id":10,"name":"R2D2","icon":"http://icons.iconarchive.com/icons/creativeflip/starwars-longshadow-flat/128/R2D2-icon.png"],["id":11,"name":"Stormtrooper","icon":"http://icons.iconarchive.com/icons/creativeflip/starwars-longshadow-flat/128/Stormtrooper-icon.png"],["id":12,"name":"Yoda","icon":"http://icons.iconarchive.com/icons/creativeflip/starwars-longshadow-flat/128/Yoda-icon.png"]]


struct PlayerList {
    var id: Int
    var name: String
    var icon: String
    var totalScore = 0
    var totalMatches = 0
    var totalPoints = 0
    
    
//    enum CodingKeys: String, CodingKey {
//        case id, name, icon
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
//        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
//        let iconString = try container.decodeIfPresent(String.self, forKey: .icon) ?? ""
//        guard let iconURL = URL(string: iconString) else {
//            throw DecodingError.dataCorruptedError(forKey: .icon, in: container, debugDescription: "Invalid URL string")
//        }
//        icon = iconURL
//    }
}



struct MatchList: Codable {
    var match: Int
    var player1: Player?
    var player2: Player?
    
    enum CodingKeys: String, CodingKey {
        case match, player1, player2
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        match = try container.decodeIfPresent(Int.self, forKey: .match) ?? 0
        player1 = try container.decode(Player.self, forKey: .player1)
        player2 = try container.decode(Player.self, forKey: .player2)
    }
}


struct Player: Codable {
    var id: Int
    var score: Int
    var name = ""
    
    enum CodingKeys: String, CodingKey {
        case id, score
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        score = try container.decodeIfPresent(Int.self, forKey: .score) ?? 0
    }
}
