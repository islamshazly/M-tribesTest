//
//  GoogleMapVC.swift
//  M-TribesTest
//
//  Created by Islam Elshazly on 6/15/18.
//  Copyright © 2018 M-Tribes. All rights reserved.
//

import UIKit
import GoogleMaps

let kClusterItemCount = 10000
let kCameraLatitude = -33.8
let kCameraLongitude = 151.2


final class GoogleMapVC: BaseViewController {

    
    // MARK: - variables
    
    var locationObj : PlaceMarkersModel = PlaceMarkersModel()
    fileprivate var mapView: GMSMapView!
    fileprivate var clusterManager: GMUClusterManager!
    fileprivate var markers:[GMSMarker] = [GMSMarker]()
    fileprivate var tappedMarker:GMSMarker = GMSMarker()

    fileprivate var isMarkerTaped : Bool = false

    
    // MARK: - outlets
    
    
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // assing location Delegate and start updating locations
        getUserLocation(delegate: self)
        
        // Set up the cluster manager with default icon generator and renderer.
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        renderer.delegate = self
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        
        let pins = locationObj.generateGoogleItems()
        clusterManager.add(pins)
        
        // Call cluster() after items have been added to perform the clustering and rendering on map.
        clusterManager.cluster()
        
        // Register self to listen to both GMUClusterManagerDelegate and GMSMapViewDelegate events.
        clusterManager.setDelegate(self, mapDelegate: self)
        
        // user location
        mapView.isMyLocationEnabled = true
        mapView.accessibilityElementsHidden = false

        
    }
    
    //MARK: - initalizers
    
    
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: kCameraLatitude,
                                              longitude: kCameraLongitude, zoom: 10)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView
    }
    
    
}

extension GoogleMapVC : GMUClusterManagerDelegate {

    // MARK: - GMUClusterManagerDelegate
    
    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position,
                                                 zoom: mapView.camera.zoom + 1)
        let update = GMSCameraUpdate.setCamera(newCamera)
        mapView.moveCamera(update)
        return false
    }
    

}

extension GoogleMapVC : GMSMapViewDelegate {
    
    // MARK: - GMUMapViewDelegate
    
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        // did change cammer position delegate is called after the marker taped
        
        tappedMarker = marker
        isMarkerTaped = true
        hideMarkersExceptTapedMarker()
        
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        
        if isMarkerTaped {
            
            isMarkerTaped = false
            showAllMarkers()
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        if isMarkerTaped {
            
            isMarkerTaped = false
            showAllMarkers()
        }
        
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        // if we want to hide if he change the cammera postion
        // just make just the isMarkerTaped == true & call hideMarkersExceptTapedMarker()
        
    }
    
    //MARK: - show and hide markers
    
    func showAllMarkers() {
        markers.forEach {
            
            $0.opacity = 1
        }
    }
    
    func hideMarkersExceptTapedMarker() {
        
        markers.forEach {
            if $0 != tappedMarker {
                $0.opacity = 0
            } else {
                $0.opacity = 1
            }
        }
        
    }
    

}

extension GoogleMapVC : GMUClusterRendererDelegate {
    
    func renderer(_ renderer: GMUClusterRenderer, willRenderMarker marker: GMSMarker) {
        
        
        if let poiItem = marker.userData as? GooglePOIITem {
            marker.title = poiItem.title
            marker.snippet = poiItem.snippet

        }
    }
    
    func renderer(_ renderer: GMUClusterRenderer, didRenderMarker marker: GMSMarker) {
        markers.append(marker)
    }
    
}
