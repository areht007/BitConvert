//
//  DetailTableViewControllerTwo.swift
//  lesson3.1
//
//  Created by Zhassulan Aimukhambetov on 9/9/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import UIKit

class DetailTableViewControllerTwo: UITableViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var supplyLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    @IBOutlet weak var chandeIn1hLabel: UILabel!
    @IBOutlet weak var chandeIn24hLabel: UILabel!
    @IBOutlet weak var chandeIn7dLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    
    var quote: Quote!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        idLabel.text = quote.id
        quoteLabel.text = quote.name
        symbolLabel.text = quote.symbol
        rankLabel.text = quote.rank
        marketCapLabel.text = quote.market_cap_usd
        supplyLabel.text = quote.max_supply
        chandeIn1hLabel.text = quote.percent_change_1h
        chandeIn24hLabel.text = quote.percent_change_24h
        chandeIn7dLabel.text = quote.percent_change_7d
        lastUpdateLabel.text = quote.last_updated.formatingToDouble().toDate()
    }
}
