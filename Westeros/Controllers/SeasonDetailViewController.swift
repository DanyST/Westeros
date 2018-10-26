//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Luis Herrera Lillo on 26-10-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {
    
    // MARK: - Properties
    let model: Season
    
    // Mark - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var numberEpisodesLabel: UILabel!
    
    // MARK: - Initialization
    init(model: Season) {
        // Nos encargamos de nuestras propias propiedades
        self.model = model
        
        // Llamamos a super
        super.init(nibName: nil, bundle: nil)
        
        // Propiedades de la super clase
        self.title = model.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // setupUI
        syncModelWithView()
    }
    
    func syncModelWithView() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        let releaseDate = dateFormatter.string(from: model.releaseDate)
        
        nameLabel.text = model.name
        releaseDateLabel.text = releaseDate
        numberEpisodesLabel.text = model.numberOfEpisodes.description
    }
}
