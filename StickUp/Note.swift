//
//  Note.swift
//  StickUp
//
//  Created by Emil Abraham Zachariah on 2019-07-13.
//  Copyright © 2019 Emil Abraham Zachariah. All rights reserved.
//

import Foundation
import CoreLocation
class Note{
    var subject:String
    var content:String
    var dateTime:String
    var category:String
//    var location:CLLocation?
    init() {
        self.subject=""
        self.content=""
        self.dateTime=""
        self.category=""
//        self.location=nil
    }
    init(subject:String, content:String, dateTime:String, category:String){
        self.subject=subject
        self.content=content
        self.dateTime=dateTime
        self.category=category
    }
    
}
