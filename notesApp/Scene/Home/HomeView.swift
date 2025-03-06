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

    private var displayedNotes: [NoteModel] {
        viewModel.filteredNotes(searchText).sorted { $0.isPinned && !$1.isPinned }
    }

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(displayedNotes) { note in
                        VStack(alignment: .leading) {
                            HStack {
                                if note.isPinned {
                                    Image(systemName: "pin.fill")
                                        .foregroundColor(.yellow)
                                }
                                Text(note.title)
                                    .font(.headline)
                            }
                            Text(viewModel.trimmedContent(note.content))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedNote = note
                        }
                        .swipeActions {
                            Button {
                                viewModel.pinNote(note: note)
                            } label: {
                                Label(note.isPinned ? "Unpin" : "Pin", systemImage: note.isPinned ? "pin.slash" : "pin")
                            }
                            .tint(.yellow)
                            
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

