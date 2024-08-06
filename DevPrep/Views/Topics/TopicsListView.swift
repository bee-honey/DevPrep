//
//  TopicsView.swift
//  DevPrep
//
//  Created by Naveen Keerthy on 7/16/24.
//

import SwiftUI
import SwiftData

struct TopicsListView: View {
    var category: Category
    @Environment(\.modelContext) private var context
    @Query(sort: \Topic.title) private var topics: [Topic]
    @State private var createNewTopic: Bool = false
    @State private var showAlert = false
    @State private var topicToDelete: Topic?
    
    
    var body: some View {
        NavigationStack {
            Group {
                if filteredTopics.isEmpty {
                    ContentUnavailableView("Add your first topic for the category", systemImage: "book.fill")
                } else {
                    VStack {
                        List {
                            ForEach(filteredTopics) { topic in
                                NavigationLink {
                                    QuestionsListView(topic: topic)
                                } label: {
                                    VStack(alignment: .leading, content: {
                                        Text(topic.title)
                                            .font(.caption)
                                    })
                                }
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        topicToDelete = topic
                                        showAlert = true
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                                .swipeActions(edge: .leading) {
                                    Button {
//                                        modalType = .updateHabit(habit)
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                    }
                                }
                            }
                            
                        
//                            .onDelete(perform: { indexSet in
//                                indexSet.forEach { index in
//                                    topicToDelete = topics[index]
//                                    showAlert = true
//                                }
//                            })
                        }
                        .listStyle(.plain)
                    }
                }
            }
            .padding()
            .navigationTitle("Topics")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    createNewTopic = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                        .foregroundColor(.white)
                }
            }
            .sheet(isPresented: $createNewTopic, content: {
                AddTopicView(category: category)
                    .presentationDetents([.medium])
            })
            .alert("Confirm to delete", isPresented: $showAlert) {
                Button("Delete", role: .destructive) {
                    if let topic = topicToDelete {
                        context.delete(topic)
                        do {
                            try context.save()
                        } catch {
                            // Handle the error appropriately
                        }
                        topicToDelete = nil // Reset the state
                    }
                }
                Button("Cancel", role: .cancel) {
                    topicToDelete = nil // Reset the state
                }
            } message: {
                Text("Are you sure to delete this topic? This cannot be reverted")
            }
        }
        
        
    }
    
    private var filteredTopics: [Topic] {
        return topics.filter { category.topics.contains($0) }
    }
    
//    #Preview {
//        TopicsListView(category: Category(title: "Sample category"))
//    }
//    
//    
//
//    #Preview {
//        // Initialize Sample Data
//            let sampleCategory = Category(title: "Sample Category")
//            let sampleTopic1 = Topic(name: "Sample Topic 1")
//            let sampleTopic2 = Topic(name: "Sample Topic 2")
//            sampleCategory.topics.append(contentsOf: [sampleTopic1, sampleTopic2])
//            
//            // Return the View with Sample Data
//            return TopicsListView(category: sampleCategory)
//    }
}
