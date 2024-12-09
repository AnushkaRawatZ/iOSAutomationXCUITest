//
//  DonationPage.swift
//  Ahavat Yeshua
//
//  Created by Raramuri on 09/12/24.
//

import Foundation
class DonationPage: BaseScreen {
    lazy var totalAmount = app.staticTexts["totalAmountLabel"]
    lazy var oneBtn = app.buttons["1DollarBtn"]
    lazy var fiveBtn = app.buttons["5DollarBtn"]
    lazy var quantityLabel = app.staticTexts["quantityLabel"]
    lazy var totalLabel = app.staticTexts["totalLabel"]
    lazy var donateBtn = app.buttons["donateBtn"]
    lazy var incrementBtn = app.buttons["Increment"]
    lazy var decrementBtn = app.buttons["Decrement"]
    
    func donationPageLoaded() -> Bool{
        if totalAmount.waitForExistence(timeout: 5){
            return totalAmount.exists && oneBtn.exists && fiveBtn.exists && quantityLabel.exists && totalLabel.exists && donateBtn.exists
        }
        return false
    }
    
    func getTotalAmount() -> String{
        if let numberPart = totalAmount.label.range(of: "\\d+", options: .regularExpression) {
            let extractedNumber = totalAmount.label[numberPart]
            return String(extractedNumber)
        }
        return ""
    }
    
    func getQuantity() -> String{
        let number = quantityLabel.label.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return number
    }
    
    func getTotal() -> String{
        return totalLabel.label
    }
    
    func calculateTotal() -> String{
        let quantity = getQuantity()
        let totalAmount = getTotalAmount()
        if quantity.isEmpty || totalAmount.isEmpty {
            return ""
        }
        return String(Int(quantity)! * Int(totalAmount)!)
    }
    
    func verifyViewAfterDonating() -> Bool{
        let congratulationsText = app.staticTexts["Congratulations!"]
        let thankYouBtn = app.buttons["Thank you!"]
        return congratulationsText.exists && thankYouBtn.exists
    }
    
    
}
