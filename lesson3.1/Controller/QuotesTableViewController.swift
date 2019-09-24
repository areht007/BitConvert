//
//  QuotesTableViewController.swift
//  lesson3.1
//
//  Created by Zhassulan Aimukhambetov on 8/29/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import UIKit
import TableViewReloadAnimation
import RealmSwift

class QuotesTableViewController: UITableViewController {

    var quoteProvider = QuoteProvider()
    var lastQuotes: [Quote] = []
    var newQuotes: [Quote] = []
    let realmCash = RealmCash()
    
    var isConvertionMode = false
    var isConvertionButtonOne = false
    var isUpdateMode = false
    
    override func viewDidLoad() {

        let isTheFirstStart = !UserDefaults.standard.bool(forKey: "TheFirstStart")
        if isTheFirstStart {
            print("FirstStart")
            UserDefaults.standard.set(true, forKey: "TheFirstStart")
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getQuotes),
                                               name: Notification.Name("loadQuoteData"),
                                               object: nil)
        
        if let quotes = realmCash.readFromRealm() {
            newQuotes = quotes
        } else {
            quoteProvider.loadQuoteData()
        }
        //quoteProvider.loadQuoteData()
        quoteProvider.loadQuoteDataByTimer(interval: 60)
        tableView.reloadData(with: .simple(duration: 0.5, direction: .rotation3D(type: .deadpool), constantDelay: 0))
    }
    
    //MARK: - Notification
    
    @objc func getQuotes(notif: Notification) {
        if let object = notif.object {
            if let quotes = object as? [Quote] {
                realmCash.writeToRealm(quotes: quotes)
                lastQuotes = newQuotes
                newQuotes = quotes
                if isUpdateMode {
                    tableView.reloadData(with: .simple(duration: 0.25, direction: .top(useCellsFrame: true), constantDelay: 0))
                } else {
                    tableView.reloadData()
                }
                isUpdateMode = false
            }
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func updateQuotesButton(_ sender: UIBarButtonItem) {
        isUpdateMode = true
        quoteProvider.loadQuoteData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if newQuotes.count != 0 {
            return newQuotes.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quote = newQuotes[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath) as? QuoteCell {
            let updatePriceSettings = getUpdatePrice(index: indexPath.row)
            cell.quoteLabel.text = quote.name
            cell.numberLabel.text = String(indexPath.row + 1)
            cell.symbolLabel.text = quote.symbol
            cell.price_usdLabel.text = quote.price_usd.formatingToDouble().formatingToString() + "$"
            cell.logoImage.image = UIImage(named: String(indexPath.row))
            cell.updatePriceLabel.text = updatePriceSettings.0
            cell.updatePriceLabel.textColor = updatePriceSettings.1
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
            } else {
                cell.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "QuotesToDetail" {
            if let cell = sender as? QuoteCell {
                if let indexPath = tableView.indexPath(for: cell){
                    let quote = newQuotes[indexPath.row]
                    let detailVC = segue.destination as? DetailTableViewControllerTwo
                    detailVC?.quote = quote
                }
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return !isConvertionMode
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isConvertionMode {
            let quote = newQuotes[indexPath.row]
            if isConvertionButtonOne {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setQuoteToButtonOne"), object: quote)
                self.dismiss(animated: true)
            }else{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setQuoteToButtonTwo"), object: quote)
                self.dismiss(animated: true)
            }
        }
    }
    
    // MARK: - default functions

    func getUpdatePrice(index: Int) -> (String, UIColor) {
        if newQuotes.count > 0 && lastQuotes.count > 0{
            let updatePrice = newQuotes[index].price_usd.formatingToDouble() - lastQuotes[index].price_usd.formatingToDouble()
            if updatePrice > 0 {
                return ("↑", .green)
            } else if updatePrice < 0 {
                return ("↓", .red)
            } else {
                return ("-", .black)
            }
        } else {
            return ("-", .black)
        }
    }
}

