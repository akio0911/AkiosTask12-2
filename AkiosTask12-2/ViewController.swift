//
//  ViewController.swift
//  AkiosTask12-2
//
//  Created by Nekokichi on 2021/02/20.
//

import UIKit

protocol TaxRateRepositoryProtocol {
    func fetch() -> Int
    func save(taxRate: Int)
}

final class ViewController: UIViewController {
    @IBOutlet private weak var taxExluededPriceTextField: UITextField!
    @IBOutlet private weak var taxRateTextField: UITextField!
    @IBOutlet private weak var taxIncludedPriceLabel: UILabel!

    private let taxRateRepository: TaxRateRepositoryProtocol = TaxRateRepository()
    private let priceCalculator = PriceCalculator()

    override func viewDidLoad() {
        super.viewDidLoad()
        taxRateTextField.text = String(taxRateRepository.fetch())
    }

    private func displayTaxIncludedPrice() {
        guard let taxExcludedPrice = Float(taxExluededPriceTextField.text ?? ""),
              let taxRate = Float(taxRateTextField.text ?? "") else {
            return
        }
        taxIncludedPriceLabel.text = String(priceCalculator.getTaxIncludedPrice(taxExcludedPrice,  taxRate))
        taxRateRepository.save(taxRate: Int(taxRate))
    }

    @IBAction func calculateTaxIncludedPriceButton(_ sender: UIButton) {
        displayTaxIncludedPrice()
    }
}

struct TaxRateRepository: TaxRateRepositoryProtocol {
    private let userDefaultsKey = "taxPercentage"

    func fetch() -> Int {
        UserDefaults.standard.integer(forKey: userDefaultsKey)
    }

    func save(taxRate: Int) {
        UserDefaults.standard.setValue(taxRate, forKey: userDefaultsKey)
    }
}

struct PriceCalculator {
    func getTaxIncludedPrice(_ taxExcludedPrice: Float, _ taxRate: Float) -> Int {
        let taxIncludedPrice = Int(taxExcludedPrice * (1 + taxRate / 100))
        return taxIncludedPrice
    }
}
