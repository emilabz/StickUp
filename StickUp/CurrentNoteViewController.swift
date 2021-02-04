//
//  CurrentNoteViewController.swift
//  StickUp
//
//  Created by Emil Abraham Zachariah on 2019-07-13.
//  Copyright © 2019 Emil Abraham Zachariah. All rights reserved.
//

import UIKit
import CoreLocation
class CurrentNoteViewController: UIViewController,UIImagePickerControllerDelegate,CLLocationManagerDelegate,UINavigationControllerDelegate  {
    var homeVC=HomeTableViewController()
    
    @IBOutlet weak var btnattachedImg: UIButton!
    
    @IBOutlet weak var txtSubject: UITextField!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var txtContent: UITextView!
    
    @IBOutlet weak var btnEditAttach: UIBarButtonItem!
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var btnDelImg: UIButton!
    var cord=CLLocationCoordinate2D()
    var selNote=CoreNote()
    var locManager=CLLocationManager()
    var imagePicker=UIImagePickerController()
    var urlString=String()
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager.requestWhenInUseAuthorization()
        imagePicker.delegate=self
        txtContent.layer.borderWidth=1
        btnDelImg.isHidden=true
        if (selNote.image == ""){
            btnattachedImg.isEnabled=false
            btnattachedImg.isHidden=true
        }
        txtSubject.text=selNote.subject
        if let date=selNote.dateTime{
            let dateFormatter=DateFormatter()
            dateFormatter.timeZone=TimeZone(abbreviation: "EST")
            dateFormatter.dateFormat = "yyyy-MM-dd, h:m:s"
            let datestr = dateFormatter.string(from: date)
            print("inside cellDate:\(date)::\(datestr)")
            lblDateTime.text=datestr
        }
        else{
            lblDateTime.text="Date"}
//            String(selNote.dateTime)
        txtContent.text=selNote.content
        urlString=selNote.image!
        print("images:\n\(selNote.image!)")
        // Do any additional setup after loading the view.
        let loc=(selNote.location?.components(separatedBy: ", "))!
        cord=CLLocationCoordinate2D(latitude: Double(loc[0]) as! CLLocationDegrees, longitude: Double(loc[1]) as! CLLocationDegrees)
        let clloc=CLLocation(latitude: cord.latitude, longitude: cord.longitude)
        let geocoder=CLGeocoder()
                geocoder.reverseGeocodeLocation(clloc) { (placemarks, error) in
                    if let er=error{
                        print("Error")
                        return
                    }
                    if let placemark=placemarks?.first{
                        print("Gotloc string:\(placemark.thoroughfare)")
                        var address="\(placemark.subThoroughfare!) \(placemark.thoroughfare!), \(placemark.locality!), \(placemark.country!)"
        //                address=address?.appending(placemark.thoroughfare!)
                        self.lblLocation.text=address
                        self.lblLocation.adjustsFontSizeToFitWidth=true
                        return
                    }
                }
        
     /*   let geocoder = CLGeocoder()
        
        // Look up the location and pass it to the completion handler
        let loc=(selNote.location?.components(separatedBy: ", "))!
        let clloc=CLLocation(latitude: 100, longitude: 100)
//        let clloc=CLLocation(latitude: Double(loc[0]) as! CLLocationDegrees, longitude: Double(loc[1]) as! CLLocationDegrees)
        print("clloc:\(clloc)")
        print("Location:\(loc)")
        var locstring=""
        geocoder.reverseGeocodeLocation(clloc) { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                print("no error")
                locstring="\(firstLocation)"
                //                                                CLGeocodeCompletionHandler(firstLocation)
                //                                                com(firstLocation)
            }
            else{
                print("Error found:\(error)")
            }

        }*/
//        geocoder.reverseGeocodeLocation(clloc, preferredLocale: nil){(placemarks, error) in
//            let placemark=placemarks?[0]
//            completion(placemark)
//        }
//        geocoder.reverseGeocodeLocation(clloc, completionHandler: <#T##CLGeocodeCompletionHandler##CLGeocodeCompletionHandler##([CLPlacemark]?, Error?) -> Void#>)
//        geocoder.reverseGeocodeLocation(clloc, completionHandler: { (placemarks, error) in
//                                            if error == nil {
//                                                let firstLocation = placemarks?[0]
//                                                locstring="\(firstLocation)"
////                                                CLGeocodeCompletionHandler(firstLocation)
////                                                com(firstLocation)
//                                            }
//                                            else {
//                                                // An error occurred during geocoding.
//                                                print("Error found")
////                                                CLGeocodeCompletionHandler(nil)
//                                            }
//        })
//        print("locString\(locstring)")
    }
    
    @IBAction func EditClicked(_ sender: UIBarButtonItem) {
        if(btnEditAttach.tag == 1){
            btnEditAttach.title="Attach"
            btnEditAttach.tag=0;
            btnSave.isHidden=false
            if(btnattachedImg.isHidden == false){
                btnDelImg.isHidden=false
            }
            txtSubject.isUserInteractionEnabled=true
            txtContent.isEditable=true
            
        }else{
            print("Attach clicked")
            let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.openCamera()
            }))
            
            alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                self.openGallery()
            }))
            
            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    
    
    
    @IBAction func btnDeleteClicked(_ sender: UIButton) {
        urlString=""
        btnDelImg.isHidden=true
        btnattachedImg.isHidden=true
        let alert=UIAlertController(title: "Info", message: "Images deleted successfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert,animated: true)
    }
    
    
    @IBAction func btnSaveClicked(_ sender: UIButton) {
        let date=Date()
        var n=0
        for i in homeVC.categorylist{
            if selNote.category == i.cat_name{
                break
            }
           n += 1
        }
        var m=0
        for i in homeVC.twoarr[n]{
            if selNote.subject==i.subject{
                break
            }
            m += 1
        }
        print("selnode:\(homeVC.twoarr[n][m].category)-\(homeVC.twoarr[n][m].subject)")
        selNote.subject=txtSubject.text
        selNote.content=txtContent.text
        selNote.dateTime=date
        selNote.image=urlString
        var loc:CLLocationCoordinate2D
        if CLLocationManager.locationServicesEnabled(){
            locManager.delegate=self
            locManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters
            locManager.startUpdatingLocation()
            loc=(locManager.location?.coordinate)!
            let a=CLLocation(latitude: loc.latitude, longitude: loc.longitude)
            let b=CLLocation(latitude: cord.latitude, longitude: cord.longitude)
            print("New loc - old loc:\(a.distance(from: b))")
            if a.distance(from: b) > 100 {
                let lat=Double(loc.latitude)
                let long=Double(loc.longitude)
                //            print("\(String(Double(cord?.latitude)))")
                let locString="\(lat), \(long)"
                print("locString=\(locString)")
                alertLoc(adr: "a new location", latlong: locString)
            }
        }
        
        PersistanceService.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func saveImage(info:[UIImagePickerController.InfoKey:Any]){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        // Get the Document directory path
        let documentDirectorPath:String = paths[0]
        // Create a new path for the new images folder
        
        let imagesDirectoryPath = documentDirectorPath.appending("/ImagePicker")
        //        stringByAppendingString("/ImagePicker")
        var objcBool:ObjCBool = true
        let isExist = FileManager.default.fileExists(atPath: imagesDirectoryPath, isDirectory: &objcBool)
        // If the folder with the given path doesn't exist already, create it
        if isExist == false{
            do{
                try FileManager.default.createDirectory(atPath: imagesDirectoryPath, withIntermediateDirectories: true, attributes: nil)
                print("created path at \(imagesDirectoryPath)")
            }catch{
                print("Something went wrong while creating a new folder")
            }
        }
        else{
            print("path exists at \(imagesDirectoryPath)")
        }
        var imagePath = Date().description
        print(imagePath)
        imagePath=imagePath.replacingOccurrences(of: ":", with: "-")
        imagePath=imagePath.replacingOccurrences(of: " ", with: "_")
        let relPath="/\(imagePath).png"
        imagePath = imagesDirectoryPath.appending("/\(imagePath).png")
        let image=info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let data = image.pngData()!
        //        let imagePath = data.base64EncodedString(options: .lineLength64Characters)
        //        if imagePath != nil{
        //            print("Image inserted not nil")
        //        }
        //        do{
        //        let success =
        //            try data.write(to: URL(string: imagePath)!)
        FileManager.default.createFile(atPath: imagePath, contents: data, attributes: nil)
        //           try FileManager.default.createFile(atPath: imagePath, contents: data, attributes: nil)
        //        }catch{
        //            print("Error saving")
        //        }
        if FileManager.default.fileExists(atPath: imagePath) == true {
            print("Saved file located and saved suceessfully")
        }
        if urlString.isEmpty{
            urlString="\(relPath)"
        }
        else{
            urlString.append(", \(relPath)")
        }
        print("urlpath:\(urlString)")
//        let alert=UIAlertController(title: "Info", message: "Image added successfully", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        self.present(alert,animated: true)
    }
    
    
    func alertLoc(adr:String, latlong:String){
        let alert = UIAlertController(title: "Change Location", message: "You seem to have edited the note at \(adr). Do you want to save this new address?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.selNote.location=latlong
//            self.selNote.locName=adr
            PersistanceService.saveContext()
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            PersistanceService.saveContext()
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert,animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        saveImage(info: info);
        picker.dismiss(animated: true, completion: nil)
        let alert=UIAlertController(title: "Info", message: "Image added successfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert,animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newnoteVC=segue.destination as? AttachedCollectionViewController{
            newnoteVC.currentVC=self
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
