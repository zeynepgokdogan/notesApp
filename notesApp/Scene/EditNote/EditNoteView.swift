//
//  EditNoteView.swift
//  notesApp
//
//  Created by Zeynep Gökdoğan on 18.02.2025.
//

import SwiftUI

struct EditNoteView: View {
    @State var note: NoteModel
    @Binding var isPresented: NoteModel?
    @ObservedObject var viewModel: HomeViewViewModel

    @State private var title: String
    @State private var content: String

    init(note: NoteModel, isPresented: Binding<NoteModel?>, viewModel: HomeViewViewModel) {
        self._note = State(initialValue: note)
        self._isPresented = isPresented
        self._title = State(initialValue: note.title)
        self._content = State(initialValue: note.content)
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all)
                VStack(spacing: 10) {
                    
                    Form {
                        Section() {
                            TextField("Enter note title...", text: $title)
                                .background(Color.dynamic(.white, .black.opacity(0.2)))
                                .padding(.bottom, 5)
                                .overlay(Rectangle().frame(height: 1).foregroundColor(.gray), alignment: .bottom)
                        }.listRowBackground(Color.clear)
                        
                        Section() {
                            TextEditor(text: $content)
                                .frame(minHeight: 500)
                        }.listRowBackground(Color.clear)
                    }
                    .scrollContentBackground(.hidden)
                    .frame(height: 600)
                    
                    Button(action: {
                        if !title.isEmpty && !content.isEmpty {
                            let updatedNote = NoteModel(id: note.id, title: title, content: content, createdAt: Date().timeIntervalSince1970, isPinned: note.isPinned)
                            viewModel.updateNote(note: updatedNote)
                            isPresented = nil
                        }
                    }) {
                        Text("Save Changes")
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
            }
            .navigationBarTitle("Edit Note", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                isPresented = nil
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.gray)
            })
        }
    }
}

#Preview {
    EditNoteView(
        note: NoteModel(id: "sample-id", title: "Sample Note", content: "Sample Content", createdAt: Date().timeIntervalSince1970, isPinned: false),
        isPresented: .constant(nil),
        viewModel: HomeViewViewModel(userId: "223")
    )
}

