//
//  HomeView.swift
//  notesApp
//
//  Created by Zeynep Gökdoğan on 7.02.2025.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestoreCombineSwift

struct HomeView: View {
    @StateObject var viewModel: HomeViewViewModel
    
    init(userId: String = "123") {
        _viewModel = StateObject(wrappedValue: HomeViewViewModel(userId: userId))
    }

    var body: some View {
        NavigationView {
            ZStack {
                List(viewModel.notes) { note in
                    VStack(alignment: .leading) {
                        Text(note.title)
                            .font(.headline)
                        Text(note.content)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Home")
            .toolbar {
                Button {
                    viewModel.showNotes = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showNotes, content: {
                AddNoteView(NewItemPresented: $viewModel.showNotes)
            })
        }
    }
}

#Preview {
    HomeView(userId: "123")
}


