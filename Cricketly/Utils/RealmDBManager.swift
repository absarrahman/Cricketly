//
//  RealmDBManager.swift
//  Cricketly
//
//  Created by BJIT  on 18/2/23.
//

import Foundation
import RealmSwift


class PlayerRealmModel : Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var fullname: String?
    @objc dynamic var imagePath: String?
    @objc dynamic var countryName: String?
}


class RealmDBManager {
    static let shared = RealmDBManager()
    var realmDB: Realm!
    
    private init() {
        do {
            realmDB = try Realm()
        } catch {
            print(error)
        }
    }
    
    func addData<T:Object>(list:[T], onError: (Error)->()) {
        do {
            try realmDB.write {
                realmDB.add(list)
            }
        } catch {
            print(error)
            onError(error)
        }
    }
    
    
    func read<T:Object>(type: T.Type) -> [T] {
        let results  = realmDB.objects(type)
        var res: [T] = []
        
        for result in results {
            print(result)
            res.append(result)
        }
        
        return res
    }
}
