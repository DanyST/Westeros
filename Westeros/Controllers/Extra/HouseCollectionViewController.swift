//
//  HouseCollectionViewController.swift
//  Westeros
//
//  Created by Luis Herrera Lillo on 20-10-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import UIKit

class HouseCollectionViewController: UIViewController {
    
    enum Constants {
        static let columns: CGFloat = 2
    }
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let nib = UINib(nibName: "HouseCollectionViewCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: HouseCollectionViewCell.reuseIdentifier)
        }
    }
    
    // MARK: - Properties
    let model: [House]
    let collectionViewLayout: UICollectionViewFlowLayout
    
    // MARK: - Initialization
    init(model: [House], layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()) {
        self.model = model
        self.collectionViewLayout = layout
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    func setupUI() {
        // asignar el data source
        collectionView.dataSource = self
        
        // Setup del layout
        let width = calculateItemWidth()
        collectionViewLayout.itemSize = CGSize(width: width, height: width)
        collectionView.collectionViewLayout = collectionViewLayout
        
    }
    
    func calculateItemWidth() -> CGFloat { // numero decimal
        let viewWidth = view.frame.width
        let spacing = (Constants.columns - 1) * collectionViewLayout.minimumLineSpacing
        let width = (viewWidth - spacing) / Constants.columns
        
        return width
    }
    
    // MARK: - House at index
    func house(at index: Int) -> House {
        return model[index]
    }
}

extension HouseCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Obtenemos la casa
        let theHouse = house(at: indexPath.row)
        
        // Creamos (o cache) la celda
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HouseCollectionViewCell.reuseIdentifier, for: indexPath) as! HouseCollectionViewCell
        
        // Sync model-view
        cell.imageVIew.image = theHouse.sigil.image
        cell.nameLabel.text = theHouse.name
        
        // Devolver la celda
        return cell
    }
}
