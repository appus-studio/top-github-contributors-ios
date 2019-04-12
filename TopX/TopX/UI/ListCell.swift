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
    
    // Delegate pattern provides transfer of responsibility of one object to another via abstraction
    // Keyword "weak" helps prevent memory leaks when two instances store "strong" pointers on each other
    weak var delegate: ListCellDelegate?
    
    @IBAction func userLocationAction() {
        delegate?.didChooseUserLocation(with: nameLabel.text ?? String())
    }
    
    func configure(with delegate: ListCellDelegate, and user: User) {
        selectionStyle = .none
        self.delegate = delegate
        nameLabel.text = user.login
        commitsLabel.text = "\(user.contributions) contributions"
        guard let avatarUrl = URL(string: user.avatarURL) else { return }
        // Set image via 3rd party library Kingfisher provides image caching in simple way
        avatarImageView.kf.setImage(with: avatarUrl)
    }
}
