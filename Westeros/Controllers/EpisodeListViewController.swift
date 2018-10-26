//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by Luis Herrera Lillo on 26-10-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import UIKit

class EpisodeListViewController: UIViewController {
    
    // MARK: - Properties
    let model: [Episode]
    
    // Mark - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Initialization
    init(model: [Episode]) {
        // Nos encargamos de nuestras propias propiedades
        self.model = model
        
        // Llamamos a super
        super.init(nibName: nil, bundle: nil)
        
        // Propiedades de la super clase
        self.title = "Episodes"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
}

extension EpisodeListViewController {
    func episode(at index: Int) -> Episode {
        return self.model[index]
    }
}

// MARK: - UITableViewDataSource
extension EpisodeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "EpisodeCell"
        
        // Averiguamos de que episodio se trata
        let theEpisode = self.episode(at: indexPath.row)
        
        // Creamos la celda (o que nos la den por cache)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincronizamos modelo y vista
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let releaseDate = dateFormatter.string(from: theEpisode.releaseDate)
        
        cell?.textLabel?.text = theEpisode.name
        cell?.detailTextLabel?.text = releaseDate
        
        
        // Devolvemos la celda
        return cell!
    }
    
}

// MARK: - UITableViewDelegate
extension EpisodeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguamos el episodio seleccionado
        let theEpisode = self.episode(at: indexPath.row)
        
        // Hacemos push a EpisodeDetailVC
        let episodeDetailViewController = EpisodeDetailViewController(model: theEpisode)
        
        self.navigationController?.pushViewController(episodeDetailViewController, animated: true)
    }
}
