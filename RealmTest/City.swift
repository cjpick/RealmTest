//
//  City.swift
//  RealmTest
//
//  Created by Christopher Pick on 2/15/17.
//  Copyright © 2017 Christopher Pick. All rights reserved.
//

import Foundation
import RealmSwift

class City: Object {
  dynamic var name: String = ""
  dynamic var state: State? = nil
  let zipCodes = List<ZipCode>()
  
}

extension City {
  
  static func find(realm:Realm, name:String)->City? {
    let predicate = NSPredicate(format: "name == %@", name)
    return realm.objects(City.self).filter(predicate).first
  }
  
}
