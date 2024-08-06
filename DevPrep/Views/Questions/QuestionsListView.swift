//
//  QuestionView.swift
//  DevPrep
//
//  Created by Naveen Keerthy on 7/16/24.
//

import SwiftUI
import SwiftData

struct QuestionsListView: View {
    
    var topic: Topic
    
    @Environment(\.modelContext) private var context
    @Query private var questions: [Question]
    @State private var createNewQuestion: Bool = false
    @State private var showAlert = false
    @State private var questionToDelete: Question?
    
    var body: some View {
        NavigationStack {
            Group {
                if filteredQuestions.isEmpty {
                    ContentUnavailableView("Add your questsions for this topic", systemImage: "book.fill")
                } else {
                    VStack {
                        List {
                            ForEach(filteredQuestions) { question in
                                NavigationLink {
                                    QuestionAndAnswerView(question: question)
                                } label: {
                                    VStack(alignment: .leading, content: {
                                        Text(question.question)
                                            .font(.caption)
                                    })
                                }
                            }
                            .onDelete(perform: { indexSet in
                                indexSet.forEach { index in
                                    questionToDelete = questions[index]
                                    showAlert = true
                                }
                            })
                        }
                        .listStyle(.plain)
                    }
                }
            }
            .padding()
            .navigationTitle("Questions")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    createNewQuestion = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                        .foregroundColor(.white)
                }
            }
            .sheet(isPresented: $createNewQuestion, content: {
                AddQuestionView(topic: topic)
                    .presentationDetents([.large])
            })
            .alert("Confirm to delete", isPresented: $showAlert) {
                Button("Delete", role: .destructive) {
                    if let question = questionToDelete {
                        context.delete(question)
                        do {
                            try context.save()
                        } catch {
                            // Handle the error appropriately
                        }
                        questionToDelete = nil // Reset the state
                    }
                }
                Button("Cancel", role: .cancel) {
                    questionToDelete = nil // Reset the state
                }
            } message: {
                Text("Are you sure to delete this question? This cannot be reverted")
            }
        }
    }
    
    private var filteredQuestions: [Question] {
        return questions.filter { question in
            topic.questions.contains(question)
        }
    }
}

#Preview {
    QuestionsListView(topic: Topic(name: "Sample Topic"))
        .modelContainer(for: [Category.self, Topic.self, Question.self], inMemory: true)
}
