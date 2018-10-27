//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Luis Herrera Lillo on 30-09-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import UIKit

class MemberListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var model: [Person]
    
    // MARK: - Initialization
    init(model: [Person]) {
        // 1. limpio mi propio desorden (a.k.a, le doy valor a mis propias propiedades)
        self.model = model
        
        //2. Llamamos a super
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // FUNDAMENTAL!!! No olvidarse de contar al tableview quienes son sus ayudantes (datasource y delegate)
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Nos damos de alta en las notificaciones
        NotificationCenter.default.addObserver(self, selector: #selector(houseDidChange(notification:)), name: .houseDidChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja en las notificaciones
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Notifications
extension MemberListViewController {
    @objc func houseDidChange(notification: Notification) {
        // extraemos la info y sacamos la casa (house)
        guard let userInfo = notification.userInfo,
        let house = userInfo[Constants.HouseKey] as? House else { return }
        
        // actualizamos el modelo
        self.model = house.sortedMembers
        
        // recargamos la tabla
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension MemberListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "PersonCell"
        
        // Descubrimos cual es la Person que hay que mostrar
        let person = model[indexPath.row]
        
        // Creamos la celda ( o que nos la den por caché)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        // No hay celdas en cache
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        // Sincronizar modelo y vista (person-cell)
        cell?.textLabel?.text = person.name
        cell?.detailTextLabel?.text = person.alias
        
        // Devolvemos la celda
        return cell!
    }
}
