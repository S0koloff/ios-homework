//
//  ViewController.swift
//  Map
//
//  Created by Sokolov on 11.02.2023.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    private lazy var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Map"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshMap))
        
        
        view.addSubview(mapView)
        
        checkLocationPermissions()
        
        configMapView()
        
        takeLocationOnMap()
        
    }
    
   private func checkLocationPermissions() {
       locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
       locationManager.startUpdatingLocation()
    }
    
    private func takeLocationOnMap() {
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(takeLocationTap(gestureRecognizer:)))
        self.mapView.addGestureRecognizer(tapGesture)
    }
    
    @objc func takeLocationTap(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state != UIGestureRecognizer.State.ended {
            let touchLocation = gestureRecognizer.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            print("Coordinates : \(locationCoordinate.latitude)")
            
            let alert = UIAlertController(title: "Проложить маршрут?", message: "", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                self.addPins(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude, name: "")
                
                self.addRoute(sourcelatitude: (self.locationManager.location?.coordinate.latitude)!, sourcelongitude: (self.locationManager.location?.coordinate.longitude)!, destinationlatitude: locationCoordinate.latitude, destinationlongitude: locationCoordinate.longitude)
            }))
            
            alert.addAction(UIAlertAction(title: "Close", style: .cancel))
            
            self.present(alert, animated: true)

        }
    }
    
    @objc func refreshMap() {
        
        let annotations = self.mapView.annotations
        let overlays = self.mapView.overlays
        self.mapView.removeAnnotations(annotations)
        self.mapView.removeOverlays(overlays)
    }
    
    private func configMapView() {
        
        mapView.mapType = .standard
        mapView.showsCompass = false
        mapView.showsUserLocation = true
        
//        let center = CLLocationCoordinate2D(latitude: 59.937500, longitude: 30.308611)
//        let span = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
//        let region = MKCoordinateRegion(center: center, span: span)
//        mapView.setRegion(region, animated: true)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [ weak self] in
//            let center = CLLocationCoordinate2D(latitude: 59.937500, longitude: 30.308611)
//            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
//            let region = MKCoordinateRegion(center: center, span: span)
//            self?.mapView.setRegion(region, animated: true)
//        }
    }
    
    private func addPins(latitude: Double, longitude: Double, name: String ) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = name
        mapView.addAnnotation(annotation)
    }
    
    func addRoute(sourcelatitude: Double, sourcelongitude: Double, destinationlatitude: Double, destinationlongitude: Double) {
        let request = MKDirections.Request()
        
        let sourceCoordinate = CLLocationCoordinate2D(latitude: sourcelatitude, longitude: sourcelongitude)
        let sourcePlaceMark = MKPlacemark(coordinate: sourceCoordinate)

        let destinationCoordinate = CLLocationCoordinate2D(latitude: destinationlatitude, longitude: destinationlongitude)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationCoordinate)

        request.source = MKMapItem(placemark: sourcePlaceMark)
        request.destination = MKMapItem(placemark: destinationPlaceMark)

        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let response else {
                return
            }

            let route = response.routes[0]
            self?.mapView.delegate = self
            self?.mapView.addOverlay(route.polyline, level: .aboveRoads)

            let rect = route.polyline.boundingMapRect
            self?.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        
        render.strokeColor = UIColor.systemBlue
        render.lineWidth = 5.0
        return render
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 15, longitudeDelta: 15))
        mapView.setRegion(region, animated: true)
    }


}

