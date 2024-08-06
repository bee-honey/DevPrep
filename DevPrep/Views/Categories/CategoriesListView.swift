//
//  ContentView.swift
//  DevPrep
//
//  Created by Naveen Keerthy on 7/15/24.
//

import SwiftUI
import SwiftData

struct CategoriesListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Category.title) private var categories: [Category]
    @State private var createNewCategory: Bool = false
    @State private var showAlert = false
    @State private var categoryToDelete: Category?
    
    var body: some View {
        
        NavigationStack {
            ZStack {
//                Color(hex: "#313e53")
//                                            .edgesIgnoringSafeArea(.all)
                Group {
                    if categories.isEmpty {
                        ContentUnavailableView("Add your first category.", systemImage: "book.fill")
                    } else {
                        VStack {
                            List {
                                ForEach(categories) { category in
                                    NavigationLink {
                                        TopicsListView(category: category)
                                    } label: {
                                        VStack(alignment: .leading, content: {
                                            Text(category.title).font(.caption)
                                            Text(category.catDesc).foregroundStyle(.secondary)
                                        })
                                    }
                                }
                                .onDelete { indexSet in
                                    indexSet.forEach { index in
                                        categoryToDelete = categories[index]
                                        showAlert = true
                                        //                                    context.delete(category)
                                    }
                                }
                            }
                            .listStyle(.plain)

                        }
                    }
                }
                .padding()
                .navigationTitle("Categories")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        createNewCategory = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.white)
                    }
                }
    
                .sheet(isPresented: $createNewCategory, content: {
                    AddCategoryView()
                        .presentationDetents([.medium])
                })
                .alert("Confirm to delete", isPresented: $showAlert) {
                    Button("Delete", role: .destructive) {
                        if let category = categoryToDelete {
                            context.delete(category)
                            do {
                                try context.save()
                            } catch {
                                // Handle the error appropriately
                            }
                            categoryToDelete = nil // Reset the state
                        }
                    }
                    Button("Cancel", role: .cancel) {
                        categoryToDelete = nil // Reset the state
                    }
                } message: {
                    Text("Are you sure to delete this category? This cannot be reverted")
                }
            }
            
            
        }
    }
    //        .background(Color(red: 1/255, green: 1/255, blue: 1/255))
}


#Preview {
    CategoriesListView()
}

