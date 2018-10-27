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
    var model: Season
    
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // SetupUI
        setUpUI()
        
        // Sync UI
        syncModelWithView()
    }
}


extension SeasonDetailViewController {
    // MARK: - Sync
    func syncModelWithView() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        let releaseDate = dateFormatter.string(from: model.releaseDate)
        
        nameLabel.text = model.name
        releaseDateLabel.text = releaseDate
        numberEpisodesLabel.text = model.numberOfEpisodes.description
        
        // Propiedades de la super clase
        self.title = model.name
    }
    
    // MARK: - SetupUI
    func setUpUI() {
        // Crear el botón de episodios
        let episodesButton = UIBarButtonItem(title: "Episodios", style: .plain, target: self, action: #selector(displayEpisodes))
        
        // Añadir el botón
        self.navigationItem.rightBarButtonItem = episodesButton
    }
    
    @objc func displayEpisodes() {
        // Crear el VC destino
        let episodeListViewController = EpisodeListViewController(model: model.sortedEpisodes)
        
        // hacemos push
        self.navigationController?.pushViewController(episodeListViewController, animated: true)
    }
}

// Mark - SeasonListViewControllerDelegate
extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    
    func seasonListViewController(_ vc: SeasonListViewController, didSelectedSeason season: Season) {
        self.model = season
        syncModelWithView()
    }
}
