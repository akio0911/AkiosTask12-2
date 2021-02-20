//
//  ViewController.swift
//  AkiosTask12-2
//
//  Created by Nekokichi on 2021/02/20.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var taxExluededPriceTextField: UITextField!
    @IBOutlet weak var taxPercentageTextField: UITextField!
    @IBOutlet weak var taxIncludedPriceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculateTaxIncludedPriceButton(_ sender: UIButton) {
        guard let taxExcludedPrice = Int(taxExluededPriceTextField.text!),
              let taxPercentage = Int(taxPercentageTextField.text!) else {
            return
        }
        let taxPrice = Int(Double(taxExcludedPrice) * (Double(taxPercentage) / 100))
        taxIncludedPriceLabel.text = "\(taxPrice + taxExcludedPrice)"
    }

}

