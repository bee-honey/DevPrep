//
//  Question.swift
//  DevPrep
//
//  Created by Naveen Keerthy on 7/15/24.
//

import Foundation
import SwiftData

@Model
class Question {
    var id: UUID
    var question: String
    var answerData: Data
    var codeForAnswerData: Data
    var referenceLink: String
    
    var answer: NSAttributedString {
        get {
            (try? NSAttributedString(data: answerData, options: [.documentType: NSAttributedString.DocumentType.rtfd], documentAttributes: nil)) ?? NSAttributedString(string: "")
        }
        set {
            answerData = (try? newValue.data(from: NSRange(location: 0, length: newValue.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.rtfd])) ?? Data()
        }
    }
    
    var codeForAnswer: NSAttributedString {
        get {
            (try? NSAttributedString(data: codeForAnswerData, options: [.documentType: NSAttributedString.DocumentType.rtfd], documentAttributes: nil)) ?? NSAttributedString(string: "")
        }
        set {
            codeForAnswerData = (try? newValue.data(from: NSRange(location: 0, length: newValue.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.rtfd])) ?? Data()
        }
    }
    
    init(id: UUID = UUID(), question: String, answer: NSAttributedString, codeForAnswer: NSAttributedString = NSAttributedString(string: ""), referenceLink: String = "") {
        self.id = id
        self.question = question
        self.answerData = (try? answer.data(from: NSRange(location: 0, length: answer.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.rtfd])) ?? Data()
        self.codeForAnswerData = (try? codeForAnswer.data(from: NSRange(location: 0, length: codeForAnswer.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.rtfd])) ?? Data()
        self.referenceLink = referenceLink
    }
}
