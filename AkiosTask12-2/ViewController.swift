//
//  ViewController.swift
//  AkiosTask12-2
//
//  Created by Nekokichi on 2021/02/20.
//

import UIKit

protocol TaxRateProtocol {
    var taxRateUDKey: String { get }
    func getTaxRate() -> Float
    func saveToUserDefault(taxRate: Float)
}

final class ViewController: UIViewController {
    @IBOutlet private weak var taxExluededPriceTextField: UITextField!
    @IBOutlet private weak var taxPercentageTextField: UITextField!
    @IBOutlet private weak var taxIncludedPriceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        taxPercentageTextField.text = "\(TaxRateController.shared.getTaxRate())"
    }

    private func display() {
        guard let taxExcludedPrice = Float(taxExluededPriceTextField.text ?? ""),
              let taxPercentage = Float(taxPercentageTextField.text ?? "") else {
            return
        }
        let taxIncludedPrice = Int(taxExcludedPrice * (1 + taxPercentage / 100))
        taxIncludedPriceLabel.text = "\(taxIncludedPrice)"
        TaxRateController.shared.saveToUserDefault(taxRate: taxPercentage)
    }

    @IBAction func calculateTaxIncludedPriceButton(_ sender: UIButton) {
        display()
    }
}

class TaxRateController: TaxRateProtocol {
    static var shared = TaxRateController()
    var taxRateUDKey: String = "taxPercentage"

    func getTaxRate() -> Float {
        UserDefaults.standard.float(forKey: taxRateUDKey)
    }

    func saveToUserDefault(taxRate: Float) {
        UserDefaults.standard.setValue(taxRate, forKey: taxRateUDKey)
    }
}

