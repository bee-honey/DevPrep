//
//  Topic.swift
//  DevPrep
//
//  Created by Naveen Keerthy on 7/15/24.
//

import Foundation
import SwiftData

@Model
class Topic {
    var id: UUID
    var title: String
    var topDesc: String
    var questions: [Question]
    
    init(id: UUID = UUID(), name: String, topDesc: String = "", questions: [Question] = []) {
        self.id = id
        self.title = name
        self.topDesc = topDesc
        self.questions = questions
    }
}
