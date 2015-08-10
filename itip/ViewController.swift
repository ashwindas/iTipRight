//
//  ViewController.swift
//  itip
//
//  Created by agururaj on 8/7/15.
//  Copyright (c) 2015 ashwindas. All rights reserved.
//

import UIKit

enum TipCategory : String {
    case NotHappy = "notHappyTipPercent", Good = "goodTipPercent", Excellent = "excellentTipPercent"
}

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        checkDefaultTipSettings()
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        billField.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        checkTipSettings()
        calculateTip()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        calculateTip()
    }

    @IBAction func onTap(sender: AnyObject) {
        // view.endEditing(true)
    }
    
    func calculateTip() {
        var tipPercentages = getTipSettings()
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = billField.text._bridgeToObjectiveC().doubleValue
        var tip = billAmount * Double(tipPercentage) / 100
        var total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    func getTipSettings() -> [Int] {
        var tipSettings = [Int]()
        let defaults = NSUserDefaults.standardUserDefaults()
        tipSettings.append(defaults.integerForKey(TipCategory.NotHappy.rawValue))
        tipSettings.append(defaults.integerForKey(TipCategory.Good.rawValue))
        tipSettings.append(defaults.integerForKey(TipCategory.Excellent.rawValue))
        return tipSettings
    }
    
    func checkTipSettings() {
        // Check settings for the tip values
        let defaults = NSUserDefaults.standardUserDefaults()
        let tipSelected = defaults.integerForKey("tipSelected")
        tipControl.selectedSegmentIndex = tipSelected
        
        let tipSettings = getTipSettings()
        tipControl.setTitle("\(tipSettings[0])%", forSegmentAtIndex: 0)
        tipControl.setTitle("\(tipSettings[1])%", forSegmentAtIndex: 1)
        tipControl.setTitle("\(tipSettings[2])%", forSegmentAtIndex: 2)
    }
    
    func checkDefaultTipSettings() {
        // Check settings for the tip values
        let defaults = NSUserDefaults.standardUserDefaults();
        let tipSettingExists = defaults.boolForKey("tipSettingExists")
        if(!tipSettingExists) {
            // Nothing saved. Set default values.
            defaults.setInteger(10, forKey: TipCategory.NotHappy.rawValue)
            defaults.setInteger(15, forKey: TipCategory.Good.rawValue)
            defaults.setInteger(20, forKey: TipCategory.Excellent.rawValue)
            defaults.setInteger(1, forKey: "tipSelected")
            defaults.setBool(true, forKey: "tipSettingExists")
        }
        defaults.synchronize()
    }
    
}

