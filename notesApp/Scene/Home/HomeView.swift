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
                    ForEach(viewModel.filteredNotes(searchText).sorted { $0.isPinned == $1.isPinned ? false : $0.isPinned }) { note in
                        VStack(alignment: .leading) {
                            HStack {
                                if note.isPinned {
                                    Image(systemName: "pin.fill")
                                        .foregroundColor(.yellow)
                                }
                                Text(note.title)
                                    .font(.headline)
                            }
                            Text(note.content)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedNote = note
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                viewModel.pinNote(note: note)
                            } label: {
                                Label(note.isPinned ? "Unpin" : "Pin", systemImage: note.isPinned ? "pin.slash" : "pin")
                            }
                            .tint(.yellow)
                        }
                        
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                viewModel.deleteNote(note: note)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(Color(r: 247, g: 56, b: 56))
                            
                            Button {
                                viewModel.shareNote(note: note)
                                } label: {
                                    Label("Share", systemImage: "square.and.arrow.up")
                                }
                                .tint(Color(r: 49, g: 135, b: 234))
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
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(.yellow)
                        .font(.system(size: 20, weight: .bold, design: .default))
                }
            }
            .sheet(isPresented: $viewModel.showNotes) {
                AddNoteView(NewItemPresented: $viewModel.showNotes)
            }
            .fullScreenCover(item: $selectedNote) { note in
                EditNoteView(note: note, isPresented: $selectedNote, viewModel: viewModel)
            }

        }
    }
}

