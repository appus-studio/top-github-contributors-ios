//
//  ListCell.swift
//  TopX
//
//  Created by Andrew Mysyk on 4/12/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import UIKit
import Kingfisher

protocol ListCellDelegate: class {
    func tapedLocationButton(cell: ListCell)
}

class ListCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commitsLabel: UILabel!

    // Delegate pattern provides transfer of responsibility of one object to another via abstraction
    // Keyword "weak" helps prevent memory leaks when two instances store "strong" pointers on each other
    weak var delegate: ListCellDelegate?

    @IBAction func userLocationAction() {
        delegate?.tapedLocationButton(cell: self)
    }

    func configure(with delegate: ListCellDelegate, and contributor: ContributorListUserEntity) {
        selectionStyle = .none
        self.delegate = delegate
        nameLabel.text = contributor.login
        commitsLabel.text = "\(contributor.contributions) contributions"
        guard let avatarUrl = URL(string: contributor.avatarURL) else { return }
        // Set image via 3rd party library Kingfisher provides image caching in simple way
        avatarImageView.kf.setImage(with: avatarUrl)
    }
}
