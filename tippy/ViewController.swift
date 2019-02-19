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
    
    // Make UserDefautls Accessable
    let defaults = UserDefaults.standard
    
    
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
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        tipControl.selectedSegmentIndex = (defaults.integer(forKey: "Default_Tip_Index"));
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did disappear")
    }
 
}

