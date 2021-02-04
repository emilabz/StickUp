//
//  CustomPickerDelegate.swift
//  StickUp
//
//  Created by Emil Abraham Zachariah on 2019-07-23.
//  Copyright © 2019 Emil Abraham Zachariah. All rights reserved.
//

import Foundation
import UIKit
class CustomPickerDelegate: NSObject,UIPickerViewDataSource, UIPickerViewDelegate{
    let strings: [String]
    
    init(strings: [String]) {
        self.strings = strings
        super.init()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print("strings.count\(strings.count)")
        return strings.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("strings[\(row)]=\(strings[row])")
        return strings[row]
    }
    
    /*
    var dataArr:[String]
    init(arr : [String]) {
        dataArr=["One","Two","Three","Four"]
        print("custom arr\(dataArr)")
        print("count\(dataArr.count)")
        super.init()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("inside custom\(row)-\(dataArr[row])-component\(component)")
        return dataArr[row]
    }
 */
    
//    func isEqual(_ object: Any?) -> Bool {
//        <#code#>
//    }
//
//    var hash: Int
//
//    var superclass: AnyClass?
//
//    func `self`() -> Self {
//        <#code#>
//    }
//
//    func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! {
//        <#code#>
//    }
//
//    func perform(_ aSelector: Selector!, with object: Any!) -> Unmanaged<AnyObject>! {
//        <#code#>
//    }
//
//    func perform(_ aSelector: Selector!, with object1: Any!, with object2: Any!) -> Unmanaged<AnyObject>! {
//        <#code#>
//    }
//
//    func isProxy() -> Bool {
//        <#code#>
//    }
//
//    func isKind(of aClass: AnyClass) -> Bool {
//        <#code#>
//    }
//
//    func isMember(of aClass: AnyClass) -> Bool {
//        <#code#>
//    }
//
//    func conforms(to aProtocol: Protocol) -> Bool {
//        <#code#>
//    }
//
//    func responds(to aSelector: Selector!) -> Bool {
//        <#code#>
//    }
//
//    var description: String
    
    
}
