import SwiftUI
import FirebaseAuth
import FirebaseFirestoreCombineSwift

struct HomeView: View {
    @StateObject var viewModel: HomeViewViewModel
    @State private var selectedNote: NoteModel?
    @State private var searchText = ""
    
    init(userId: String = "123") {
        _viewModel = StateObject(wrappedValue: HomeViewViewModel(userId: userId))
    }

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(viewModel.filteredNotes(searchText)) { note in
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.headline)
                            Text(note.content)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .onTapGesture {
                            selectedNote = note
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                viewModel.deleteNote(note: note)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .padding()
            }
            .navigationTitle("My Notes")
            .searchable(text: $searchText)
            .toolbar {
                Button {
                    viewModel.showNotes = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showNotes) {
                AddNoteView(NewItemPresented: $viewModel.showNotes)
            }
            .sheet(item: $selectedNote) { note in
                EditNoteView(note: note, isPresented: $selectedNote, viewModel: viewModel)
            }
        }
    }
}

