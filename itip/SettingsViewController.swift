//
//  SettingsViewController.swift
//  iTipRight
//
//  Created by agururaj on 8/9/15.
//  Copyright (c) 2015 ashwindas. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipSettingsSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var notHappyTipSettingsTextField: UITextField!
    
    @IBOutlet weak var goodTipSettingsTextField: UITextField!
    
    @IBOutlet weak var excellentTipSettingsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        checkTipSettings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTipSettings() -> [Int] {
        var tipSettings = [Int]()
        let defaults = NSUserDefaults.standardUserDefaults()
        tipSettings.append(defaults.integerForKey("notHappyTipPercent"))
        tipSettings.append(defaults.integerForKey("goodTipPercent"))
        tipSettings.append(defaults.integerForKey("excellentTipPercent"))
        return tipSettings
    }
    
    func checkTipSettings() {
        // Check settings for the tip values
        let defaults = NSUserDefaults.standardUserDefaults();
        
        let tipSettings = getTipSettings()
        
        let notHappyTipPercent = tipSettings[0]
        tipSettingsSegmentedControl.setTitle("\(notHappyTipPercent)%", forSegmentAtIndex: 0)
        notHappyTipSettingsTextField.text = "\(notHappyTipPercent)"
        
        let goodTipPercent = tipSettings[1]
        tipSettingsSegmentedControl.setTitle("\(goodTipPercent)%", forSegmentAtIndex: 1)
        goodTipSettingsTextField.text = "\(goodTipPercent)"

        let excellentTipPercent = tipSettings[2]
        tipSettingsSegmentedControl.setTitle("\(excellentTipPercent)%", forSegmentAtIndex: 2)
        excellentTipSettingsTextField.text = "\(excellentTipPercent)"
        
        let tipSelected = defaults.integerForKey("tipSelected")
        tipSettingsSegmentedControl.selectedSegmentIndex = tipSelected
    }
    
    @IBAction func tipselectionChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults();
        let tipSelected = tipSettingsSegmentedControl.selectedSegmentIndex
        defaults.setInteger(tipSelected, forKey: "tipSelected")
        defaults.synchronize()
    }
    
    @IBAction func settingsChanged(sender: UITextField) {
        
        let notHappyTipPercent = notHappyTipSettingsTextField.text
        tipSettingsSegmentedControl.setTitle("\(notHappyTipPercent)%", forSegmentAtIndex: 0)
        
        let goodTipPercent = goodTipSettingsTextField.text
        tipSettingsSegmentedControl.setTitle("\(goodTipPercent)%", forSegmentAtIndex: 1)
        
        let excellentTipPercent = excellentTipSettingsTextField.text
        tipSettingsSegmentedControl.setTitle("\(excellentTipPercent)%", forSegmentAtIndex: 2)
        
        let defaults = NSUserDefaults.standardUserDefaults();
        
        if let notHappyTipPercentInt = notHappyTipSettingsTextField.text.toInt() {
            defaults.setInteger(notHappyTipPercentInt, forKey: "notHappyTipPercent")
        }
        if let goodTipPercentInt = goodTipSettingsTextField.text.toInt() {
            defaults.setInteger(goodTipPercentInt, forKey: "goodTipPercent")
        }
        if let excellentTipPercentInt = excellentTipSettingsTextField.text.toInt() {
            defaults.setInteger(excellentTipPercentInt, forKey: "excellentTipPercent")
        }
        
        defaults.synchronize()
    }

    @IBAction func onTap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
