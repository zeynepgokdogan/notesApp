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
                VStack(spacing: 5) {
                    
                    VStack {
                        TextField("Enter note title...", text: $title)
                            .font(.system(size: 22, weight: .bold, design: .default))
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                        
                        TextEditor(text: $content)
                            .frame(minHeight: 300)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                        
                    }
                    .padding()
                }
            }
            .navigationBarItems(leading: Button(action: {
                if !title.isEmpty && !content.isEmpty {
                    let updatedNote = NoteModel(id: note.id, title: title, content: content, createdAt: Date().timeIntervalSince1970, isPinned: note.isPinned)
                    viewModel.updateNote(note: updatedNote)
                    isPresented = nil
                }
                isPresented = nil
            }) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.yellow)
                    .font(.system(size: 20, weight: .bold, design: .default))
                
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

