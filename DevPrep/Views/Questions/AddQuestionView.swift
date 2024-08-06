//
//  AddQuestionView.swift
//  DevPrep
//
//  Created by Naveen Keerthy on 7/17/24.
//

import SwiftUI

struct AddQuestionView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State private var question = ""
    @State private var answer = NSAttributedString(string: "")
    @State private var codeForAnswer = NSAttributedString(string: "")
    @State private var referenceLink = ""
    
    var topic: Topic
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("New Question", text: $question)
                //                TextField("Answer", text: $answer)
                Section(header: Text("Answer")) {
                    ScrollView {
                        RichTextView(text: $answer)
                            .frame(height: 100) // Adjust the height as needed
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    }
                }
                Section(header: Text("Code for Answer")) {
                    ScrollView {
                        RichTextView(text: $codeForAnswer)
                            .frame(height: 100) // Adjust the height as needed
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    }
                }
                
                Section(header: Text("Reference Link")) {
                    TextField("Reference Link", text: $referenceLink)
                }
                Button("Create") {
                    let newQuestion = Question(question: question, answer: answer, codeForAnswer: codeForAnswer, referenceLink: referenceLink)
                    topic.questions.append(newQuestion)
                    context.insert(newQuestion)
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
                .disabled(question.isEmpty)
                .navigationTitle("New Question")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                        .foregroundColor(.white)
                    }
                })
            }
        }
    }
}

#Preview {
    AddQuestionView(topic: Topic(name: "Sample Topic"))
        .modelContainer(for: [Topic.self, Question.self], inMemory: true)
}
