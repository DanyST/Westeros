//
//  HouseCollectionViewCell.swift
//  Westeros
//
//  Created by Luis Herrera Lillo on 22-10-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import UIKit

class HouseCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: self)
    
    // MARK: - Outlets
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageVIew.image = nil
        nameLabel.text = nil
    }

}
