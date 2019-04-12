//
//  ListCell.swift
//  TopX
//
//  Created by Andrew Mysyk on 4/12/19.
//  Copyright © 2019 Andrew Mysyk. All rights reserved.
//

import UIKit
import Kingfisher

protocol ListCellDelegate: class {
    func didChooseUserLocation(with userName: String)
}

class ListCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commitsLabel: UILabel!
    
    weak var delegate: ListCellDelegate?
    var userName: String!
    
    @IBAction func userLocationAction() {
        delegate?.didChooseUserLocation(with: userName)
    }
    
    func configure(with delegate: ListCellDelegate, and user: User) {
        selectionStyle = .none
        self.delegate = delegate
        userName = user.login
        nameLabel.text = user.login
        commitsLabel.text = "\(user.contributions) contributions"
        guard let avatarUrl = URL(string: user.avatarURL) else { return }
        avatarImageView.kf.setImage(with: avatarUrl)
    }
}
