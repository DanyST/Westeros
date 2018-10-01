//
//  HouseListViewController.swift
//  Westeros
//
//  Created by Luis Herrera Lillo on 30-09-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import UIKit

protocol HouseListViewControllerDelegate {
    // Should
    // Will
    // Did
    // Convencion: El primer parametro de las funciones del delegate es SIEMPRE el objeto
    func houseListViewController(_ vc: HouseListViewController, didSelectedHouse house: House)
}

class HouseListViewController: UITableViewController {
    
    // MARK: - Properties
    let model: [House]
    var delegate: HouseListViewControllerDelegate?
    
    // MARK: - Initialization
    init(model: [House]) {
        // 1. limpio mi propio desorden (a.k.a, le doy valor a mis propias propiedades)
        self.model = model
        
        // 2. Llamamos a super
        super.init(nibName: nil, bundle: nil)
        
        // 3. Propiedades de la super clase
        self.title = "Westeros"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "HouseCell"
        
        // Descubrir el item (casa) que tenemos que mostrar
        let house = model[indexPath.row]
        
        // Crear una celda (o que nos la den del caché)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        // No hay ninguna en caché
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincronizar celda(view) y casa (model)
        cell?.imageView?.image = house.sigil.image
        cell?.textLabel?.text = house.name
        
        // Devolver la celda
        // Siempre tendrá un valor, por lo que hacemos desempaquetado explicito
        return cell!
    }
    
    // MARK: - Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        // Averiguar la casa en cuestion
        let house = model[indexPath.row]
        
        // SIEMPRE emitir la informacion a través de los dos metodos: delegates y notifications
        // Avisar/Informar al delegado
        delegate?.houseListViewController(self, didSelectedHouse: house)
        
        // Enviar una notificacion
        let nc = NotificationCenter.default
        let notification = Notification.init(name: Notification.Name(rawValue: HouseDidChangeNotificationName),
                                             object: self, userInfo: [HouseKey : house])
        
        nc.post(notification)
    }
}
