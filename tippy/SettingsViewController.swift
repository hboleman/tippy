//
//  SettingsViewController.swift
//  tippy
//
//  Created by Hunter Boleman on 2/18/19.
//  Copyright © 2019 Hunter Boleman. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //Access UserDefaults
    let defaults = UserDefaults.standard
    
    var default_tip: Double = 0;
    let tipPercentages = [0.15, 0.18, 0.20];
    @IBOutlet weak var default_tip_control: UISegmentedControl!
    
    
    
    @IBAction func radio_default(_ sender: Any) {
        default_tip = tipPercentages[default_tip_control.selectedSegmentIndex];
        
        // Set an Integer value for some key.
        defaults.set(default_tip_control.selectedSegmentIndex, forKey: "Default_Tip_Index")
        defaults.synchronize();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        default_tip_control.selectedSegmentIndex = (defaults.integer(forKey: "Default_Tip_Index"));
    }
}
