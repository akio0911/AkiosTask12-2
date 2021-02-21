//
//  ViewController.swift
//  AkiosTask12-2
//
//  Created by Nekokichi on 2021/02/20.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var taxExluededPriceTextField: UITextField!
    @IBOutlet private weak var taxPercentageTextField: UITextField!
    @IBOutlet private weak var taxIncludedPriceLabel: UILabel!
    private let taxPercentageUDKey: String = "taxPercentage"

    override func viewDidLoad() {
        super.viewDidLoad()
        if let taxPercentage = UserDefaults.standard.object(forKey: taxPercentageUDKey) as? Int {
            taxPercentageTextField.text = "\(taxPercentage)"
        }
    }

    @IBAction func calculateTaxIncludedPriceButton(_ sender: UIButton) {
        guard let taxExcludedPrice = Float(taxExluededPriceTextField.text!),
              let taxPercentage = Float(taxPercentageTextField.text!) else {
            return
        }
        let taxIncludedPrice = Int(taxExcludedPrice * (1 + taxPercentage / 100))
        taxIncludedPriceLabel.text = "\(taxIncludedPrice)"
        UserDefaults.standard.setValue(taxPercentage, forKey: taxPercentageUDKey)
    }

}

