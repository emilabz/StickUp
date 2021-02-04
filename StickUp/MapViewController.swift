//
//  MapViewController.swift
//  StickUp
//
//  Created by Emil Abraham Zachariah on 2019-07-26.
//  Copyright © 2019 Emil Abraham Zachariah. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    var loc=[[CLLocationCoordinate2D]]()
    var strloc=String()
    @IBOutlet weak var mView: MKMapView!
    var homeVC=HomeTableViewController()
//    var locManager=CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
//        locManager.delegate=self
//        mView.delegate=self
//        if homeVC.twoarr.count == 0{
//            print("Empty note list")
//        }
//        else{
//            getLoc()
//        }
//        locManager.requestWhenInUseAuthorization()
//        mView.showsUserLocation=true
//        let str=homeVC.twoarr[homeVC.twoarr.count-1][homeVC.twoarr[homeVC.twoarr.count-1].count-1].location!
//        print("\(str)")
//        let strarr=str.components(separatedBy: ", ")
//        for i in strarr{
//            print("\(i)")
//        }
//        let lat=Double(strarr[0])!
//        let long=Double(strarr[1])!
//        print("Lat:\(lat), Long:\(long)")
//        let coord=CLLocationCoordinate2D(latitude: lat, longitude: long)
//        let annot=MKPointAnnotation()
//        annot.coordinate=coord
//        annot.title="Last Note"
//        annot.subtitle="Category"
//        mView.addAnnotation(annot)
//        getLoc()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        mView.delegate=self
        if homeVC.twoarr.count == 0{
            print("Empty note list")
        }
        else{
            getLoc()
        }
    }
    func getLoc(){
        var k=0
        for i in homeVC.twoarr{
            loc.append([])
            for j in i{
                let stringloc=j.location?.components(separatedBy: ", ")
                if let lat=Double(stringloc![0]){
                    if let long=Double(stringloc![1]){
                        print("at index \(k) of \(homeVC.twoarr.count)")
                        let coord=CLLocationCoordinate2D(latitude: lat, longitude: long)
                        loc[k].append(coord)
                        print("appended at index \(k) of \(homeVC.twoarr.count)")
                        let annot=MKPointAnnotation()
                        annot.coordinate=coord
                        annot.title=j.subject!
                        annot.subtitle=j.category!
                        mView.addAnnotation(annot)
                    }
                }
            }
            k += 1
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view: MKMarkerAnnotationView
        view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "annotationvw")
        view.canShowCallout = true
        view.calloutOffset = CGPoint(x: -5, y: 5)
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotation")
//            as? MKMarkerAnnotationView {
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("callout tapped")
        let cordinate=(view.annotation?.coordinate)!
        var k=0
        for i in homeVC.categorylist{
            if ((view.annotation?.subtitle)! == i.cat_name){
                break
            }
            k += 1
        }
        //        for i in loc[k]{
        //            if
        //        }
        var currNote:CoreNote
        for i in homeVC.twoarr[k]{
            if ((view.annotation?.title)! == i.subject!){
                currNote=i
                performSegue(withIdentifier: "maptocurrent", sender: i)
            }
        }
    }
    
    
//    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
////        return nil
//        print("location\(userLocation.coordinate.latitude)-\(userLocation.coordinate.longitude)")
//    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let currentVC = segue.destination as? CurrentNoteViewController{
            currentVC.homeVC=homeVC
            if let note=sender as? CoreNote{
                currentVC.selNote=note;
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
