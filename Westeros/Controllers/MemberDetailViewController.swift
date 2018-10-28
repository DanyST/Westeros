//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Luis Herrera Lillo on 27-10-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {
    
    // MARK: - Properties
    let model: Person
    
    // Mark - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    
    // MARK: - Initialization
    init(model: Person) {
        // Nos encargamos de nuestras propias propiedades
        self.model = model
        
        // llamamos a super
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Nos damos de alta en las notificaciones
        NotificationCenter.default.addObserver(self, selector: #selector(houseDidChange(notification:)), name: .houseDidChangeNotification, object: nil)
        
        // SyncModelWithView
        syncModelWithView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja en las notificaciones
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - SyncModelWithView
    func syncModelWithView() {
        self.nameLabel.text = self.model.name
        self.aliasLabel.text = self.model.alias
        self.houseLabel.text = self.model.house.name
        self.title = self.model.fullName
    }
}

// Mark - Notifications
extension MemberDetailViewController {
    
    @objc func houseDidChange(notification: Notification) {
        // Nos devolvemos al controlador de la pila anterior en el navigationController
        self.navigationController?.popViewController(animated: true)
    }
}
