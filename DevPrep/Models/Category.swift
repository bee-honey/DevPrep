//
//  Category.swift
//  DevPrep
//
//  Created by Naveen Keerthy on 7/15/24.
//

import Foundation
import SwiftData

@Model
class Category {
    var id: UUID
    var title: String
    var catDesc: String
    var topics: [Topic]
    
    init(id: UUID = UUID(), title: String, description: String = "", topics: [Topic] = []) {
        self.id = id
        self.title = title
        self.catDesc = description
        self.topics = topics
    }
}
