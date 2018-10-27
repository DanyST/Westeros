//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by Luis Herrera Lillo on 25-10-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import UIKit


protocol SeasonListViewControllerDelegate {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectedSeason season: Season)
}

class SeasonListViewController: UIViewController {
    
    // MARK: - Properties
    let model: [Season]
    var delegate: SeasonListViewControllerDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Initialization
    init(model: [Season]) {
        // Nos encargamos de nuestras propias variables
        self.model = model
        
        // Llamamos a super
        super.init(nibName: nil, bundle: nil)
        
        // Propiedades de la super clase
        self.title = "Seasons"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}

extension SeasonListViewController {
    func season(at index: Int) -> Season {
        return model[index]
    }
}

// MARK: - UITableViewDataSource
extension SeasonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "SeasonCell"
        
        // Descubrir la temporada que vamos a mostrar
        let theSeason = season(at: indexPath.row)
        
        // Crear la celda (o que nos la den por caché)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincronizar modelo(season) y vista(celda)
        cell?.textLabel?.text = theSeason.name
        cell?.detailTextLabel?.text = "\(theSeason.numberOfEpisodes) episodes"
        
        // Devolvemos la celda
        return cell!
    }
}

// MARK: - UITableViewDelegate
extension SeasonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar la season seleccionada
        let theSeason = season(at: indexPath.row)
        
        // SIEMPRE emitir la informacion a través de los dos metodos: delegates y notifications
        // Avisar/Informar al delegado
        delegate?.seasonListViewController(self, didSelectedSeason: theSeason)
        
        // Enviar una notificacion
        let nc = NotificationCenter.default
        let notification = Notification(name: .seasonDidChangeNotification, object: self, userInfo: [Constants.SeasonKey: theSeason])

        nc.post(notification)
    }
}
