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
    let model: House
    
    // MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sincronizar modelo y vista
        syncModelWithView()
    }
}

extension WikiViewController {
    func syncModelWithView() {
        self.title = model.name
        let request = URLRequest(url: model.wikiUrl)
        self.webView.load(request)
    }
}
