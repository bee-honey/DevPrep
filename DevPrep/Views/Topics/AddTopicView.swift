//
//  AddTopicView.swift
//  DevPrep
//
//  Created by Naveen Keerthy on 7/16/24.
//

import SwiftUI

struct AddTopicView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var description = ""
    
    var category: Category
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("New Topic", text: $title)
                TextField("Description (optional)", text: $description)
                Button("Create") {
                    let newTopic = Topic(name: title, topDesc: description)
                    category.topics.append(newTopic)
                    context.insert(newTopic)
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
                .disabled(title.isEmpty)
                .navigationTitle("New Topic")
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
    AddTopicView(category: Category(title: "Sample Category"))
        .modelContainer(for: [Category.self], inMemory: true)
}
