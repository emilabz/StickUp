//
//  HomeTableViewController.swift
//  StickUp
//
//  Created by Emil Abraham Zachariah on 2019-07-13.
//  Copyright © 2019 Emil Abraham Zachariah. All rights reserved.
//

import UIKit
import CoreData
class HomeTableViewController: UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var twoarr : [[CoreNote]] = []
    var currsection = -1
    var toindex = -1
    var tempcat = [Category]()
    var catpicker=UIPickerView()
    var pickervc=UIViewController();
    var sortPicker=UIPickerView()
    var sortProps=[["Sort by date","Sort by title"],["Ascending","Descending"]]
    var alertc=UIAlertController()
    var txtCategory=UITextField()
    var searchArray=[CoreNote]()
    var sortArray:[[CoreNote]]=[]
    var searchflag=false
    var sortflag=false
//    var resultSearchController = UISearchController()
//    var twoarr : [[String]] = []
    var notelist = [CoreNote]()
    var categorylist = [Category]()
    
    
    @IBOutlet weak var barbtnLocation: UIBarButtonItem!
    @IBOutlet weak var barbtnAction: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barbtnAction.tag=0
        let date=Date()
        let dateFormatter=DateFormatter()
        dateFormatter.timeZone=TimeZone(abbreviation: "EST")
        dateFormatter.dateFormat = "yyyy-MM-dd, h:m:s"
        let str = dateFormatter.string(from: date)
        print("Date:\(date)::\(str)")
        
        /*
         let responseString = "2015-8-17 GMT+05:30"
         var dFormatter = NSDateFormatter()
         dFormatter.dateFormat = "yyyy-M-dd ZZZZ"
         var serverTime = dFormatter.dateFromString(responseString)
         println("NSDate : \(serverTime!)")
 */
//        getData()
//        addData()
//        tableView.reloadData();
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        barbtnAction.tag=0
        barbtnAction.title="Actions"
        barbtnAction.tintColor=nil
        searchflag=false
        sortflag=false
        barbtnAction.tag=0
//        let btnimgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100));
        let btnimg=resizeImage(image: UIImage(named: "location.png")!, targetSize: CGSize(width: 25, height: 25))
//            UIImage(named: "location.png") as CIImage
//        btnimg!.draw(in: CGRect(x: 0, y: 0, width: 10, height: 10))
//        let btnloc=UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        btnloc.setImage(btnimg, for: .normal)
////        btnimgView.image=btnimg
//        UIImage(
        barbtnLocation.image=btnimg

//        barbtnLocation.image=btnimg
        
        getData()
    }
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    func getData(){
//        resultSearchController = ({
//            let controller = UISearchController(searchResultsController: nil)
//            controller.searchResultsUpdater = self
//            controller.dimsBackgroundDuringPresentation = false
//            controller.searchBar.sizeToFit()
//
//            tableView.tableHeaderView = controller.searchBar
//
//            return controller
//        })()
        let fetchReq:NSFetchRequest<CoreNote>=CoreNote.fetchRequest()
        let catfetchReq:NSFetchRequest<Category>=Category.fetchRequest()
//        if let catlist = try? PersistanceService.context.fetch(catfetchReq){
//
//            categorylist=catlist
//            print("catlist success count\(categorylist.count)")
////            print(catlist)
//
//        }
//        for i in categorylist{
//            print(i.cat_name!)}
//        categorylist[0].cat_name
//        categorylist.sort{
//            strcmp($0.cat_name,$1.cat_name) == -1
//        }
 //SORT       //categorylist=categorylist.sorted(by: { $0.cat_name! < $1.cat_name! })
//        for i in sortcat{
//            print(i.cat_name!)}
        if let corenotes = try? PersistanceService.context.fetch(fetchReq){
//            for i in 0...corenotes.count-1{
//                print("i:\(i) "+corenotes[i].subject!)}
            notelist=corenotes
            for i in notelist{
                print("notelist:\(i.subject!) \(i.category!)")
            }
            twoarr=[]
            if let catlist = try? PersistanceService.context.fetch(catfetchReq){
                
                categorylist=catlist
                print("catlist success count\(categorylist.count)")
                //            print(catlist)
                for i in categorylist{
                    print(i.cat_name!)}
                if catlist.count != 0 {
                for i in 0...categorylist.count-1{
                    print("cat \(i) \(categorylist[i].cat_name!)")
                    twoarr.append([])
                    for j in notelist{
                        if j.category! == categorylist[i].cat_name!{
                            twoarr[i].append(j)
                            //                        twoarr[i].append(j.subject!)
                        }
                    }
                }}
                
            }
            
//            print("2D array count\(twoarr.count)-\(twoarr[0].count)-\(twoarr[1].count)")
        }
//        for i in notelist{
//            print("\(i.subject) \(i.category)")
//        }
// SORT//         notelist=notelist.sorted(by: {$0.category! < $1.category!})
        for i in notelist{
            print("\(i.subject!) \(i.category!)")
        }
        //commentedthis//tableView.reloadData();
        if(categorylist.count==0){
            tableView.setEmptyView(title: "No notes added", message: "Press + to add a new note")
        }
        else{
            tableView.restore();
            tableView.reloadData();
        }
    }
    
//    func addData(){
//        print("addData called")
//        notelist.append(Note(subject: "Subject1", content: "Content1", dateTime: "date1", category: "category1"))
//        notelist.append(Note(subject: "Subject2", content: "Content2", dateTime: "date2", category: "category2"))
//        notelist.append(Note(subject: "Subject3", content: "Content3", dateTime: "date3", category: "category3"))
//        notelist.append(Note(subject: "Subject4", content: "Content4", dateTime: "date4", category: "category4"))
//        print("addDate \(notelist.count) rows added")
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if searchflag == true{
            return 1
        }
        else{
        print("categorylist.count=\(categorylist.count)")
        return twoarr.count
        }
        //        return categorylist.count
    }
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if sortflag==true{
            return sortArray[section][0].category
        }
        else{
        print("categorylist[\(section)].cat_name=\(categorylist[section].cat_name!)")
        return twoarr[section][0].category
//        return categorylist[section].cat_name
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //print(notelist.count)
        if searchflag==true{
            return searchArray.count
        }
        else if(sortflag==true){
            return sortArray[section].count
        }
        else{
            print("twoarr[\(section)].count=\(twoarr[section].count)")
            return twoarr[section].count
        }
//        var c=0;
//        for i in notelist{
//            if(i.category! == categorylist[section].cat_name!){
//                c+=1;
//            }
//        }
//        return c
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notecell", for: indexPath) as! NoteTableViewCell
//                cell.textLabel?.text=notelist[indexPath.row].subject;
//        cell.textLabel?.text=twoarr[indexPath.section][indexPath.row].subject;
        var obj:CoreNote
        if searchflag == true{
            obj=searchArray[indexPath.row]
        }
        else if(sortflag == true){
            obj=sortArray[indexPath.section][indexPath.row]
        }
        else{
            obj=twoarr[indexPath.section][indexPath.row]
        }
        cell.lblTitle.text=obj.subject;
        if let date=obj.dateTime{
            let dateFormatter=DateFormatter()
            dateFormatter.timeZone=TimeZone(abbreviation: "EST")
            dateFormatter.dateFormat = "yyyy-MM-dd, hh:mm:ss"
            let datestr = dateFormatter.string(from: date)
            print("inside cellDate:\(date)::\(datestr)")
            cell.lblDateTime.text=datestr;
        }else{
            cell.lblDateTime.text="Date"
        }
        // Configure the cell...

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var currNote:CoreNote
        if searchflag==true{
            currNote=searchArray[indexPath.row]
        }
        else if(sortflag==true){
            currNote=sortArray[indexPath.section][indexPath.row]
        }
        else{
            currNote=twoarr[indexPath.section][indexPath.row]
        }
        
            //notelist[indexPath.row]
        performSegue(withIdentifier: "hometocurrent", sender: currNote)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            print(indexPath.row)
            if indexPath.row==0 && twoarr[indexPath.section].count == 1{
                var secind=IndexSet()
                secind.insert(indexPath.section)
                for i in twoarr[indexPath.section]{
                    print("twoarr:\(i.subject)-\(i.category)")}
                print("inside del for row:\(indexPath.row) section:\(indexPath.section)")
                let delRow=twoarr[indexPath.section][indexPath.row]
                //                    notelist[indexPath.row]
                let delcat=categorylist[indexPath.section]
                twoarr.remove(at: indexPath.section)
                categorylist.remove(at: indexPath.section)
                PersistanceService.context.delete(delRow)
                PersistanceService.context.delete(delcat)
                try? PersistanceService.context.save()
                tableView.deleteSections(secind, with: .fade)
            }else{
//            let delRow=notelist[indexPath.row]
                let delRow=twoarr[indexPath.section][indexPath.row]
                print("deleted \(delRow.subject) at index\(indexPath.row) at \(indexPath.section)")
            twoarr[indexPath.section].remove(at: indexPath.row)
            notelist.remove(at: indexPath.row)
            PersistanceService.context.delete(delRow)
            try? PersistanceService.context.save()
            tableView.deleteRows(at: [indexPath], with: .fade)
            }
        } /*else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }   */
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view=UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
        let label=UILabel(frame: CGRect(x: 20, y: 0, width:view.frame.size.width, height:28))
        let button=UIButton(frame: CGRect(x:view.frame.size.width - 100, y:0, width:100, height:28))
        label.font = label.font.withSize(20)
        label.text=categorylist[section].cat_name
        view.backgroundColor=UIColor.purple
        label.textColor = .white
//        label.backgroundColor=UIColor.purple
        button.setTitle("Delete", for: .normal)
        button.titleLabel?.font=UIFont.boldSystemFont(ofSize: 14)
        button.tag=section
        button.addTarget(self, action: #selector(delsection), for: .touchUpInside)
        view.addSubview(label)
        view.addSubview(button)
        return view
//        label.addSubview(button)
//        return button
    }
    
    @objc func delsection(btn:UIButton){
        print("Del tapped at section \(btn.tag)")
        var indexset=IndexSet()
        indexset.insert(btn.tag)
//        var i=0;
//        for i in 0...twoarr[btn.tag].count-1{
//            let indexp=IndexPath(row: i, section: btn.tag)
//        }
        //let indexp=IndexPath(row: <#T##Int#>, section: <#T##Int#>)
        let warningalert=UIAlertController(title: "Warning", message: "This section contains entries\nAre you sure you want to delete? Select Move to move to another category", preferredStyle: .alert)
        warningalert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            let delrow=self.twoarr[btn.tag]
            let delcat=self.categorylist[btn.tag]
            for i in delrow{
                PersistanceService.context.delete(i)
            }
            PersistanceService.context.delete(delcat)
            self.twoarr.remove(at: btn.tag)
            self.tableView.deleteSections(indexset, with: .fade)
            PersistanceService.saveContext()
            self.tableView.reloadData()

        }))
        warningalert.addAction(UIAlertAction(title: "Move", style: .default, handler: { (action) in
            self.move(selsection: btn.tag)
        }))
        warningalert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(warningalert, animated: true)
//        twoarr.remove(at: btn.tag)
//        tableView.deleteSections(indexset, with: .fade)
//        tableView.reloadData()
    }
    func move(selsection:Int){
        print("Move called at section \(selsection)")
        currsection=selsection
        tempcat=[]
        for i in 0...categorylist.count-1{
            if i != currsection{
                tempcat.append(categorylist[i])
            }
        }
        /*let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
        pickerView.delegate = self
        pickerView.dataSource = self
        vc.view.addSubview(pickerView)
        let editRadiusAlert = UIAlertController(title: "Choose distance", message: "", preferredStyle: UIAlertControllerStyle.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        editRadiusAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(editRadiusAlert, animated: true)*/
        
        
        
        
        pickervc=UIViewController();
        pickervc.preferredContentSize = CGSize(width: 250,height: 500)
        let alertpicker=UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
        alertpicker.dataSource=self
        alertpicker.delegate=self
        pickervc.view.addSubview(alertpicker)
        txtCategory=UITextField(frame: CGRect(x: 0, y: 300, width: 250, height: 50))
        txtCategory.placeholder="Enter category name"
        txtCategory.isHidden=true
        pickervc.view.addSubview(txtCategory)
        let alertc=UIAlertController(title: "Move category", message: "Select the category to move to", preferredStyle: .alert)
        alertc.setValue(pickervc, forKey: "ContentViewController")
        alertc.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            print("Yes clicked")
            if self.txtCategory.isHidden==false{
                if let txtcatval=self.txtCategory.text{
                    let newcat = Category(entity: Category.entity(), insertInto: PersistanceService.context)
                    newcat.cat_name=txtcatval
                    self.categorylist.append(newcat)
                    PersistanceService.saveContext()
                    self.movesection(from: self.currsection, to: self.toindex, new: true)
                }
                else{
                    print("Please enter category name")
                }
            }
            else{
                print("categorylist before move:\(self.categorylist.count)")
               self.movesection(from: self.currsection, to: self.toindex, new: false)
            }
        }))
        alertc.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        if alertpicker.selectedRow(inComponent: 0) == self.tempcat.count{
//            txtCategory.isHidden=false
//        }
        self.present(alertc, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if(pickerView==sortPicker){
            return sortProps.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == catpicker){
            return categorylist.count
        }
        else if(pickerView == sortPicker){
            return sortProps[component].count
        }
        else{
            print("countCat\(tempcat.count)")
            return tempcat.count+1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == catpicker){
            return categorylist[row].cat_name
        }
        else if(pickerView == sortPicker){
            return sortProps[component][row]
        }
        else{
            if row == tempcat.count{
                return "Custom"
            }
            else{
    //            return "Hello"
                return (tempcat[row].cat_name)
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("selected row\(row)")
        if pickerView == catpicker{
//            print("selected: \(categorylist[row].cat_name)")
        }
        else if(pickerView == sortPicker){
            print("selected: \(sortProps[component][row])")
        }
        else{
            if(row != tempcat.count){
                //            var toindex:Int = -1
                for i in 0...categorylist.count-1{
                    if categorylist[i].cat_name==tempcat[row].cat_name{
                        toindex=i
                        break;
                    }
                }
                print("from section\(currsection) to section \(toindex)")
                //movesection(from: currsection, to: toindex)
            }
            else{
                self.txtCategory.isHidden=false
                //twoarr.append([])
                toindex=twoarr.count
                print("toindex:\(toindex)")
            }
        }
    }
    
    func movesection(from:Int, to:Int, new:Bool){
        var newto=to
        print("Movesection called from section \(from) to \(to)")
        print("catwgorylist count:\(categorylist.count)")
        
        print("********before********")
        var n=0
        print("twoarrcount=\(twoarr.count)")
        for i in twoarr{
            print("twoarr[\(n)]count=\(i.count)")
            n += 1
        }
        n=0
        for i in categorylist{
            print("catlist[\(n)]=\(i.cat_name)")
            n += 1
        }
        n=0
        for i in twoarr{
            var k=0
            for j in i{
                print("twoarr[\(n)][\(k)]=\(j.subject)--\(j.category)")
                k += 1
            }
            n += 1
        }
        
        var temparr:[CoreNote] = []
        for i in twoarr[from]{
            print("sub\(i.subject),cat\(i.category)")
            if new == true{
                i.category=txtCategory.text
            }
            else{
                i.category=categorylist[to].cat_name
            }
            temparr.append(i)
        }
//        twoarr.remove(at: currsection)
        n=0
        print("Deletiontwoarrcount=\(twoarr.count)")
        for i in twoarr{
            print("twoarr[\(n)]count=\(i.count)")
            n += 1
        }
//        categorylist.remove(at: currsection)
        if new == true{
            twoarr.append([])
            //newto = to-1
        }
        print("\(twoarr[newto])")
//        for i in temparr{
//            //print("temparr:\(i)")
//           twoarr[newto].append(i)
//        }
        let delrow=twoarr[currsection]
//        for i in delrow{
//            PersistanceService.context.delete(i)
//        }
//        twoarr.remove(at: currsection)
//        var k=0
        for i in temparr{
            let newnote=CoreNote(entity: CoreNote.entity(), insertInto: PersistanceService.context)
            newnote.subject=i.subject
            newnote.category=i.category
            newnote.dateTime=i.dateTime
            newnote.location=i.location
            newnote.image=i.image
            print("Newnote:\(newnote.subject)\(newnote.category)")
            twoarr[newto].append(newnote)
            PersistanceService.saveContext()
        }
        for i in delrow{
            PersistanceService.context.delete(i)
        }
        twoarr.remove(at: currsection)
        let delcat=categorylist[currsection]
        PersistanceService.context.delete(delcat)
        categorylist.remove(at: currsection)
        PersistanceService.saveContext()
        print("********final********")
        n=0
        for i in categorylist{
            print("catlist[\(n)]=\(i.cat_name)")
            n += 1
        }
        n=0
        for i in twoarr{
            var k=0
            for j in i{
                print("twoarr[\(n)][\(k)]=\(j.subject)--\(j.category)")
                k += 1
            }
            n += 1
        }
        tableView.reloadData()
//        for i in 0...twoarr.count-1{
//            if(twoarr[i][0].category==tempcat[row].cat_name){
//                for j in temparr{
//                    twoarr[i].append(j)
//                }
//            }
//        }
    }
    
    @IBAction func ActionTapped(_ sender: UIBarButtonItem) {
        if(barbtnAction.tag==1){
            barbtnAction.title="Actions"
            barbtnAction.tintColor=nil
            searchflag=false
            barbtnAction.tag=0
            tableView.reloadData()
        }
        else{
            let alert=UIAlertController(title: "Select option", message: nil, preferredStyle: .actionSheet)
            let search=UIAlertAction(title: "Search", style: .default) { (action) in
                print("Search")
                if(self.twoarr.count != 0){
                    self.search()}else{print("empty")}
                
            }
            let sort=UIAlertAction(title: "Sort", style: .default) { (action) in
                print("Sort")
                if(self.twoarr.count != 0){
                    self.sortTable()}else{print("empty")}
            }
            let cancel=UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(search)
            alert.addAction(sort)
            alert.addAction(cancel)
            self.present(alert,animated: true)
        }
    }
    
    func search(){
        let searchAlert=UIAlertController(title: "Search", message: "Select category", preferredStyle: .alert)
        let searchpickervc=UIViewController();
        searchpickervc.preferredContentSize = CGSize(width: 250,height: 500)
//                    let lblfilter=UILabel(frame: CGRect(x: 0, y: 100, width: 250, height: 50))
//                    lblfilter.text="Select category to choose"
        //let searchpicker=
        self.catpicker=UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
        var catnames=[String]()
        print("catnames.count\(catnames.count)")
        for i in self.categorylist{
            catnames.append(i.cat_name!)
        }
        print(catnames)
        let custdelegateCat=CustomPickerDelegate(strings: catnames)
        self.catpicker.delegate=self
        //custdelegateCat
        self.catpicker.dataSource=self
        //custdelegateCat
        searchpickervc.view.addSubview(self.catpicker)
//        let lblsearch=UILabel(frame: CGRect(x: 0, y: 300, width: 250, height: 50))
//        lblsearch.text="Enter text to search"
//        searchpickervc.view.addSubview(lblsearch)
        let txtsearch=UITextField(frame: CGRect(x: 0, y: 400, width: 250, height: 50))
        txtsearch.borderStyle = .roundedRect
        txtsearch.placeholder="Enter text to search"
        searchpickervc.view.addSubview(txtsearch)
        //            txtCategory=UITextField(frame: CGRect(x: 0, y: 300, width: 250, height: 50))
        //            txtCategory.placeholder="Enter category name"
        //            txtCategory.isHidden=true
        //            pickervc.view.addSubview(txtCategory)
        searchAlert.setValue(searchpickervc, forKey: "ContentViewController")
        let searchAction=UIAlertAction(title: "Done", style: .default) { (action) in
            let catindex=self.catpicker.selectedRow(inComponent: 0)
            if let searchtext=txtsearch.text{
                print("Actual search entered with catindex:\(catindex) with text:\(searchtext)")
//                self.barbtnAction.tag=1
                self.performSearch(index: catindex, text: searchtext)
            }
            else{
                print("Please Enter text")
            }
            
//            performSearch(catpicker.s)
        }
        searchAlert.addAction(searchAction)
        self.present(searchAlert, animated: true)
    }

    func performSearch(index:Int, text:String){
        barbtnAction.tag=1
        barbtnAction.title="Clear Search"
        barbtnAction.tintColor=UIColor.red
        searchArray=[]
        for i in twoarr[index]{
            let test1=i.subject?.lowercased().contains(text.lowercased())
            var test2=i.content?.lowercased().contains(text.lowercased())
            if test2 == nil{
                test2=false
            }
            else{
                test2=test2!
            }
            if (test1! || test2!){
                searchArray.append(i)
            }
        }
        searchflag=true
        tableView.reloadData()
    }
    
    func sortTable(){
        let sortAlert=UIAlertController(title: "Sort", message: "Select options", preferredStyle: .alert)
        let sortPickerVC=UIViewController();
        sortPickerVC.preferredContentSize = CGSize(width: 300,height: 300)
        sortPicker=UIPickerView(frame: CGRect(x: -15, y: 0, width: 300, height: 300))
        sortPicker.delegate=self
        sortPicker.dataSource=self
        sortPickerVC.view.addSubview(sortPicker)
        sortPickerVC.view.sizeToFit()
        sortAlert.setValue(sortPickerVC, forKey: "ContentViewController")
        let sortAction=UIAlertAction(title: "Sort", style: .default) { (action) in
            let option1=self.sortProps[0][self.sortPicker.selectedRow(inComponent: 0)]
            let option2=self.sortProps[1][self.sortPicker.selectedRow(inComponent: 1)]
            print("Sort action clicked for \(option1) and \(option2)")
            self.sortArray=[]
//            self.sortArray=self.twoarr

//            for i in self.twoarr{
//                print("twoarr-\(i.count)")
//            }
//            for i in self.sortArray{
//                print("sortArray-\(i.count)")
//            }
            if(option1 == self.sortProps[0][0]){
                if(option2 == self.sortProps[1][0]){
                    for i in self.twoarr{
//                        sortArray.append(i.sorted(by: { $0.subject > $1.subject }))
                        self.sortArray.append(i.sorted(by: {$0.dateTime!.compare($1.dateTime!) == .orderedAscending}))
                    }
//                    sortArray=i.sorted(by: {$0.dateTime.compare($1.dateTime) == .orderedDescending})
                }
                else{
                    for i in self.twoarr{
                        self.sortArray.append(i.sorted(by: {$0.dateTime!.compare($1.dateTime!) == .orderedDescending}))
                    }
                }
            }
            else{
                if(option2 == self.sortProps[1][0]){
                    for i in self.twoarr{
                        self.sortArray.append(i.sorted(by: { $0.subject!.compare($1.subject!) == .orderedAscending}))
                    }
                }
                else{
                    for i in self.twoarr{
                        self.sortArray.append(i.sorted(by: { $0.subject!.compare($1.subject!) == .orderedDescending}))
                    }
                }
            }
            self.sortflag=true
            self.tableView.reloadData()
        }
        sortAlert.addAction(sortAction)
        self.present(sortAlert,animated: true)
        
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newnoteVC=segue.destination as? NewNoteViewController{
            newnoteVC.homeVC=self
        }
        if let currentVC = segue.destination as? CurrentNoteViewController{
            currentVC.homeVC=self
            if let note=sender as? CoreNote{
                currentVC.selNote=note;
            }
        }
        if let mapVC = segue.destination as? MapViewController{
            mapVC.homeVC=self
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
