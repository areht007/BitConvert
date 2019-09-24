//
//  QuoteCashed.swift
//  lesson3.1
//
//  Created by Zhassulan Aimukhambetov on 9/22/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class QuoteCashed: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var symbol = ""
    @objc dynamic var rank = ""
    @objc dynamic var price_usd = ""
    @objc dynamic var price_btc = ""
    @objc dynamic var h24_volume_usd = ""
    @objc dynamic var market_cap_usd = ""
    @objc dynamic var available_supply = ""
    @objc dynamic var total_supply = ""
    @objc dynamic var max_supply = ""
    @objc dynamic var percent_change_1h = ""
    @objc dynamic var percent_change_24h = ""
    @objc dynamic var percent_change_7d = ""
    @objc dynamic var last_updated = ""
    
    override class func primaryKey() -> String? {
        return "name"
    }
    
    convenience init (quote: Quote) {
        self.init()
        id = quote.id
        name = quote.name
        symbol = quote.symbol
        rank = quote.rank
        price_usd = quote.price_usd
        price_btc = quote.price_btc
        h24_volume_usd = quote.h24_volume_usd
        market_cap_usd = quote.market_cap_usd
        available_supply = quote.available_supply
        total_supply = quote.total_supply
        max_supply = quote.max_supply ?? "0"
        percent_change_1h = quote.percent_change_1h
        percent_change_24h = quote.percent_change_24h
        percent_change_7d = quote.percent_change_7d
        last_updated = quote.last_updated
    }
}



