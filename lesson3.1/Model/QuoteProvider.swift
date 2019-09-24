//
//  QuoteProvider.swift
//  lesson3.1
//
//  Created by Zhassulan Aimukhambetov on 8/29/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

class QuoteProvider {
    
    var timer: Timer?
    
    func loadQuoteData() {
        guard let url = URL(string: "https://api.coinmarketcap.com/v1/ticker") else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            guard error == nil else {return}
            do {
                let quotes = try JSONDecoder().decode([Quote].self, from: data)
                DispatchQueue.main.async{
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "loadQuoteData"), object: quotes)
                }
            } catch let error {
                print(error)
            }
            }.resume()
    }
    
    func loadQuoteDataByTimer(interval: Int) {
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(interval), repeats: true, block: { (timer) in
            self.loadQuoteData()
        })
    }
}
