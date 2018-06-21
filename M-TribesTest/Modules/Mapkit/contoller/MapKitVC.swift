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


final class MapKitVC: BaseViewController {
    
    // MARK: - variables
    
    var placeMarksObj : PlaceMarkersModel = PlaceMarkersModel()
    fileprivate var annotationsView = [MKAnnotationView]()
    fileprivate var isPinTaped : Bool = false
    fileprivate let manager = ClusterManager()
    fileprivate var tappedAnnotation = MKAnnotationView()
    
    
    // MARK: - outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        // use it form BaseViewController , i will use it again at GoogleMapVC
        getUserLocation(delegate: self)
        //        mapView.register(ClusterAnnotation.self, forAnnotationViewWithReuseIdentifier: "Cluster")
        
        let marksAnnotations = placeMarksObj.generateAnnotations()
        
        manager.cellSize = nil
        manager.maxZoomLevel = 17
        manager.minCountForClustering = 3
        manager.clusterPosition = .nearCenter
        
        manager.add(marksAnnotations)
        
        mapView.showsUserLocation = true
        
    }
    
    
}


extension MapKitVC : MKMapViewDelegate {
    
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
        
        // if i tapped on pin and zoomed in not show the other pins
        
        // so i relood the map if the user did not tap on pin
        
        // or we consider he didDeselect when he change the region , it's up to business.
        
        if isPinTaped == false {
            
            manager.reload(mapView: mapView)
        } else {
            
            annotationsView.forEach {
                
                if $0 != tappedAnnotation {
                    $0.alpha = 0
                } else {
                    $0.alpha = 1
                }
            }
            
        }
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
        
        if let _ = annotation as? LocationAnnotation {
            isPinTaped = true
            tappedAnnotation = view
            annotationsView.forEach {
                
                if $0 != view {
                    $0.alpha = 0
                } else {
                    $0.alpha = 1
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
        guard let annotation = view.annotation else { return }
        
        if let  _ = annotation as? LocationAnnotation {
            isPinTaped = false
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


