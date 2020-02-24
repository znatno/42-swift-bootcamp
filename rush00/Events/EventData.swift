//
//  EventData.swift
//  42Events
//
//  Created by Denis ROMANICHENKO on 2/9/20.
//  Copyright © 2020 Denis ROMANICHENKO. All rights reserved.
//

import Foundation

class EventData : NSObject{
    var id:Int?
    var name:String
    var desc: String
    var location:String
    var kind:String
    var maxSubs:Int?
    var nbrSubs:Int?
    var beginAt:String
    var endAt:String
    var campusIds:[Int]
    var cursusIds:[Int]
    
    init(event:[String:Any]){
        self.id         = event["id"] as? Int ?? 0
        self.name       = event["name"] as? String ?? ""
        self.desc       = event["description"] as? String ?? ""
        self.location   = event["location"] as? String ?? ""
        self.kind       = event["kind"] as? String ?? ""
        self.maxSubs   = event["max_people"] as? Int ?? 0
        self.nbrSubs   = event["nbr_subscribers"] as? Int ?? 0
        self.beginAt   = event["begin_at"] as? String ?? ""
        self.endAt     = event["end_at"] as? String ?? ""
        self.campusIds = event["campus_ids"] as? [Int] ?? [0]
        self.cursusIds = event["cursus_ids"] as? [Int] ?? [0]
    }
//    override var description: (String) -> String {
//        return ("\(id)")
//    }
    
    override var description: String {
        return "\(String(describing: self.id)) of \(self.name)"
    }
}
