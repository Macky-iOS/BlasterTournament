//
//  ViewController.swift
//  Blasters Tournament
//
//  Created by Mayank Sharma on 05/02/24.
//

import UIKit

class PlayerListViewController: UIViewController {

    @IBOutlet weak var tableViewPlayerList: UITableView!
    
    //MARK: - Variables And Constants
    var listPlayers = [PlayerList]()
    var opponentList = [MatchList]()
    var listMatches = [MatchList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableViewPlayerList.register(UINib(nibName: "PlayersListTVC", bundle: nil), forCellReuseIdentifier: "PlayersListTVC")
        self.title = "Star Wars Blaster Tournament"
        self.tableViewPlayerList.delegate = self
        self.tableViewPlayerList.dataSource = self
        self.createPlayerList()
    }
    
//    private func callPlayerListAPI() {
//        if let url = URL(string: "https://jsonkeeper.com/b/IKQQ") {
//            NetworkManager.shared.fetchData(from: url) { result in
//                switch result {
//                case .success(let data) :
//                    let playerList: [PlayerList] = try! JSONDecoder().decode([PlayerList].self, from: data)
//                    self.listPlayers = playerList
//                    self.callMatchListAPI()
//                case .failure(_) :
//                    print("error")
//                }
//            }
//        }
//
//    }
    
    private func callMatchListAPI() {
        if let url = URL(string: "https://api.npoint.io/bc3f07c7442e85446788") {
            NetworkManager.shared.fetchData(from: url) { result in
                switch result {
                case .success(let data) :
                    let matchList: [MatchList] = try! JSONDecoder().decode([MatchList].self, from: data)
                    self.listMatches = matchList
                    self.fetchMatchList(list: matchList)
                case .failure(_) :
                    print("error")
                }
            }
        }

    }

    private func fetchMatchList(list: [MatchList]) {
        for match in list {
            for player in 0..<listPlayers.count {
                let current = listPlayers[player]
                if current.id == match.player1?.id {
                    listPlayers[player].totalMatches += 1
                    listPlayers[player].totalScore += (match.player1?.score ?? 0)
                    if (match.player1?.score ?? 0) > (match.player2?.score ?? 0) {
                        listPlayers[player].totalPoints += 3
                    }else if (match.player1?.score ?? 0) == (match.player2?.score ?? 0) {
                        listPlayers[player].totalPoints += 1
                    }
                } else if current.id == match.player2?.id {
                    listPlayers[player].totalMatches += 1
                    listPlayers[player].totalScore += (match.player2?.score ?? 0)
                    if (match.player2?.score ?? 0) > (match.player1?.score ?? 0) {
                        listPlayers[player].totalPoints += 3
                    }else if (match.player2?.score ?? 0) == (match.player1?.score ?? 0) {
                        listPlayers[player].totalPoints += 1
                    }
                }
                
            }
            self.fetchNameForMatchesPlayer()
            self.sortByPoints()
        }
    }
    
    private func sortByPoints() {
        self.listPlayers.sort {
            if let point1 = $0.totalPoints as? Int, let point2 = $1.totalPoints as? Int {
                if point1 == point2 {
                    if let score1 = $0.totalScore as? Int, let score2 = $1.totalScore as? Int {
                        return score1 > score1
                    }
                    return false // Default case
                } else {
                    return point1 > point2
                }
            }
            return false // Default case
        }
        DispatchQueue.main.async {
            self.tableViewPlayerList.reloadData()
        }
    }
    
    private func fetchNameForMatchesPlayer() {
        for match in 0..<listMatches.count {
            let currentMatch = listMatches[match]
            for each in listPlayers {
                if currentMatch.player1?.id == each.id {
                    listMatches[match].player1?.name = each.name
                } else if currentMatch.player2?.id == each.id {
                    listMatches[match].player2?.name = each.name
                }
            }
        }
    }
    
    private func findOpponents(id: Int, name: String) {
        self.opponentList.removeAll()
        for each in listMatches {
            if (each.player1?.id ?? 0) == id || (each.player2?.id ?? 0) == id {
                self.opponentList.append(each)
            }
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MatchListViewController") as! MatchListViewController
        vc.id = id
        vc.title = name
        vc.opponentList = self.opponentList
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func createPlayerList() {
        listPlayers.removeAll()
        for each in dictData {
            let id = each["id"] as? Int ?? 0
            let name = each["name"] as? String ?? ""
            let icon = each["icon"] as? String ?? ""
            let list = PlayerList(id: id, name: name, icon: icon)
            listPlayers.append(list)
        }
        self.callMatchListAPI()
    }

}

extension PlayerListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersListTVC", for: indexPath) as? PlayersListTVC else {
            return UITableViewCell()
        }
        cell.configureCell(data: listPlayers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.findOpponents(id: listPlayers[indexPath.row].id, name: listPlayers[indexPath.row].name)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Points table"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
}



struct OpponentList {
    var player1Name = String()
    var player2Name = String()
    var player1Score = Int()
    var player2Score = Int()
    var id = Int()
}


enum GameResult {
    case win, loss, tie
}
