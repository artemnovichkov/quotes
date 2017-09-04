//
//  QuotesViewController.swift
//  Quotes
//
//  Created by Artem Novichkov on 28/12/2016.
//  Copyright © 2016 ArtemNovichkov. All rights reserved.
//

import Cocoa

class QuotesViewController: NSViewController {

    let quotes = Quote.all
    
    @IBOutlet weak var textLabel: NSTextField!
    
    var currentQuoteIndex: Int = 0 {
        didSet {
            updateQuote()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewWillAppear() {
        currentQuoteIndex = 0
    }
    
    func updateQuote() {
        textLabel.stringValue = quotes[currentQuoteIndex].text
    }
    
    //MARK: - Action
    
    @IBAction func generateAction(_ sender: Any) {
        currentQuoteIndex = (currentQuoteIndex + 1) % quotes.count
    }
    
    @IBAction func quit(_ sender: Any) {
        NSApplication.shared.terminate(nil)
    }
}
