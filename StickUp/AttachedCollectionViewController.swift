//
//  AttachedCollectionViewController.swift
//  StickUp
//
//  Created by Emil Abraham Zachariah on 2019-07-24.
//  Copyright © 2019 Emil Abraham Zachariah. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class AttachedCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
var currentVC=CurrentNoteViewController()
var imageURLString=[String]()
    var images=[UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imagestring=currentVC.selNote.image{
//            print("Image-\(imagestring)")
        imageURLString=imagestring.components(separatedBy: ", ")
        }
        print("found \(imageURLString.count) images")
        for i in imageURLString{
            let urlString=getdocPath(fileName: i)
            print("final url:\(urlString)")
            let imgUrl = NSURL(fileURLWithPath: urlString) as URL
            let data = try? NSData(contentsOf: imgUrl) as Data
            if data != nil{
                let img = UIImage(data: data!)
                    //UIImage(data: data!, scale: 0.25)
                images.append(img!)
            }
            
//            if FileManager.default.fileExists(atPath: i) == true {
//                print("----Path exists-----")
//                print("img--:\(i)")
//                do{
//                    let imgurl = NSURL(fileURLWithPath: i) as URL
//                    let data=NSData(base64Encoded: i, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)! as Data
//                    let data=try NSData(contentsOf: imgurl) as Data
//                    if data != nil{
//                    let img=UIImage(data: data, scale: 0.25)
//                    //                let img=UIImage(contentsOfFile: i)
//                        images.append(img!)}
//                }
//                catch{print("No data obtained")}
//            }
//            else{
//                print("Path does not exist")
//            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    func getdocPath(fileName: String) -> String{
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectorPath:String = paths[0]
        let imagesDirectoryPath = documentDirectorPath.appending("/ImagePicker")
        let finalPath=imagesDirectoryPath.appending(fileName)
        return finalPath
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return images.count
//            imageURLString.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CustomCollectionViewCell
        // Configure the cell
//        let imgurl = NSURL(fileURLWithPath: imageURLString[indexPath.row])
//            URL(string: "http://rockinsider.com/wp-content/uploads/2011/11/BadPanda105-Visiol-EP-500x500.jpg")
//            NSURL(string: "⁨/Users/vader/Library/Developer/CoreSimulator/Devices/DEC82FFE-245C-424F-8AAA-E9165FC961CE/data/Containers/Data/Application/2243B094-7BD6-436F-8FE3-13482C944CAE/Documents5EABD2D4-D18A-4C4C-BF99-0FC260C076F7.jpeg")
            //NSURL(string: imageURLString[indexPath.row])
        
//        let data=NSData(contentsOf: imgurl as URL)
//        let img=UIImage(contentsOfFile: (imgurl.path)!)
//        let data=NSData(contentsOf: NSURL(string: "http://rockinsider.com/wp-content/uploads/2011/11/BadPanda105-Visiol-EP-500x500.jpg")! as URL)
//        if let imgdata=data{
//        let altimg=UIImage(data: imgdata as Data)
//            cell.attachedImage.image=altimg
//        }else{print("data is nill")}
        print("images.count=\(images.count)")
        cell.attachedImage.image=images[indexPath.row]
//        cell.attachedImage.transform=CGAffineTransform(rotationAngle: CGFloat.pi)
//        img
//        if let alt_img=UIImage(data: NSData(con)
//
//            NSData(contentsOf: NSURL(string: "http://rockinsider.com/wp-content/uploads/2011/11/BadPanda105-Visiol-EP-500x500.jpg")! as URL) as Data){
//            cell.attachedImage.image=alt_img
//
//        }
        
//        let imgVw=UIImageView(image: img)
//        imgVw.contentMode = .scaleAspectFit
//        cell.addSubview(imgVw)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
    //2
//        let itemsPerRow: CGFloat = 3
//        let sectionInsets = UIEdgeInsets(top: 50.0,left: 20.0,bottom: 50.0,right: 20.0)
//    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//    let availableWidth = view.frame.width - paddingSpace
//    let widthPerItem = availableWidth / itemsPerRow
//
//        let cell=collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell
//        if cell == nil{
//            return CGSize(width: 100, height: 100)
//        }
////    return CGSize(width: widthPerItem, height: widthPerItem)
//        if cell!.attachedImage.image == nil{
//            return CGSize(width: 100, height: 100)
//        }
//        else{return cell!.attachedImage.image!.size}
        return(CGSize(width: 300, height: 300))
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
