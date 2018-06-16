//
//  LocationView.swift
//  M-TribesTest
//
//  Created by Islam Elshazly on 6/13/18.
//  Copyright © 2018 M-Tribes. All rights reserved.
//

import UIKit

final class PlacemarkView: UIView {


    @IBOutlet weak var view: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var engineType: UILabel!
    @IBOutlet weak var fuel: UILabel!
    @IBOutlet weak var exterior: UILabel!
    @IBOutlet weak var interior: UILabel!
    @IBOutlet weak var vin: UILabel!
    @IBOutlet weak var address: UILabel!
    
    
    //MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubViews()
        
    }
    
    
    func initSubViews(withFrame frame : CGRect) {
        
        let nib = UINib(nibName: "PlacemarkView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        view.frame = frame
        addSubview(view)
        
    }
    
    func initSubViews () {
        
        let nib = UINib(nibName: "PlacemarkView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        view.frame = bounds
        addSubview(view)
        
    }
    
    func configure(_ loaction :  MarkModel) {
        
        name.text = loaction.name
        engineType.text = loaction.engineType
        fuel.text = "\(loaction.fuel)"
        exterior.text = loaction.exterior
        interior.text = loaction.interior
        vin.text = loaction.vin
        address.text = loaction.address
        
    }
    

}
