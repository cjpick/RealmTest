//
//  ViewController.swift
//  RealmTest
//
//  Created by Christopher Pick on 2/15/17.
//  Copyright © 2017 Christopher Pick. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
  
  var data: Results<City>? {
    didSet {
      addNotification()
    }
  }
  
  var realm: Realm!
  
  @IBOutlet weak var tableView: UITableView!
  var notificationToken: NotificationToken? = nil

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Cities"
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addData))
    
    do {
      try realm = Realm()
      data = realm.objects(City.self).sorted(byKeyPath: "name")
    } catch let e {
      print(e)
      fatalError() // Crash - this must work for the demo
    }
    
    tableView.dataSource = self
  }
  
  func addData() {
    for fake in Fake.data() {
      do {
        try realm.write {
          let state: State
          if let existing = State.find(realm: realm, name: fake.state) {
            state = existing
          } else {
            state = State()
            state.name = fake.state
          }
          
          let zipCode: ZipCode
          if let existing = ZipCode.find(realm: realm, zipCode: fake.zipCode) {
            zipCode = existing
          } else {
            zipCode = ZipCode()
            zipCode.zip = fake.zipCode
          }
          if let city = City.find(realm: realm, name: fake.city) {
            city.zipCodes.append(zipCode)
          } else {
            let city = City()
            city.name = fake.city
            city.state = state
            city.zipCodes.append(zipCode)
            realm.add(city)
          }
        }
      } catch let e {
        print(e)
      }
    }
  }
  
  func addNotification() {
    notificationToken = data?.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
      switch changes {
      case .initial:
        // Results are now populated and can be accessed without blocking the UI
        let blank = [IndexPath]()
        self?.update(insert: blank, delete: blank, reload: blank, reloadAll: true)
        break
      case .update(_, let deletions, let insertions, let modifications):
        let insert = insertions.map { IndexPath(row: $0, section: 0) }
        let delete = deletions.map { IndexPath(row: $0, section: 0) }
        let reload = modifications.map { IndexPath(row: $0, section: 0) }
        self?.update(insert: insert, delete: delete, reload: reload, reloadAll: false)
        break
      case .error(let error):
        // An error occurred while opening the Realm file on the background worker thread
        fatalError("\(error)")
        break
      }
    }
  }
  
  func update(insert: [IndexPath], delete: [IndexPath], reload: [IndexPath], reloadAll: Bool) {
    if reloadAll {
      tableView.reloadData()
    } else {
      tableView.beginUpdates()
      tableView.insertRows(at: insert, with: .automatic)
      tableView.deleteRows(at: delete, with: .automatic)
      tableView.reloadRows(at: reload, with: .automatic)
      tableView.endUpdates()
    }
  }


}

extension ViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    if let city = data?[indexPath.row] {
    
      cell.textLabel?.text = "\(city.name), \(city.state?.name ?? "Unknown")"
      var zipCodes = ""
      for code in city.zipCodes {
        if zipCodes == "" {
          zipCodes = "\(code.zip)"
        } else {
          zipCodes = zipCodes + ", \(code.zip)"
        }
      }
      
      cell.detailTextLabel?.text = zipCodes
    }
    
    return cell
  }
  
}

