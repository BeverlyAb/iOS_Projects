//
//  ViewController.swift
//  tippyCanDo
//
//  Created by Beverly Abadines on 1/8/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        //dismisses keyboard when background is selected
        view.endEditing(true)
    }
    
    @IBAction func calc(_ sender: Any) {
        //updates tip and total values when tip or bill changes
        let tipPercent = [0.15, 0.2, 0.25]
        
        //defaults to 0 if invalid
        let bill = Double(billField.text!) ?? 0
        
        let tip = bill * tipPercent[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
    }
}

