//
//  MatchesListTVC.swift
//  Blasters Tournament
//
//  Created by Mayank Sharma on 05/02/24.
//

import UIKit

class MatchesListTVC: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var lblContestant1: UILabel!
    @IBOutlet weak var lblContestant1Score: UILabel!
    @IBOutlet weak var lblContestant2Score: UILabel!
    @IBOutlet weak var lblContestant2: UILabel!
    
    //MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(data: MatchList, id: Int) {
        self.setResult(data: data, id: id)
        self.lblContestant1.text = data.player1?.name ?? ""
        self.lblContestant2.text = data.player2?.name ?? ""
        self.lblContestant1Score.text = String(data.player1?.score ?? 0)
        self.lblContestant2Score.text = String(data.player2?.score ?? 0)
    }
    
    func setResult(data: MatchList, id: Int) {
        var result: GameResult = .tie
        if (data.player1?.score ?? 0) == (data.player2?.score ?? 0)  {
            result = .tie
        }else if (data.player1?.score ?? 0) > (data.player2?.score ?? 0) , (data.player1?.id ?? 0) == id {
            result = .win
        } else if (data.player1?.score ?? 0) > (data.player2?.score ?? 0) , (data.player2?.id ?? 0) == id {
            result = .loss
        }else if (data.player1?.score ?? 0) < (data.player2?.score ?? 0) , (data.player1?.id ?? 0) == id {
            result = .loss
        }else if (data.player1?.score ?? 0) < (data.player2?.score ?? 0) , (data.player2?.id ?? 0) == id {
            result = .win
        }
        setBackgroundColor(result: result)
    }
    
    func setBackgroundColor(result: GameResult) {
        switch result {
        case .win : self.backgroundColor = .green
        case .loss : self.backgroundColor = .red
        case .tie : self.backgroundColor = .white
        }
    }
    
}
