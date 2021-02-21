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
    func getTaxIncludedPrice(_ taxExcludedPrice: Float, _ taxRate: Float) -> Int
    func saveTaxRate(taxRate: Int)
}

final class ViewController: UIViewController {
    @IBOutlet private weak var taxExluededPriceTextField: UITextField!
    @IBOutlet private weak var taxRateTextField: UITextField!
    @IBOutlet private weak var taxIncludedPriceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        taxRateTextField.text = String(TaxRateController.shared.getTaxRate())
    }

    private func displayTaxIncludedPrice() {
        guard let taxExcludedPrice = Float(taxExluededPriceTextField.text ?? ""),
              let taxRate = Float(taxRateTextField.text ?? "") else {
            return
        }
        taxIncludedPriceLabel.text = String(TaxRateController.shared.getTaxIncludedPrice(taxExcludedPrice,  taxRate))
        TaxRateController.shared.saveTaxRate(taxRate: Int(taxRate))
    }

    @IBAction func calculateTaxIncludedPriceButton(_ sender: UIButton) {
        displayTaxIncludedPrice()
    }
}

class TaxRateController: TaxRateProtocol {
    static var shared = TaxRateController()
    var userDefaultsKey: String = "taxPercentage"

    func getTaxRate() -> Int {
        UserDefaults.standard.integer(forKey: userDefaultsKey)
    }

    func getTaxIncludedPrice(_ taxExcludedPrice: Float, _ taxRate: Float) -> Int {
        let taxIncludedPrice = Int(taxExcludedPrice * (1 + taxRate / 100))
        return taxIncludedPrice
    }

    func saveTaxRate(taxRate: Int) {
        UserDefaults.standard.setValue(taxRate, forKey: userDefaultsKey)
    }
}

