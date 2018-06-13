//
//  LocationCell.swift
//  M-TribesTest
//
//  Created by Islam Elshazly on 6/13/18.
//  Copyright © 2018 M-Tribes. All rights reserved.
//

import UIKit

final class PlacemarksCell: UITableViewCell {
    
    
    //MARK:- outlets
    @IBOutlet weak var locationView: PlacemarkView!
    
    
    
    //MARK:- lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configure(_ location : LocationModel) {
        
        locationView.configure(location)
    }

    
}
