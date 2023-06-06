//
//  ContentView.swift
//  ParroTalk
//
//  Created by apple on 2023/05/20.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowAddSheet = false
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var chapters: FetchedResults<Chapter>
    
    var body: some View {
        List {
            ForEach(chapters) { chapter in
                NavigationLink(destination: DetailView(chapter: chapter)) {
//                    Rectangle()
//                        .
                    Text(chapter.wrappedTitle)
                        .padding(10)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(action: {
                        DataController().deleteChapter(chapter: chapter, context: managedObjectContext)
                    }) {
                        Label("Delete", systemImage: "trash")
                    }
                    .tint(.red)
                }
            }
        }
        .navigationBarItems(
            trailing: Button(action: {
                isShowAddSheet.toggle()
            }) {
                Image(systemName: "plus")
            }
        )
        .sheet(isPresented: $isShowAddSheet) {
            AddListView()
        }
    }
}

extension ContentView {
    private func deleteChapter(offsets: IndexSet) {
        withAnimation {
            offsets.map { chapters[$0] }.forEach(managedObjectContext.delete)
        }
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}


struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
