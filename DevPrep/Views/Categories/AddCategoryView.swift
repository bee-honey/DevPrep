//
//  NewCategoryView.swift
//  DevPrep
//
//  Created by Naveen Keerthy on 7/16/24.
//

import SwiftUI

struct AddCategoryView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("New Category", text: $title)
                TextField("Description (optional)", text: $description)
                Button("Create") {
                    let newCategory = Category(title: title, description: description)
                    context.insert(newCategory)
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
                .disabled(title.isEmpty)
                .navigationTitle("New Category")
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
    AddCategoryView()
}
