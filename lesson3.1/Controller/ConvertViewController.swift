//  ConvertViewController.swift
//  lesson3.1
//  Created by Zhassulan Aimukhambetov on 9/13/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.

import UIKit

class ConvertViewController: UIViewController {
    
    var quoteOne: Quote?
    var quoteTwo: Quote?
    var quoteCount: Double = 0.0
    
    //MARK: - IBOutlets:
    
    @IBOutlet weak var quote1Button: UIButton!
    @IBOutlet weak var quote2Button: UIButton!
    @IBOutlet weak var quoteTwoLabel: UILabel!
    @IBOutlet weak var quoteOneLabel: UILabel!
    
    @IBAction func quote2Button(_ sender: UIButton) {
    }
    @IBAction func quote1Button(_ sender: UIButton) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if quoteOne != nil {
            quote1Button.setTitle(quoteOne?.name, for: .normal)
        }
        if quoteTwo != nil {
            quote2Button.setTitle(quoteTwo?.name, for: .normal)
        }
        countQuote()
    }
    
    override func viewDidLoad() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getQuoteOne),
                                               name: Notification.Name("setQuoteToButtonOne"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getQuoteTwo),
                                               name: Notification.Name("setQuoteToButtonTwo"),
                                               object: nil)
        if quoteOne != nil {
            quote1Button.setTitle(quoteOne?.symbol, for: .normal)
        }
        if quoteTwo != nil {
            quote2Button.setTitle(quoteTwo?.symbol, for: .normal)
        }
        
        quote1Button.layer.cornerRadius = 5
        quote1Button.layer.borderWidth = 2
        quote1Button.layer.borderColor = UIColor.gray.cgColor
        
        quote2Button.layer.cornerRadius = 5
        quote2Button.layer.borderWidth = 2
        quote2Button.layer.borderColor = UIColor.gray.cgColor
        
    }
    
    //MARK: - Notofocation
    
    @objc func getQuoteOne(notif: Notification) {
        if let object = notif.object {
            if let quote = object as? Quote {
                quoteOne = quote
            }
        }
    }
    
    @objc func getQuoteTwo(notif: Notification) {
        if let object = notif.object {
            if let quote = object as? Quote {
                quoteTwo = quote
            }
        }
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuoteFromOne" {
           let detailVC = segue.destination as? QuotesTableViewController
            detailVC?.isConvertionMode = true
            detailVC?.isConvertionButtonOne = true
        }
        if segue.identifier == "toQuoteFromTwo" {
            let detailVC = segue.destination as? QuotesTableViewController
            detailVC?.isConvertionMode = true
        }
    }

    // MARK: - calculator func

    func countQuote() {
        if quoteOne != nil && quoteTwo != nil {
            quoteCount = (quoteOneLabel.text?.formatingToDouble())!
            let quoteFirstPrice = quoteOne!.price_usd.formatingToDouble()
            let quoteSecondPrice = quoteTwo!.price_usd.formatingToDouble()
            let count = quoteCount * quoteFirstPrice / quoteSecondPrice
            quoteTwoLabel.text = count.formatingToString()
          }
    }
    
    func writeQuoteLabel(_ num: String) {
        quoteCount = (quoteOneLabel.text?.formatingToDouble())!
        if quoteCount == 0 {
            quoteOneLabel.text = num
        } else {
            quoteOneLabel.text = quoteOneLabel.text! + num
        }
        
    }

    @IBAction func clearAllButton(_ sender: Any) {
        quoteCount = 0
        quoteOne = nil
        quoteTwo = nil
        quote1Button.setTitle("Select...", for: .normal)
        quote2Button.setTitle("Select...", for: .normal)
        quoteOneLabel.text = "0"
        quoteTwoLabel.text = "0"

    }
    
    @IBAction func backButton(_ sender: Any) {
        let strQuoteCount = quoteOneLabel.text
        if strQuoteCount?.count == 1 {
            quoteOneLabel.text = "0"
            quoteTwoLabel.text = "0"
        } else {
            quoteOneLabel.text = String(strQuoteCount!.dropLast())
            countQuote()
        }
    }
    
    @IBAction func numberZeroButton(_ sender: UIButton) {
        writeQuoteLabel("0")
        countQuote()
    }
    
    @IBAction func numberOneButton(_ sender: UIButton) {
        writeQuoteLabel("1")
        countQuote()
    }
    
    @IBAction func numberTwoButton(_ sender: UIButton) {
        writeQuoteLabel("2")
        countQuote()
    }
    
    @IBAction func numberThreeButton(_ sender: UIButton) {
        writeQuoteLabel("3")
        countQuote()
    }
    
    @IBAction func numberFourButton(_ sender: UIButton) {
        writeQuoteLabel("4")
        countQuote()
    }
    
    @IBAction func numberFiveButton(_ sender: UIButton) {
        writeQuoteLabel("5")
        countQuote()
    }
    
    @IBAction func numberSixButton(_ sender: UIButton) {
        writeQuoteLabel("6")
        countQuote()
    }
    
    @IBAction func numberSevenButton(_ sender: UIButton) {
        writeQuoteLabel("7")
        countQuote()
    }
    
    @IBAction func numberEigthButton(_ sender: UIButton) {
        writeQuoteLabel("8")
        countQuote()
    }
    
    @IBAction func numberNineButton(_ sender: UIButton) {
        writeQuoteLabel("9")
        countQuote()
    }
}
