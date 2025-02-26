//
//  HomeView.swift
//  notesApp
//
//  Created by Zeynep Gökdoğan on 7.02.2025.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @StateObject var viewModel =  HomeViewViewModel()
    private let userId: String
    
    init(userId:String = "123"){
        self.userId = userId
    }
    var body: some View {
        NavigationView {
            VStack{
                
            }
            .navigationTitle("Home")
            .toolbar{
                Button{
                    viewModel.showNotes = true
                } label: {
                    Image(systemName: "plus")
                }
            }.sheet(isPresented: $viewModel.showNotes, content: {
                AddNoteView(NewItemPresented: $viewModel.showNotes)
            })
        }
    }
}

#Preview {
    HomeView(userId: "123")
}

