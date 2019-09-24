//
//  Quote.swift
//  lesson3.1
//
//  Created by Zhassulan Aimukhambetov on 8/29/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//
import Foundation

class Quote: Decodable {
    var id: String = ""
    var name: String = ""
    var symbol: String = ""
    var rank: String = ""
    var price_usd: String = ""
    var price_btc: String = ""
    var h24_volume_usd: String = ""
    var market_cap_usd: String = ""
    var available_supply: String = ""
    var total_supply: String = ""
    var max_supply: String? = ""
    var percent_change_1h: String = ""
    var percent_change_24h: String = ""
    var percent_change_7d: String = ""
    var last_updated: String = ""
 
    init (quoteCashed: QuoteCashed) {
        id = quoteCashed.id
        name = quoteCashed.name
        symbol = quoteCashed.symbol
        rank = quoteCashed.rank
        price_usd = quoteCashed.price_usd
        price_btc = quoteCashed.price_btc
        h24_volume_usd = quoteCashed.h24_volume_usd
        market_cap_usd = quoteCashed.market_cap_usd
        available_supply = quoteCashed.available_supply
        total_supply = quoteCashed.total_supply
        max_supply = quoteCashed.max_supply
        percent_change_1h = quoteCashed.percent_change_1h
        percent_change_24h = quoteCashed.percent_change_24h
        percent_change_7d = quoteCashed.percent_change_7d
        last_updated = quoteCashed.last_updated
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case rank
        case price_usd
        case price_btc
        case h24_volume_usd = "24h_volume_usd"
        case market_cap_usd
        case available_supply
        case total_supply
        case max_supply
        case percent_change_1h
        case percent_change_24h
        case percent_change_7d
        case last_updated
    }
    
}



// MARK: - Extensions

extension Double {
    func toDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm  dd.mm.yyyy"
        let date = formatter.string(from: Date(timeIntervalSince1970: self) as Date)
        return date
    }
}

extension Double {
    func formatingToString() -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = " "
        formater.numberStyle = .decimal
        if self < 0.01 {
            formater.maximumFractionDigits = 6
        } else if self < 1 {
            formater.maximumFractionDigits = 4
        } else {
            formater.maximumFractionDigits = 2
        }
        return formater.string(from: NSNumber(value: self))!
    }
}

extension String {
    func formatingToDouble() -> Double{
        if let cost = Double(self) {
            return cost
        } else {
            return 0
        }
    }
}


