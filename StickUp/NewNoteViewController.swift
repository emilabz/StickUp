//
//  NewNoteViewController.swift
//  StickUp
//
//  Created by Emil Abraham Zachariah on 2019-07-13.
//  Copyright © 2019 Emil Abraham Zachariah. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class NewNoteViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate {
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var imagePicker=UIImagePickerController()
    var categories = [Category]()
    var selcat:String?
    var flag=0;
    var homeVC=HomeTableViewController()
    var urlString=String()
    var locManager=CLLocationManager()
    @IBOutlet weak var txtSubject: UITextField!
    @IBOutlet weak var txtContent: UITextView!
    var add=UIBarButtonItem(title: "Add", style: .plain, target: nil, action: nil)
    @IBOutlet weak var btnCategory: UIButton!
    @IBOutlet weak var txtCategory: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager.requestWhenInUseAuthorization()
        imagePicker.delegate=self
        navigationController?.navigationItem.rightBarButtonItem=add
        let fetchReq:NSFetchRequest<Category>=Category.fetchRequest()
        if let catlist = try? PersistanceService.context.fetch(fetchReq){
            //            for i in 0...corenotes.count-1{
            //                print("i:\(i) "+corenotes[i].subject!)}
            categories=catlist
            print("catlist count=\(catlist.count)")
            if catlist.count == 0{
                flag=1;
                btnCategory.isUserInteractionEnabled=false
                let mySelectedAttributedTitle = NSAttributedString(string: "Category",attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
                btnCategory.setAttributedTitle(mySelectedAttributedTitle, for: .normal)
            }
            else{
                btnCategory.setAttributedTitle(NSAttributedString(string: "Click to select Category"), for: .normal)
//                setTitle("Click here to select Category", for: .normal)
                
//                btnCategory.sizeToFit()
                btnCategory.titleLabel?.adjustsFontSizeToFitWidth=true
                txtCategory.isHidden=true
            }
        }
        txtContent.layer.borderWidth=0.5
        txtContent.layer.borderColor=#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSaveClicked(_ sender: UIButton) {
        var locString=String()
        if CLLocationManager.locationServicesEnabled(){
            locManager.delegate=self
            locManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters
            locManager.startUpdatingLocation()
            let cord=locManager.location?.coordinate
            let lat=Double(cord!.latitude)
            let long=Double(cord!.longitude)
//            print("\(String(Double(cord?.latitude)))")
            locString="\(lat), \(long)"
            print("locString=\(locString)")
        }
        let context=PersistanceService.context
        let newnote=CoreNote(entity: CoreNote.entity(), insertInto: context)
        let subj=txtSubject.text!
        let content=txtContent.text!
        if flag==1{
            let catObj=Category(entity: Category.entity(), insertInto: context)
            print("created obj")
            if let category=txtCategory.text{
                catObj.cat_name=category
            }
            else{
                catObj.cat_name=selcat;
            }
//            newnote.category=catObj.cat_name
        }
        newnote.subject=subj
        newnote.content=content
        newnote.location=locString
        newnote.image=urlString
        let date=Date()
//        let dateFormatter=DateFormatter()
//        dateFormatter.timeZone=TimeZone(abbreviation: "EST")
//        dateFormatter.dateFormat = "yyyy-MM-dd, h:m:s"
//        let datestr = dateFormatter.string(from: date)
//        print("Insering....Date:\(date)::\(datestr)")
        newnote.dateTime=date
        newnote.category=txtCategory.text!
        PersistanceService.saveContext()
        //homeVC.notelist.append(Note(subject: subj, content: content, dateTime: "date", category: "category"))
        homeVC.tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCategoryClicked(_ sender: UIButton) {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource=self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
//        picker.settext
        self.view.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
//        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action:#selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    @objc func onDoneButtonTapped() {
//        txtCategory.text=selcat
        txtCategory.isHidden=false
        print("OnDone selcat: \(categories[0].cat_name)")
        if selcat != ""{
            flag=0
            selcat = categories[0].cat_name;
           print("not custom done")
            txtCategory.isUserInteractionEnabled=false
            txtCategory.text=selcat
        }
        else{
            flag=1;
            print("custom entered flag=\(flag)")
//            btnCategory.sizeThatFits(CGSize(width: 133, height: btnCategory.frame.height))
            txtCategory.isUserInteractionEnabled=true
        }
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    @IBAction func btnAttachTapped(_ sender: UIBarButtonItem) {
        print("Attach tapped")
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
        
//    func showActionSheet(vc: UIViewController) {
//        let currentVC = vc
//        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        
//        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
//            self.camera()
//        }))
//        
//        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
//            self.photoLibrary()
//        }))
//        
//        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        
//        vc.present(actionSheet, animated: true, completion: nil)
//    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        saveImage(info: info);
        /*var url=String()
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            let imgName = imgUrl.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let localPath = documentDirectory?.appending(imgName)
            
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            let data = image.pngData()! as NSData
            if data != nil{ print("Data retrieved");}
            let sucess=data.write(toFile: localPath!, atomically: true)
            if(sucess == true){
                print("Image save successfully")
            }
            else{
            print("====FAIL=====")
            }
            //let imageData = NSData(contentsOfFile: localPath!)!
            let photoURL = URL.init(fileURLWithPath: localPath!)//NSURL(fileURLWithPath: localPath!)
            print("Selected:\(photoURL)")
            if urlString.isEmpty{
                urlString="\(photoURL.path)"
            }
            else{
                urlString.append(", \(photoURL.path)")
            }
            url=imgUrl.absoluteString
        }
        
        print("New image url:\(url)")*/
        
        picker.dismiss(animated: true, completion: nil)
        let alert=UIAlertController(title: "Info", message: "Image added successfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert,animated: true)
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
        
    }
    
//    func saveImageDocumentDirectory(){
//        let fileManager = NSFileManager.defaultManager()
//        let paths = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString).stringByAppendingPathComponent(“apple.jpg”)
//        let image = UIImage(named: “apple.jpg”)
//        print(paths)
//        let imageData = UIImageJPEGRepresentation(image!, 0.5) fileManager.createFileAtPath(paths as String, contents: imageData, attributes: nil)
//    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return 5
        return categories.count+1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        print(categories[row].cat_name!)
//        print("hi\(component)r\(row)")
        if row == categories.count{
            return "Custom"
        }
        else{
           // print("else row \(row)")
            return (categories[row].cat_name)
//        return "Hello\(row)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print(categories[row].cat_name!)
        if row == categories.count{
            print("Custom selected")
            selcat=""
        }
        else{
            print(categories[row].cat_name!)
            selcat=categories[row].cat_name!
//            txtCategory.isUserInteractionEnabled=false
        }
//        print("select at \(row)")
    }
    
   /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
*/
}
