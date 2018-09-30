//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by Luis Herrera Lillo on 25-09-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {
    
    // MARK: - Properties
    let model: House
    
    // MARK: - Outlets
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!
    
    // MARK: - Initialization
    init(model: House) {
        // Primero, limpio mi propio desorden (a.k.a, le doy valor a mis propias propiedades)
        self.model = model
        
        // Despues, llamamos a super
        super.init(nibName: nil, bundle: nil)
        
        // Si quieres, utilizas alguna propiedad de tu super clase
        self.title = model.name

    }
    
    // Chapuza de los de Cupertino, relacionada con los nil
    // Este init, es el que utilizan los StoryBoards
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Sincronizar modelo y vista
        syncModelWithView()
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        houseNameLabel.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
    }
    
}
