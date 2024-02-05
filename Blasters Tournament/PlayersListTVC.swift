//
//  PlayersListTVC.swift
//  Blasters Tournament
//
//  Created by Mayank Sharma on 05/02/24.
//

import UIKit

class PlayersListTVC: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var imgPlayer: UIImageView!
    @IBOutlet weak var lblPlayerName: UILabel!
    @IBOutlet weak var lblPlayerScore: UILabel!
    
    //MARK: - Life cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(data: PlayerList) {
        lblPlayerName.text = data.name
        lblPlayerScore.text = String(data.totalPoints)
        ImageDownloader.downloadImage(data.icon) { image, urlString in
            if let imageObject = image {
                DispatchQueue.main.async {
                    self.imgPlayer.image = imageObject
                }
            }
        }
    }
    
}
