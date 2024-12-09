//
//  HomePage.swift
//  Ahavat Yeshua
//
//  Created by Raramuri on 06/12/24.
//
import Foundation
import XCTest


class HomePage: BaseScreen {
    
    private lazy var btnBibleReading = app.buttons["Bible Reading"]
    private lazy var btnProfile = app.buttons["Profile"]
    private lazy var btnDonation = app.buttons["Donation"]
    private lazy var btnLiveStream = app.buttons["Live Stream"]

    func homeScreenLoaded() -> Bool{
        return btnBibleReading.exists && btnProfile.exists && btnDonation.exists && btnLiveStream.exists
    }
}

