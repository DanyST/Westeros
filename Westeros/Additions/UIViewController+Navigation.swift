//
//  UIViewController+Navigation.swift
//  Westeros
//
//  Created by Luis Herrera Lillo on 29-09-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func wrappedInNavigation() -> UINavigationController {
        // Devuelve un NUEVO UINavigationController
        return UINavigationController(rootViewController: self)
    }
}
