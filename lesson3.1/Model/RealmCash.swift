//
//  RealmCash.swift
//  lesson3.1
//
//  Created by Zhassulan Aimukhambetov on 9/22/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCash {

    func writeToRealm(quotes: [Quote]) {
        quotes
            .map{QuoteCashed(quote: $0)}
            .forEach{ quote in
                do {
                    let realm = try Realm()
                    try realm.write({
                        realm.add(quote, update: .modified)
                    })
                } catch let error as NSError {
                    print("Error writeToRealm: \(error.localizedDescription)")
                }
        }
    }
    
    func readFromRealm() -> [Quote]? {
        do {
            let realm = try Realm()
            return realm
                .objects(QuoteCashed.self)
                .map{Quote(quoteCashed: $0)} as [Quote]
            print(realm)
        } catch let error as NSError {
            print("Error readToRealm: \(error.localizedDescription)")
        }
        return nil
    }
}



