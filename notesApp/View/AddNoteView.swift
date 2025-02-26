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
    
    
    var body: some View {
        ZStack{
            Color(.systemGray6).edgesIgnoringSafeArea(.all)
            VStack(spacing: 10.0)
            {
                Text("ADD NOTE")
                    .font(.callout).bold()
                Form{
                    TextField("Note Title", text: $viewModel.noteTitle)
                    TextField("Note Content", text: $viewModel.noteContent)
           
                }.alert(isPresented: $viewModel.showAlert, content: {
                    Alert(title: Text("Error"), message: Text("Please fill all fields"), dismissButton: .default(Text("OK")))
                })
                Button(action: {
                    viewModel.save()
                    NewItemPresented = false
                }) {
                    Text("SAVE")
                }.foregroundStyle(.white)
                    .frame(width: 100, height: 30)
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing)
                    ).cornerRadius(20)
            }
        }
    }
}

#Preview {
    AddNoteView(NewItemPresented: Binding(get: { true }, set: { _ in }))
}
