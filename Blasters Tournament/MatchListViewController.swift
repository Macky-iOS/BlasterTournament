//
//  MatchListViewController.swift
//  Blasters Tournament
//
//  Created by Mayank Sharma on 05/02/24.
//

import UIKit

class MatchListViewController: UIViewController {
    
    @IBOutlet weak var tableViewMatchList: UITableView!
    //MARK: - Variable & Constants
    var opponentList = [MatchList]()
    var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableViewMatchList.register(UINib(nibName: "MatchesListTVC", bundle: nil), forCellReuseIdentifier: "MatchesListTVC")
        self.tableViewMatchList.delegate = self
        self.tableViewMatchList.dataSource = self
    }
}


extension MatchListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        opponentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchesListTVC", for: indexPath) as? MatchesListTVC else {
            return UITableViewCell()
        }
        let currentMatch = self.opponentList[indexPath.row]
        cell.configure(data: currentMatch, id: id)
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Matches"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
