//
//  QuestionAndAnswerView.swift
//  DevPrep
//
//  Created by Naveen Keerthy on 7/17/24.
//

import SwiftUI
import SwiftData

struct QuestionAndAnswerView: View {
    
    var question: Question
    @Environment(\.modelContext) private var context
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question.question)
                .font(.title2)
                .padding([.leading, .trailing, .top])
            
            RichTextView(text: question.answer)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
            
            if (question.codeForAnswer.string.count != 0) {
                RichTextView(text: question.codeForAnswer)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
            }
            
            if !question.referenceLink.isEmpty {
                Link("Reference", destination: URL(string: question.referenceLink)!)
                    .padding([.leading, .trailing, .bottom])
            }
        }
        .navigationTitle("Question and Answer")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let sampleQuestion = Question(
        question: "What is SwiftUI?",
        answer: NSAttributedString(string: "SwiftUI is a modern UI framework for building user interfaces across all Apple platforms.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]),
        codeForAnswer: NSAttributedString(string: "let x = 10", attributes: [NSAttributedString.Key.font: UIFont(name: "Courier", size: 16)!]),
        referenceLink: "https://developer.apple.com/documentation/swiftui/"
    )
    return QuestionAndAnswerView(question: sampleQuestion)
        .modelContainer(for: [Category.self, Topic.self, Question.self], inMemory: true)
}
