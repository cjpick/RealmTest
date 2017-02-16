//
//  ZipCode.swift
//  RealmTest
//
//  Created by Christopher Pick on 2/15/17.
//  Copyright © 2017 Christopher Pick. All rights reserved.
//

import Foundation
import RealmSwift

class ZipCode: Object {
  
  dynamic var zip: Int = 0
  
}

extension ZipCode {

  static func find(realm:Realm, zipCode:Int)->ZipCode? {
    let predicate = NSPredicate(format: "zip == \(zipCode)")
    return realm.objects(ZipCode.self).filter(predicate).first
  }
}
