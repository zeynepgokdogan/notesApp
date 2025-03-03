//
//  AddNoteView.swift
//  notesApp
//
//  Created by Zeynep Gökdoğan on 18.02.2025.
//

import SwiftUI

struct AddNoteView: View {
    @Binding var NewItemPresented: Bool
    @StateObject var viewModel = AddNoteViewViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.dynamic(.white, .black).edgesIgnoringSafeArea(.all)
                
                
                VStack(spacing: 16) {
                    Text("Add a New Note")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    
                    Form {
                        Section(header: Text("Title").font(.caption).foregroundColor(.gray)) {
                            TextField("Enter note title...", text: $viewModel.noteTitle)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .background(Color.dynamic(.white, .black.opacity(0.2)))
                        }.listRowBackground(Color.clear)
                        
                        Section(header: Text("Content").font(.caption).foregroundColor(.gray)) {
                            TextEditor(text: $viewModel.noteContent)
                                .frame(minHeight: 100)
                                .cornerRadius(8)
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                                .background(Color.dynamic(.white, .black.opacity(0.2)))
                        }.listRowBackground(Color.clear)
                    }
                    .scrollContentBackground(.hidden)
                    .frame(height: 300)
                    
                    
                    Button(action: {
                        viewModel.save()
                        if !viewModel.noteTitle.isEmpty && !viewModel.noteContent.isEmpty {
                            NewItemPresented = false
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Text("Save Note")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 30)
                    }
                    
                    Spacer()
                }
                .padding()
                .alert(isPresented: $viewModel.showAlert, content: {
                    Alert(title: Text("Error"), message: Text("Please fill all fields"), dismissButton: .default(Text("OK")))
                })
            }
            .navigationBarTitle("New Note", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                NewItemPresented = false
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.gray)
            })
        }
    }
}

#Preview {
    AddNoteView(NewItemPresented: .constant(true))
}


