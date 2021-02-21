//
//  ViewController.swift
//  AkiosTask12-2
//
//  Created by Nekokichi on 2021/02/20.
//

import UIKit

protocol TaxRateProtocol {
    var userDefaultsKey: String { get }
    func getTaxRate() -> Int
    func saveToUserDefault(taxRate: Int)
}

final class ViewController: UIViewController {
    @IBOutlet private weak var taxExluededPriceTextField: UITextField!
    @IBOutlet private weak var taxRateTextField: UITextField!
    @IBOutlet private weak var taxIncludedPriceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        taxRateTextField.text = "\(TaxRateController.shared.getTaxRate())"
    }

    private func calculate() {
        guard let taxExcludedPrice = Float(taxExluededPriceTextField.text ?? ""),
              let taxPercentage = Float(taxRateTextField.text ?? "") else {
            return
        }
        let taxIncludedPrice = Int(taxExcludedPrice * (1 + taxPercentage / 100))
        taxIncludedPriceLabel.text = "\(taxIncludedPrice)"
        TaxRateController.shared.saveToUserDefault(taxRate: Int(taxPercentage))
    }

    @IBAction func calculateTaxIncludedPriceButton(_ sender: UIButton) {
        calculate()
    }
}

class TaxRateController: TaxRateProtocol {
    static var shared = TaxRateController()
    var userDefaultsKey: String = "taxPercentage"

    func getTaxRate() -> Int {
        UserDefaults.standard.integer(forKey: userDefaultsKey)
    }

    func saveToUserDefault(taxRate: Int) {
        UserDefaults.standard.setValue(taxRate, forKey: userDefaultsKey)
    }
}

