import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    let addAdressButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "addAddress"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let routeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "route"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "reset"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    var annotationsArray = [MKPointAnnotation]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        
        addAdressButton.addTarget(self, action: #selector(addAdressButtonTapped), for: .touchUpInside)
        routeButton.addTarget(self, action: #selector(routeButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        
        mapView.delegate = self
    }
    
    @objc func addAdressButtonTapped() {
        alertAddAddress(title: "Add", placeholder: "Enter address") { [self] (text) in
            setupPlacemark(addressPlace: text)
        }
    }
    
    @objc func routeButtonTapped() {
        
        for index in 0...annotationsArray.count - 2 {
            createDirectionRequest(startCoordinate: annotationsArray[index].coordinate, destinationCoordinate: annotationsArray[index + 1].coordinate)
        }
        
        mapView.showAnnotations(annotationsArray, animated: true)
        
    }
    
    @objc func resetButtonTapped() {
        
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        annotationsArray = [MKPointAnnotation]()
        routeButton.isHidden = true
        resetButton.isHidden = true
        
    }
    
//    private func setupPlacemark(addressPlace: String) {
//        
//        let geocoder = CLGeocoder()
//        geocoder.geocodeAddressString(addressPlace) { [self] (placemarks, error) in
//            
//            if let error = error {
//                print(error)
//                self.alertError(title: "Error", message: "Server unavailable, repeat pleas")
//                return
//            }
//            
//            guard let placemarks = placemarks else { return }
//            let placemark = placemarks.first
//            
//            let annotation = MKPointAnnotation()
//            annotation.title = addressPlace
//            
//            guard let placemarkLocation = placemark?.location else { return }
//            annotation.coordinate = placemarkLocation.coordinate
//            
//            annotationsArray.append(annotation)
//            
//            if annotationsArray.count > 2 {
//                routeButton.isHidden = false
//                resetButton.isHidden = false
//            }
//            
//            mapView.showAnnotations(annotationsArray, animated: true)
//        }
//    }
//    
//    private func createDirectionRequest(startCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
//        
//        let startLocation = MKPlacemark(coordinate: startCoordinate)
//        let destinationLocation = MKPlacemark(coordinate: destinationCoordinate)
//        let request = MKDirections.Request()
//        request.source = MKMapItem(placemark: startLocation)
//        request.destination = MKMapItem(placemark: destinationLocation)
//        request.transportType = .walking
//        request.requestsAlternateRoutes = true
//        
//        let diraction = MKDirections(request: request)
//        diraction.calculate { (responce, error) in
//            if let error = error {
//                print(error)
//            }
//            
//            guard let responce = responce else {
//                self.alertError(title: "Error", message: "The route is not available")
//                return
//            }
//            
//            var minRoute = responce.routes[0]
//            for route in responce.routes {
//                minRoute = (route.distance < minRoute.distance) ? route : minRoute
//            }
//            
//            self.mapView.addOverlay(minRoute.polyline)
//            
//        }
//    }
}

