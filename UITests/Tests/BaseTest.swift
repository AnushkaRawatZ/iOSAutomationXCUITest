import Foundation
import XCTest


open class BaseTest: XCTestCase {
    private var baseScreen = BaseScreen()

    lazy var app = baseScreen.app
    lazy var homePage = HomePage()
    lazy var profilePage = ProfilePage()
    lazy var myChurchPage = MyChurchPage()
    lazy var donationPage = DonationPage()
    lazy var bibleReadingPage = BibleReadingPage()

    open override func setUp() {
        app.activate()
        app.launchArguments = ["enable-testing"]
        continueAfterFailure = false
    }

    open override func tearDown() {
        app.terminate()
    }
    
    //tests
    
    func testHomeScreenLoaded() {
        XCTAssertTrue( homePage.homeScreenLoaded())
    }
    
    func testBibleReadingPageLoaded() {
        let bibleReadingButton = app.buttons["Bible Reading"]
        bibleReadingButton.tap()
        XCTAssertTrue(bibleReadingPage.bibleReadingPageLoaded())
    }
    
    func testShowVerse() {
        let bibleReadingButton = app.buttons["Bible Reading"]
        bibleReadingButton.tap()
        let text = "John 1:2"
        let textBox = app.textFields["textField"]
        textBox.tap()
        textBox.typeText(text)
        
        let showButton = app.buttons["Show Verse"]
        showButton.tap()
        
        let verseLabel = app.staticTexts["verse"]
        let expectedVerse = "The same was in the beginning with God."
        XCTAssertEqual(verseLabel.label.trimmingCharacters(in: .whitespacesAndNewlines), expectedVerse, "The displayed verse is incorrect.")
    }
    
    func testShowVerseNegative() {
        let bibleReadingButton = app.buttons["Bible Reading"]
        bibleReadingButton.tap()
        let text = "XYZ 99:99"
        let textBox = app.textFields["textField"]
        textBox.tap()
        textBox.typeText(text)
        let showButton = app.buttons["Show Verse"]
        showButton.tap()
        let alert = app.alerts.firstMatch
        let alertExists = alert.waitForExistence(timeout: 5)
        XCTAssertTrue(alertExists, "Pop up didn't appear")
        XCTAssertEqual(alert.firstMatch.label, "Error")
        let secondStaticText = alert.staticTexts.element(boundBy: 1)
        XCTAssertEqual(secondStaticText.label, "Invalid Format - (XYZ 99:99), Please use the format (John 3:16)", "The displayed text is incorrect.")

    }

    func testRandomVerse() {
        let bibleReadingButton = app.buttons["Bible Reading"]
        bibleReadingButton.tap()
        app.buttons["Random Verse"].tap()
        sleep(5)
        let verse = app.staticTexts["verse"]
        let verseLabel = app.staticTexts["verseLabel"]
        XCTAssertTrue(verse.exists && verseLabel.exists)
    }
    
    func testProfileScreenLoaded() {
        app.buttons["Profile"].tap()
        XCTAssertTrue( profilePage.profilePageLoaded())
    }
    
    func testMyProfilePageLoaded() {
        app.buttons["Profile"].tap()
        XCTAssertTrue(profilePage.profilePageLoaded(), "Profile page did not load")
    }
    
    func testEditInfo() {
        app.buttons["Profile"].tap()
        XCTAssertTrue(app.buttons["Personal"].waitForExistence(timeout: 5), "Personal button did not appear in time")
        app.buttons["Personal"].tap()
        let editButton = app.buttons["Edit"]
        XCTAssertTrue(app.buttons["Edit"].waitForExistence(timeout: 5), "Edit button did not appear in time")
        editButton.tap()
        app.textFields.element(boundBy: 0).doubleTap()
        app.textFields.element(boundBy: 0).typeText("John Doe")
        app.textFields.element(boundBy: 1).doubleTap()
        app.textFields.element(boundBy: 1).typeText("johndoe@gmail.com")
        app.textFields.element(boundBy: 2).doubleTap()
        app.textFields.element(boundBy: 2).typeText("New York")
        app.textFields.element(boundBy: 3).doubleTap()
        app.textFields.element(boundBy: 3).typeText("1234567890")
        app.buttons["Save"].tap()
        XCTAssertTrue(app.staticTexts["fullName"].label == "Full Name: John Doe")
        XCTAssertTrue(app.staticTexts["email"].label == "Email: johndoe@gmail.com")
        XCTAssertTrue(app.staticTexts["address"].label == "Address: New York")
        XCTAssertTrue(app.staticTexts["phone"].label == "Phone: 1234567890")
    }
    
    func testClearAll() {
        app.buttons["Profile"].tap()
        XCTAssertTrue(app.buttons["Personal"].waitForExistence(timeout: 5), "Personal button did not appear in time")
        app.buttons["Personal"].tap()
        XCTAssertTrue(app.buttons["Clear All"].waitForExistence(timeout: 5), "Clear All button did not appear in time")
        app.buttons["Clear All"].tap()
        XCTAssertTrue(app.staticTexts["fullName"].label == "Full Name: ")
        XCTAssertTrue(app.staticTexts["email"].label == "Email: ")
        XCTAssertTrue(app.staticTexts["address"].label == "Address: ")
        XCTAssertTrue(app.staticTexts["phone"].label == "Phone: ")

    }
    
    func testChurchPageLoaded(){
        app.buttons["Profile"].tap()
        XCTAssertTrue(app.buttons["Church"].waitForExistence(timeout: 5), "Church button did not appear in time")
        app.buttons["Church"].tap()
        XCTAssertTrue(myChurchPage.myChurchPageLoaded(), "My Church Page did not load")
    }
    
    func testDonationPageLoaded(){
        app.buttons["Donation"].tap()
        XCTAssertTrue(donationPage.donationPageLoaded(), "Donation Page did not load")
    }
    
    func testIncrementDonation(){
        app.buttons["Donation"].tap()
        donationPage.oneBtn.tap()
        XCTAssertEqual(donationPage.getTotalAmount(), "1")
        donationPage.fiveBtn.tap()
        XCTAssertEqual(donationPage.getTotalAmount(), "6")
    }
    
    func testIncrementAndDecrementQuantity(){
        app.buttons["Donation"].tap()
        donationPage.incrementBtn.tap()
        XCTAssertEqual(donationPage.getQuantity(), "1")
        donationPage.incrementBtn.tap()
        XCTAssertEqual(donationPage.getQuantity(), "2")
        donationPage.decrementBtn.tap()
        XCTAssertEqual(donationPage.getQuantity(), "1")
    }
    
    func testTotalCalculation(){
        app.buttons["Donation"].tap()
        donationPage.oneBtn.tap()
        donationPage.fiveBtn.tap()
        donationPage.incrementBtn.tap()
        donationPage.incrementBtn.tap()
        XCTAssertEqual("Total: $\(donationPage.calculateTotal()).00", donationPage.totalLabel.label, "Total calculation did not match")
    }
    
    func testDonationBtn(){
        testTotalCalculation()
        donationPage.donateBtn.tap()
        XCTAssertTrue(donationPage.verifyViewAfterDonating(), "Donation did not complete")
    }
    
    func testThankYouBtn(){
        app.buttons["Donation"].tap()
        donationPage.donateBtn.tap()
        app.buttons["Thank you!"].tap()
        XCTAssertTrue(donationPage.donationPageLoaded(), "Donation Page did not load")
    }
    
}
