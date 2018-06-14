//
//  MapVC.swift
//  M-TribesTest
//
//  Created by Islam Elshazly on 6/13/18.
//  Copyright © 2018 M-Tribes. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Cluster


final class LocationsVC: BaseViewController {
    
    // MARK: - variables
    
    var locationObj : LocationsModel = LocationsModel()
    fileprivate var locationManager: CLLocationManager!
    fileprivate var marksAnnotations = [LocationAnnotation]()
    fileprivate var annotationsView = [MKAnnotationView]()
    fileprivate var isPinTaped : Bool = false
    let manager = ClusterManager()
    
    
    // MARK: - outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        //        mapView.register(ClusterAnnotation.self, forAnnotationViewWithReuseIdentifier: "Cluster")
        getUserLocation()
        
        marksAnnotations = [LocationAnnotation]()
        
        manager.cellSize = nil
        manager.maxZoomLevel = 17
        manager.minCountForClustering = 3
        manager.clusterPosition = .nearCenter
        
        
        
        for mark in locationObj.placemarks {
            let annotation = LocationAnnotation(lat: mark.lat, long: mark.long, title: mark.name, subTitle: mark.address)
            marksAnnotations.append(annotation)
        }
        
        manager.add(marksAnnotations)
    }
    
    func getUserLocation() {
        if (CLLocationManager.locationServicesEnabled()) {
            if locationManager == nil {
                locationManager = CLLocationManager()
            }
            locationManager?.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            
        }
    }
    
    
}

//MARK:- locations Delegate
extension LocationsVC : CLLocationManagerDelegate{
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        //        self.mapView.setRegion(region, animated: true)
        
        mapView.showsUserLocation = true
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways ,.authorizedWhenInUse:
            break
        default:
            UIAlertController.ShowAlert(VC: self, message: "Please go into Settings and give this app authorization to your location.", action: nil)
        }
    }
    
}

extension LocationsVC : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation = annotation as? ClusterAnnotation {
            guard let style = annotation.style else { return nil }
            let identifier = "Cluster"
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if let view = view as? ClusterAnnotationView {
                view.annotation = annotation
                
                view.configure(with: style)
            } else {
                view = ClusterAnnotationView(annotation: annotation, reuseIdentifier: identifier, style: .color(.red, radius: 25))
            }
            return view
        } else {
            guard let annotation = annotation as? LocationAnnotation else { return nil }
            
            let identifier = "marker"
            var view: MKMarkerAnnotationView
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKMarkerAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .infoDark)
                
            }
            
            return view
        }
        
        
    }
    
    
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        manager.reload(mapView: mapView)
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard let annotation = view.annotation else { return }
        
        if let cluster = annotation as? ClusterAnnotation {
            var zoomRect = MKMapRectNull
            for annotation in cluster.annotations {
                let annotationPoint = MKMapPointForCoordinate(annotation.coordinate)
                let pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0)
                if MKMapRectIsNull(zoomRect) {
                    zoomRect = pointRect
                } else {
                    zoomRect = MKMapRectUnion(zoomRect, pointRect)
                }
            }
            mapView.setVisibleMapRect(zoomRect, animated: true)
        }
        
        if let pin = annotation as? LocationAnnotation {
            isPinTaped = !isPinTaped
            annotationsView.forEach {
                if isPinTaped {
                   
                    if $0 != view {
                        $0.alpha = 0
                    } else {
                        $0.alpha = 1
                    }
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
        guard let annotation = view.annotation else { return }

        if let pin = annotation as? LocationAnnotation {
            isPinTaped = !isPinTaped
            annotationsView.forEach {
                        $0.alpha = 1
                }
            }
        }
        
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        annotationsView.append(contentsOf: views)
        views.forEach { $0.alpha = 0 }
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            views.forEach { $0.alpha = 1 }
        }, completion: nil)
    }
    
    
}


