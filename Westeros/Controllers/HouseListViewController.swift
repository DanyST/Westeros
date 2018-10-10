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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCustomCell()
    }
    
    func registerCustomCell() {
        // Siempre que utilicemos celdas personalizadas, primero tenemos que registrarlas
        // tenemos dos opciones para registrar una celda personalizada
        // 1. Por clase
        // 2. Por nib
        // ¿Cuando usar uno o el otro? Si tenemos la celda personalizada en un XIB, usamos register Nib
        let nib = UINib(nibName: "HouseCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: HouseCell.reuseIdentifier)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Descubrir el item (casa) que tenemos que mostrar
        let theHouse = house(at: indexPath.row)
        
        // Crear una celda (o que nos la den del caché)
        let cell = tableView.dequeueReusableCell(withIdentifier: HouseCell.reuseIdentifier) as! HouseCell
        
        // Sincronizar celda(view) y casa (model)
        cell.sigilImageView.image = theHouse.sigil.image
        cell.nameLabel.text = theHouse.name
        cell.wordsLabel.text = theHouse.words
        
        // Devolver la celda
        // Siempre tendrá un valor, por lo que hacemos desempaquetado explicito
        return cell
    }
    
    // MARK: - Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        // Averiguar la casa en cuestion
        let theHouse = house(at: indexPath.row)
        
        // SIEMPRE emitir la informacion a través de los dos metodos: delegates y notifications
        // Avisar/Informar al delegado
        delegate?.houseListViewController(self, didSelectedHouse: theHouse)
        
        // Enviar una notificacion
        let nc = NotificationCenter.default
        let notification = Notification.init(name: .houseDidChangeNotification,
                                             object: self, userInfo: [Constants.HouseKey : theHouse])
        
        nc.post(notification)
        
        // Guardamos la ultima casa seleccionada
        saveLastSelectedHouse(at: indexPath.row)
    }
}

// MARK: - Persistence (UserDefaults) Solo sirve para persistir PEQUEÑAS cantidades de objetos
// Los objetos tiene que ser sencillos: String, Int, Array, ...
extension HouseListViewController {
    func saveLastSelectedHouse(at row: Int) {
        // Aquí vamos a guardar la ultima casa seleccionada
        let userDefaults = UserDefaults.standard
        
        // Lo insertamos en el diccionario de User Defaults
        userDefaults.set(row, forKey: Constants.lastHouseKey)
        
        // Guardar
        userDefaults.synchronize() // Por si acaso
    }
    
    func lastSelectedHouse() -> House {
        // Averiguar cual es la ultima row seleccionada (si la hay)
        let row = UserDefaults.standard.integer(forKey: Constants.lastHouseKey) // Value 0 es el default
        return house(at: row)
    }
    
    func house(at index: Int) -> House {
        return model[index]
    }
}
