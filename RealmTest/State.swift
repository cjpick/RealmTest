//
//  State.swift
//  RealmTest
//
//  Created by Christopher Pick on 2/15/17.
//  Copyright © 2017 Christopher Pick. All rights reserved.
//

import Foundation
import RealmSwift

class State: Object {
  
  dynamic var name: String = ""
  
}

extension State {
  
  static func find(realm:Realm, name:String)->State? {
    let predicate = NSPredicate(format: "name == %@", name)
    return realm.objects(State.self).filter(predicate).first
  }
  
}
