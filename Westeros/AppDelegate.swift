//
//  AppDelegate.swift
//  Westeros
//
//  Created by Luis Herrera Lillo on 20-09-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var splitViewController: UISplitViewController!
    var houseDetailNavigation: UINavigationController!
    var seasonDetailNavigation: UINavigationController!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .cyan
        
        // 1. Creamos los modelos
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
        // 2. Creamos los controladores
        let houseListViewController = HouseListViewController(model: houses)
    
        let lastHouseSelected = houseListViewController.lastSelectedHouse()
        let houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        
        let seasonListViewController = SeasonListViewController(model: seasons)
        
        let lastSeasonSelected = seasonListViewController.lastSelectedSeason()
        let seasonDetailViewController = SeasonDetailViewController(model: lastSeasonSelected)
        
        // Asignar delegados
        // Un objeto SOLO  puede tener un delegado
        // Sin embargo, un objeto, SI puede ser delegado de varios otros
        if UIDevice.current.userInterfaceIdiom == .pad {
            houseListViewController.delegate = houseDetailViewController
            seasonListViewController.delegate = seasonDetailViewController
        }else {
            houseListViewController.delegate = houseListViewController
            seasonListViewController.delegate = seasonListViewController
        }
        
        
        // 3. Creamos los navigations
        let houseListNavigation = houseListViewController.wrappedInNavigation()
        let seasonListNavigation = seasonListViewController.wrappedInNavigation()
        houseDetailNavigation = houseDetailViewController.wrappedInNavigation()
        seasonDetailNavigation = seasonDetailViewController.wrappedInNavigation()
        
        // 4. Creamos el UITabBarController
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            houseListNavigation,
            seasonListNavigation
        ]
        
        // tabBarController Delegate
        tabBarController.delegate = self
        
        // 5. Creamos el combinador, osea, el splitVC
        splitViewController = UISplitViewController()
        splitViewController.viewControllers = [
            tabBarController,
            houseDetailNavigation,
            seasonDetailNavigation
        ]
        
        // 6. Asignamos el rootVC
        //let houseCollectionVC = HouseCollectionViewController(model: houses)
        window?.rootViewController = splitViewController
        
        // Always in same line before 'return true'
        window?.makeKeyAndVisible()

        return true
    }
}


extension AppDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // Averiguar que controlador fue seleccionado
        guard let navigationController = viewController as? UINavigationController,
            let viewController = navigationController.topViewController else { return }
        
        let isSeasonListVC = type(of: viewController) == SeasonListViewController.self
        
        
        var detailViewController: UINavigationController
        if isSeasonListVC {
            detailViewController = seasonDetailNavigation
        }else {
            detailViewController = houseDetailNavigation
        }
        
        
        // Mostrar el controlador correspondiente en el splitVC detail
        if UIDevice.current.userInterfaceIdiom == .pad {
            splitViewController.showDetailViewController(detailViewController, sender: nil)
        }
    }
}
