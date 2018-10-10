//
//  WikiViewController.swift
//  Westeros
//
//  Created by Luis Herrera Lillo on 30-09-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {
    
    // MARK: - Properties
    var model: House
    
    // MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    // MARK: - Initialization
    init(model: House) {
        // 1. limpio mi propio desorden (a.k.a, le doy valor a mis propias propiedades)
        self.model = model
        
        // 2. Llamamos a super
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        
        // 3. Usas las properties de tu super clase
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Nos damos de alta en las notificaciones, osea, me suscribo a aquellos eventos que me interesan
        // En este caso, me quiero enterar de cuando se cambia una casa
        // Quiero observar los cambios de casa( notificacion con nombre HouseDidChangeNotificationName
        // y cuando ocurra, quiero ejecutar el metodo houseDidChange
        NotificationCenter.default.addObserver(self, selector: #selector(houseDidChange), name: .houseDidChangeNotification, object: nil) // object es quien lo manda
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Aqui nos damos de baja en las notificaciones
        // No nos interesa seguir recibiendo las actualizaciones de las casas
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // asignar delegados
        webView.navigationDelegate = self
        
        // Sincronizar modelo y vista
        syncModelWithView()
    }
}

extension WikiViewController {
    // MARK: - Notifications
    @objc func houseDidChange(notification: Notification) {
        // sacar la info y extraer la casa
        guard let info = notification.userInfo,
            let house = info[Constants.HouseKey] as? House else { return }
        
        // Actualizar el modelo
        self.model = house
        
        // Sincronizar modelo y vista
        syncModelWithView()
    }
}

extension WikiViewController {
    // MARK: - Sync
    func syncModelWithView() {
        self.title = model.name
        
        let request = URLRequest(url: model.wikiUrl)
        loadingView.startAnimating()
        
        self.webView.load(request)
    }
}

extension WikiViewController: WKNavigationDelegate { // Should, WIll, Did
    // Patron de delegate, siempre envia el objeto del que se es delegado
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Detener el spinner
        self.loadingView.stopAnimating()
        
        // Ocultarlo
        // Toda vista tiene la propiedad 'isHidden'
        self.loadingView.isHidden = true
    }
    
    // @escaping la clausura solo es ejecutada cuando el usuario lo haga
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let type = navigationAction.navigationType
        
        switch type {
        case .linkActivated, .formSubmitted, .formResubmitted:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
        
    }
}
