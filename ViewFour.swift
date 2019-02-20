//
//  ViewFour.swift
//  Adopt-A-Plot
//
//  Created by Ari Wasch on 11/30/18.
//  Copyright © 2018 Ari Wasch. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class ViewFour: UIViewController, NSURLConnectionDataDelegate, MKMapViewDelegate{
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var label: UILabel!
    let locationManager = CLLocationManager()
    var regionMeters: Double = 1000
    var notStupid = MorePlots()
    var stupid = MorePlots()
    var plots = ViewController()
    var plot = ViewController()
    let coord = Coord.getCoords()
    var truth = createView()
    var which = SecondController()
    var theZoom = 0.001
    var zoomPos = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        plots.updatePlotNum()
        label.text = stupid.updateOrg()

        checkLocationServices()
        addAnnotations()
        
}
    override func viewDidAppear(_ animated: Bool) {
        if(plots.updatePlotNum() == ""){
            createView.isCostum = false
        }
        if(createView.locations.count <= 0){
            createView.isCostum = false
            createView.noPlot = true
        }
//        if (createView.isCostum){
//            label.text = "Plot Num: Costum Plot"
//            //createView.locations
//        }else if(createView.noPlot){
//            label.text = "NO PLOT SELECTED"
//        }else{
//            label.text = "Plot: " + plots.updatePlotNum() + " " + stupid.updateOrg()
//        }
        label.text = which.which()
        addAnnotations()
    }
    func setUpLocationManager(){
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters)
            map.setRegion(region, animated:true)
        }
    }
        func checkLocationServices(){
            if(CLLocationManager.locationServicesEnabled()){
                setUpLocationManager()
                checkLocationAuthorization()
            }else{
                checkLocationAuthorization()
            }
        }
        func checkLocationAuthorization(){
            switch CLLocationManager.authorizationStatus(){
            case .authorizedWhenInUse:
                map.showsUserLocation = true
                centerViewOnUserLocation()
                locationManager.startUpdatingLocation()
                break
            case .denied:
                let alert = UIAlertController(title: "Location Permissions", message: "Location permissions must be turned on in settings to see your location relative to your plot.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                
                self.present(alert, animated: true)
                break
            case .restricted:
                let alert = UIAlertController(title: "Location Permissions", message: "Location access is restricted on this device", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                break
            case .authorizedAlways:
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                break
            }
        }
    
        func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]){
            addAnnotations()
        }
        func addAnnotations() {
            map?.delegate = self
            
            
            //        let coord = Coord.getCoords()
            //
            //        //var locations: [CLLocationCoordinate2D] = []
            //        if coord.getInfo().index(ofAccessibilityElement: 23) >= 1,{
            //
            //        }
            //var location: [CLLocation] = []
            var locations: [CLLocation] = []
            var tempLocations: [CLLocation] = []
            var locationLat: [Double] = []
            var string = "80"
            var bool = false
            if exists(){
//                string = ViewController.plotNumber
                string = plots.updatePlotNum()
                print("it worked?")
            }else{
                print("Not working")
            }
            
            //for item in coord{
            
            //}
            for item in coord{
                bool = item.getInfo()!.contains(string)
                //print(item.getInfo())
                //print(bool)
                
                
                if bool{
                    //print(bool)
                    locations.append(CLLocation(latitude: item.getLatitude(), longitude: item.getLongitude()))
                    print(item.getLatitude(), " ", item.getLongitude())
                    //                print("lat: ", item.getLatitude())
                    //                print("long: ", item.getLongitude())
                    locationLat.append(item.getLatitude())
                    print(item.getInfo())
                    print(string)
                    print(item.getInfo()!.contains(string))
                }
            }
            
            //using tallest to shortest
            //        locationLat = selectionSort(locationLat)
            //        for i in 0...locations.count-1{
            //        for j in i...locations.count-1{
            //            if coord[i].getLatitude() == locationLat[j]{
            //                tempLocations.append(CLLocation(latitude: coord[i].getLatitude(), longitude: coord[i].getLongitude()))
            //            }
            //        }
            //        }
            //        locations = removeDuplicates(array: tempLocations)
            //ends here
            //
            //        var distList: [Double] = []
            //        for i in 0...locations.count-1{
            //            for j in 0...locations.count-1{
            //
            //            distList.append(locations[i].distance(from: locations[j]))
            //            }
            //        }
            //        distList = removeDuplicatesD(array: distList)
            //        distList = selectionSort(distList)
            //        for i in 0...distList.count-1{
            //            for j in i...distList.count-1{
            //                if locations[i].distance(from: locations[j]) == distList[i]{
            //                    locations.append(locations[i])
            //                    locations.append(locations[j])
            //                   // distList.remove(at: i)
            //                }
            //            }
            //        }
            //        locations = removeDuplicates(array: locations)
            //
            
            //       var locations = [CLLocation(latitude: 38.939096, longitude: -76.469124), CLLocation(latitude: 38.938694,longitude: -76.469653), CLLocation(latitude: 38.938282, longitude: -76.469181)]
            //mapView?.addAnnotations(locations as! [MKAnnotation])
            if(truth.updateTruth()){
                locations = truth.updateCustom()
                regionMeters = 100
            }
            var testCoordinates = locations.map({(location: CLLocation!) -> CLLocationCoordinate2D in return location.coordinate})
            var actDist: Double = 10000000
            var testPoly = MKPolyline(coordinates: &testCoordinates, count: locations.count)
            // this works
            let select = plots.updatePlotNum()
            // this was taken out, it works now may need to add later
            //notStupid.updateOrg().contains("Bay Ridge")
            if !(select.elementsEqual("38") || select.elementsEqual("70") ||
                select.elementsEqual("49") ||
                select.elementsEqual("86") || select.elementsEqual("87") ||
                select.elementsEqual("92") || select.elementsEqual("98") || select.elementsEqual("100") || select.elementsEqual("103") || select.elementsEqual("106") || select.elementsEqual("109")){
            if(!truth.updateTruth()){
            for i in 0...locations.count-1{
                for j in 0...locations.count-1{
                    if(i > 0 && j > 0){
                        var totDist: Double = 0
                        locations.swapAt(i, j)
                        for x in 1...locations.count-1{
                            totDist += locations[x-1].distance(from: locations[x])
                        }
                        if totDist < actDist{
                            print(locations.count)
                            actDist = totDist
                            testCoordinates = locations.map({(location: CLLocation!) -> CLLocationCoordinate2D in return location.coordinate})
                            testPoly = MKPolyline(coordinates: &testCoordinates, count: locations.count)
                            print(totDist)
                            print(actDist)
                        }
                    }
                }
            }
            }
            }
            //to this
            
            
            //var coordinates = locations.map({(location: CLLocation!) -> CLLocationCoordinate2D in return location.coordinate})
            //var polyline = MKPolyline(coordinates: &coordinates, count: locations.count)
            
            //this below finds the region that it should hover
            let polygon = MKPolygon(coordinates: &testCoordinates, count: locations.count)
            let polylines = MKPolyline(coordinates: &testCoordinates, count: locations.count)
            var lat:Double = 0
            var long:Double = 0
            if(locations.count > 0){
            for i in 0...locations.count-1{
                lat += locations[i].coordinate.latitude
                long += locations[i].coordinate.longitude
            }
            lat = lat/Double(locations.count)
            long = long/Double(locations.count)
            let span = MKCoordinateSpan(latitudeDelta: theZoom, longitudeDelta: theZoom)
                var polyRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: span)
                zoomPos = CLLocationCoordinate2D(latitude: lat, longitude: long)
                if(truth.updateTruth()){
                    polyRegion = MKCoordinateRegion(center: truth.updateCustom()[0].coordinate, span: span)
                    map?.addOverlay(polylines)
                    zoomPos = truth.updateCustom()[0].coordinate
                }else{
                    map?.addOverlay(polygon)
                }
            //that ends here
            //polyRegion.center.longitude = long
            //polyRegion.center.latitude = lat
            
            ViewController.returnPoly = polygon
            map.setRegion(polyRegion, animated:true)
            map?.addOverlay(polygon)
            }else{
                createView.noPlot = true
            }
}
    func exists() -> Bool{
        var result = false;
        for item in coord{
            if item.getInfo()!.contains(plots.updatePlotNum()){
                result = true;
            }
        }
        return result
}
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let renderer = MKCircleRenderer(overlay: overlay)
            renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 2
            return renderer
            
        } else if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.red
            renderer.lineWidth = 2
            return renderer
            
        } else if overlay is MKPolygon {
            let renderer = MKPolygonRenderer(polygon: overlay as! MKPolygon)
            //renderer.fillColor = UIColor.blue.withAlphaComponent(0.5)
            renderer.strokeColor = UIColor.red
            renderer.lineWidth = 2
            return renderer
        }
        
        return MKOverlayRenderer()
    }
    @IBAction func zoomIn(sender: UIButton){
        theZoom *= 0.5
        if(theZoom <= 0.0001){
            theZoom = 0.0001
        }
        let span = MKCoordinateSpan(latitudeDelta: theZoom, longitudeDelta: theZoom)
        let polyRegion = MKCoordinateRegion(center:map.centerCoordinate, span: span)
        map.setRegion(polyRegion, animated:true)
    }
    @IBAction func zoomOut(sender: UIButton){
        theZoom *= 1.5
        if(theZoom >= 100){
            theZoom = 100
            print("this thing", theZoom)
        }
        let span = MKCoordinateSpan(latitudeDelta: theZoom, longitudeDelta: theZoom)
        let polyRegion = MKCoordinateRegion(center:map.centerCoordinate, span: span)
        map.setRegion(polyRegion, animated:true)
        
    }
    @IBAction func myLocation(sender: UIButton){
        checkLocationAuthorization()
        let span = MKCoordinateSpan(latitudeDelta: theZoom, longitudeDelta: theZoom)
        let polyRegion = MKCoordinateRegion(center:map.centerCoordinate, span: span)
        map.setRegion(polyRegion, animated:true)
    }
    @IBAction func myPlot(sender: UIButton){
        addAnnotations()
    }
}
