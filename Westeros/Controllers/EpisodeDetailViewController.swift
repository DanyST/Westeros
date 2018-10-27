//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Luis Herrera Lillo on 26-10-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    // MARK: - Properties
    let model: Episode
    
    // Mark - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    // MARK: - Initialization
    init(model: Episode) {
        // Nos encargamos de nuestras propias propiedades
        self.model = model
        
        // Llamamos a super
        super.init(nibName: nil, bundle: nil)
        
        // Propiedades de la super clase
        self.title = "\(model.name). \(model.season?.name ?? "")"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Nos damos de alta en las notificaciones
        NotificationCenter.default.addObserver(self, selector: #selector(seasonDidChange(notification:)), name: .seasonDidChangeNotification, object: nil)
        
        // sincronizamos modelo y vista
        syncModelWithView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        // Nos damos de baja en las notificaciones
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - SyncModelWIthView
    func syncModelWithView() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let releaseDate = dateFormatter.string(from: model.releaseDate)
        
        nameLabel.text = model.name
        releaseDateLabel.text = releaseDate        
    }
}

// MARK: - Notifications
extension EpisodeDetailViewController {
    @objc func seasonDidChange(notification: Notification) {
        // Nos devolvemos al controlador de la pila anterior en el navigationController
        self.navigationController?.popViewController(animated: true)
    }
}
