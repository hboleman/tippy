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
        nightmode();
    }

    // Access UserDefaults
    let defaults = UserDefaults.standard
    
    // Outlets
    @IBOutlet weak var seg_out_def: UISegmentedControl!
    @IBOutlet weak var switch_out: UISwitch!
    @IBOutlet weak var lbl_default_tip: UILabel!
    @IBOutlet weak var lbl_night_mode: UILabel!
    
    @IBAction func radio_default(_ sender: Any) {
        var default_tip: Double = 0;
        let tipPercentages = [0.15, 0.18, 0.20];
        // Saves default value
        default_tip = tipPercentages[seg_out_def.selectedSegmentIndex];
        // Set an Integer value for some key.
        defaults.set(seg_out_def.selectedSegmentIndex, forKey: "Default_Tip_Index")
        defaults.synchronize();
    }
    
    // Activates Night Mode
    @IBAction func switch_night_mode(_ sender: Any) {
        if(switch_out.isOn == true){
        defaults.set(true, forKey: "NightMode");
        }
        else {
            defaults.set(false, forKey: "NightMode");
        }
        defaults.synchronize();
        nightmode();
    }
    
    func nightmode(){
        // COLOR REFRRNCE
        //myRed = UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0);
        //myBlue = UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0);
        //myGreen = UIColor(red:0.56, green:0.81, blue:0.48, alpha:1.0);
        
        // Get state of night mode switch
        let night: Bool = defaults.bool(forKey: "NightMode");
        // Makes sure switch reflects mode
        switch_out.setOn(night, animated: false);
        var darkmodecolor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0);
        
        // Configure Night Colors
        let color_background_night = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0);
        let color_primary_night = UIColor(red: 204/255, green: 136/255, blue: 0/255, alpha: 1.0);
        let color_secondary_night = UIColor(red: 198/255, green: 0/255, blue: 201/255, alpha: 1.0);
        
        // Configure Day Colors
        let color_background_day = UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0);
        let color_primary_day = UIColor(red:0.56, green:0.81, blue:0.48, alpha:1.0);
        let color_secondary_day = UIColor(red:0.56, green:0.81, blue:0.48, alpha:1.0);
        
        // Configure Elements for Background Color
        if (night == true){
        darkmodecolor = color_background_night;
        }
        else {
        darkmodecolor = color_background_day;
        }
            // Place Elements Under Here
        self.view.backgroundColor = darkmodecolor;
        
        // Configure Elements for Primary Color
        if (night == true){
            darkmodecolor = color_primary_night;
        }
        else {
            darkmodecolor = color_primary_day;
        }
        // Place Elements Under Here
        lbl_default_tip.textColor = darkmodecolor;
        lbl_night_mode.textColor = darkmodecolor;
        seg_out_def.tintColor = darkmodecolor;
        
        // Configure Elements for Secondary Color
        if (night == true){
            darkmodecolor = color_secondary_night;
        }
        else {
            darkmodecolor = color_secondary_day;
        }
        // Place Elements Under Here
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("SVC:ViewWillApp");
        // Retrieve saved values
        seg_out_def.selectedSegmentIndex = (defaults.integer(forKey: "Default_Tip_Index"));
        nightmode();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("SVC:ViewDidApp");
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("SVC:ViewWillDis");

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("SVC:ViewDidDis");
    }
}
