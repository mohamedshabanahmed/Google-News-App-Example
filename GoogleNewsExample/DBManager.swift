//
//  DBManager.swift
//  GoogleNewsExample
//
//  Created by MAC on 5/23/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager : Object {
    
    private var database:Realm
    static let sharedInstance = DBManager()
    
    private init() {
        database = try! Realm()
    }
    
    func getDataFromDB() -> Results<NewModel> {
        let results: Results<NewModel> = database.objects(Item.self)
        return results
    }
    
    func addData(object: NewModel) {
        try! database.write {
            database.add(object, update: true)
            print("Added new object")
        }
    }
    
    func deleteAllDatabase()  {
        try! database.write {
            database.deleteAll()
        }
    }
    
    func deleteFromDb(object: NewModel) {
        try! database.write {
            database.delete(object)
        }
    }
    
}
