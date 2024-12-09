//
//  BibleReadingPage.swift
//  Ahavat Yeshua
//
//  Created by Raramuri on 06/12/24.
//
import Foundation
import XCTest


class BibleReadingPage: BaseScreen{
    lazy var textBox = app.textFields.element
    lazy var showVerseBtn = app.buttons["Show Verse"]
    lazy var randomVerseBtn = app.buttons["Random Verse"]
    
    func bibleReadingPageLoaded() ->Bool{
        return textBox.exists && showVerseBtn.exists && randomVerseBtn.exists
    }
}
