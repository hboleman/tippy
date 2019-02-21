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
    @IBOutlet weak var fld_bill: UITextField!
    @IBOutlet weak var seg_out_tip: UISegmentedControl!
    @IBOutlet weak var lbl_total: UILabel!
    @IBOutlet weak var lbl_tip: UILabel!
    @IBOutlet weak var lbl_tip_out: UILabel!
    @IBOutlet weak var lbl_bill_out: UILabel!
    @IBOutlet weak var lbl_total_out: UILabel!
    @IBOutlet weak var lbl_line: UILabel!
    
    
    
    // Make UserDefautls Accessable
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Allow for code to run going into or out of background foreground
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil);
        notificationCenter.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil);
        nightmode();
        startKeyboard();
    }
    
    @objc func appMovedToBackground() {
        print("ENT_BKRND")
        flushPrep();
    }
    
    @objc func appCameToForeground() {
        print("ENT_FORRND")
        flushCheck();
        startKeyboard();
    }

    
    // Tap on View
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true);
    }
    
    // Calculates Tip
    @IBAction func calculateTip(_ sender: Any) {
        // Get Bill Amount
        let bill = Double(fld_bill.text!) ?? 0;
        // Calc tip
        let tipPercentages = [0.15, 0.18, 0.20];                                            // Stores segment values
        let tip = bill * tipPercentages[seg_out_tip.selectedSegmentIndex];
        let total = bill + tip;
        
        //Number Formatter
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
        currencyFormatter.alwaysShowsDecimalSeparator = true;
        // For Tip
        let tipStr = currencyFormatter.string(from: NSNumber.init(value: tip));
        // For Total
        let totalStr = currencyFormatter.string(from: NSNumber.init(value: total));
        
        // Update tip
        lbl_tip.text = tipStr;
        lbl_total.text = totalStr;
        
        // lbl_total animation
        UIView.animate(withDuration:0.4, delay: 0.0,
                       options:.transitionCrossDissolve,
                       animations: { () -> Void in
                        self.lbl_total.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: nil)
        UIView.animate(withDuration:0.5, delay: 0.2,
                       options:.transitionCrossDissolve,
                       animations: { () -> Void in
                        self.lbl_total.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    // Will flush values if maxamum allowable time has passed in the background
    func flushCheck(){
        let maxAllowableTime: Int = 600; // Value in Seconds
        
        // If it has been 10mins since last open, clear values
        if ((defaults.object(forKey: "lastTime")) != nil){                                  // If there is saved value, protection against nil
            print("Flush:Check");
            let savedTime = defaults.object(forKey: "lastTime") as! Date;                   // Get saved time
            let cmp_time = savedTime.addingTimeInterval(TimeInterval(maxAllowableTime));    // Make time for comparison savedTime + timeUntilReset
            let currentTime = Date();                                                       // Get current time for comparison
            if (currentTime.compare(cmp_time) == ComparisonResult.orderedDescending){
                print("Flush:true");
                fld_bill.text = "";
                lbl_total.text = "$0.00";
                lbl_tip.text = "$0.00";
            }
            else {
                print("Flush:false");
            }
        }
    }
    
    // Saves current time for comparison in flushCheck
    func flushPrep(){
        // Save Date of Last Time Opened
        let currentTime = Date();
        defaults.setValue(currentTime, forKey: "lastTime")
        defaults.synchronize();
    }
    
    func nightmode(){
        // COLOR REFRRNCE
        //myRed = UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0);
        //myBlue = UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0);
        //myGreen = UIColor(red:0.56, green:0.81, blue:0.48, alpha:1.0);
        
        // Get state of night mode switch
        let night: Bool = defaults.bool(forKey: "NightMode");
        var darkmodecolor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0);
        
        // Configure Night Colors
        let color_background_night = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0);
        let color_primary_night = UIColor(red: 204/255, green: 136/255, blue: 0/255, alpha: 1.0);
        let color_secondary_night = UIColor(red: 0/255, green: 104/255, blue: 112/255, alpha: 1.0)
        
        // Configure Day Colors
        let color_background_day = UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0);
        let color_primary_day = UIColor(red:0.56, green:0.81, blue:0.48, alpha:1.0);
        let color_secondary_day = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0);
        
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
        seg_out_tip.tintColor = darkmodecolor;
        lbl_bill_out.textColor = darkmodecolor;
        lbl_tip_out.textColor = darkmodecolor;
        lbl_tip.textColor = darkmodecolor;
        lbl_total_out.textColor = darkmodecolor;
        lbl_total.textColor = darkmodecolor;
        
        
        // Configure Elements for Secondary Color
        if (night == true){
            darkmodecolor = color_secondary_night;
        }
        else {
            darkmodecolor = color_secondary_day;
        }
        // Place Elements Under Here
        
        // Special Configure
        if (night == true){
            // Night
            fld_bill.backgroundColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1.0);
            lbl_line.backgroundColor = UIColor(red: 117/255, green: 64/255, blue: 11/255, alpha: 1.0)
        }
        else {
            // Day
            fld_bill.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0);
            lbl_line.backgroundColor = UIColor(red: 34/255, green: 118/255, blue: 149/255, alpha: 1.0);
        }
    }
    
    func startKeyboard(){
        fld_bill.becomeFirstResponder();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("VC:ViewWillApp");
        // Set Segement to saved default
        seg_out_tip.selectedSegmentIndex = (defaults.integer(forKey: "Default_Tip_Index"));
        flushCheck();
        nightmode();
        startKeyboard();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("VC:ViewDidApp");
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("VC:ViewWillDis");
        flushPrep();
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("VC:ViewDidDis");
    }
}

