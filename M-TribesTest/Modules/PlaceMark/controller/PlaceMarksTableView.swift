//
//  LocationsTableView.swift
//  M-TribesTest
//
//  Created by Islam Elshazly on 6/12/18.
//  Copyright © 2018 M-Tribes. All rights reserved.
//

import UIKit

final class PlaceMarksTableView: BaseViewController {
    
    //MARK:- variables
    
    var locationObj : LocationsModel = LocationsModel()
    
    //MARK- outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK- life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(UINib(nibName: "PlacemarksCell", bundle: nil), forCellReuseIdentifier: "PlacemarksCell")
        tableView.reloadData()
    }
    
    //MARK:- Helping Methods
    

}


extension PlaceMarksTableView : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationObj.placemarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let placemarksCell = tableView.dequeueReusableCell(withIdentifier: "PlacemarksCell", for: indexPath) as? PlacemarksCell {
            
            let location = locationObj.placemarks[indexPath.row]
            placemarksCell.configure(location)
            return placemarksCell
        }
        return UITableViewCell()
    }
    
}

