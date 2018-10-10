//
//  HouseCell.swift
//  Westeros
//
//  Created by Luis Herrera Lillo on 10-10-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import UIKit

class HouseCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: self)
    
    // MARK: - Outlets
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var wordsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Se ejecuta siempre cuando se inicializa a través de un XIB
        // Podemos dar valores por defecto, por ejemplo.
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // Usar un estado limpio por cada celda
        // En caso de que algunas celdas no tengan una imagen, no se repita la anterior usada
        sigilImageView.image = nil
        nameLabel.text = nil
        wordsLabel.text = nil
    }
    
}
