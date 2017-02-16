//
//  FakeData.swift
//  RealmTest
//
//  Created by Christopher Pick on 2/15/17.
//  Copyright © 2017 Christopher Pick. All rights reserved.
//

import Foundation

struct Data {
  let city:String
  let state:String
  let zipCode:Int
}

struct Fake {
  static func data()->[Data] {
    var holder = [Data]()
    holder.append(Data(city: "Holtsville", state: "NY", zipCode: 00501))
    holder.append(Data(city: "Holtsville", state: "NY", zipCode: 00544))
    holder.append(Data(city: "Adjuntas", state: "PR", zipCode: 00601))
    holder.append(Data(city: "Aguada", state: "PR", zipCode: 00602))
    holder.append(Data(city: "Aguadilla", state: "PR", zipCode: 00603))
    holder.append(Data(city: "Aguadilla", state: "PR", zipCode: 00604))
    holder.append(Data(city: "Aguadilla", state: "PR", zipCode: 00605))
    holder.append(Data(city: "Maricao", state: "PR", zipCode: 00606))
    holder.append(Data(city: "Anasco", state: "PR", zipCode: 00610))
    holder.append(Data(city: "Angeles", state: "PR", zipCode: 00611))
    holder.append(Data(city: "Arecibo", state: "PR", zipCode: 00612))
    holder.append(Data(city: "Arecibo", state: "PR", zipCode: 00613))
    holder.append(Data(city: "Arecibo", state: "PR", zipCode: 00614))
    holder.append(Data(city: "Bajadero", state: "PR", zipCode: 00616))
    holder.append(Data(city: "Barceloneta", state: "PR", zipCode: 00617))
    
    return holder
  }
}
