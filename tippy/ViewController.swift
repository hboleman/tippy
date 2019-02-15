//
//  ViewController.swift
//  tippy
//
//  Created by Hunter Boleman on 2/14/19.
//  Copyright © 2019 Hunter Boleman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Outlets
    @IBOutlet weak var tipLable: UILabel!
    @IBOutlet weak var totalLable: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true);
        print("Hello");
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        // Get Bill Amount
        let bill = Double(billField.text!) ?? 0;
        
        // Calc tip
        let tipPercentages = [0.15, 0.18, 0.20];
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex];
        let total = bill + tip;
        
        // Update tip
        tipLable.text = String(format: "$%.2f", tip);
        totalLable.text = String(format: "$%.2f", total);
    }
}

