//
//  ProfilePage.swift
//  Ahavat Yeshua
//
//  Created by Raramuri on 06/12/24.
//

import Foundation
import XCTest


class ProfilePage: BaseScreen {
    
    private lazy var btnPersonal = app.buttons["Personal"]
    private lazy var btnChurch = app.buttons["Church"]

    func profilePageLoaded() -> Bool{
        if btnPersonal.waitForExistence(timeout: 5){
            return btnPersonal.exists && btnChurch.exists
        }
        return false
    }
}

class MyChurchPage: BaseScreen {
    private lazy var btnChurchAddress = app.buttons["churchAddress"]
    private lazy var btnChurchTimings = app.buttons["churchTimings"]
    private lazy var btnChurchVideo = app.buttons["video"]
    private lazy var btnChurchInfo = app.buttons["churchInfoBtn"]
    private lazy var btnPersonalGoals = app.buttons["personalGoalsBtn"]
    private lazy var btnFacebook = app.staticTexts["FaceBook"]
    private lazy var btnInstagram = app.staticTexts["Instagram"]
    private lazy var btnWhatsApp = app.staticTexts["WhatsApp"]
    private lazy var btnEmail = app.staticTexts["Email"]

    func myChurchPageLoaded() -> Bool{
        if btnChurchAddress.waitForExistence(timeout: 5){
            return btnChurchAddress.exists && btnChurchTimings.exists && btnChurchVideo.exists && btnChurchInfo.exists && btnPersonalGoals.exists && btnFacebook.exists && btnInstagram.exists && btnWhatsApp.exists && btnEmail.exists
        }
        return false
    }

}

class MyProfilePage: BaseScreen {
    lazy var fullNameText = app.staticTexts["fullName"]
    lazy var emailText = app.staticTexts["email"]
    lazy var dobText = app.staticTexts["dateOfBirth"]
    lazy var addressText = app.staticTexts["address"]
    lazy var phoneText = app.staticTexts["phone"]
    lazy var editBtn = app.buttons["Edit"]
    lazy var clearAllBtn = app.buttons["Clear All"]
    
    func myProfilePageLoaded() ->Bool{
        if fullNameText.waitForExistence(timeout: 5){
            return emailText.exists && dobText.exists && addressText.exists && phoneText.exists && editBtn.exists && clearAllBtn.exists
        }
        return false
    }
}
