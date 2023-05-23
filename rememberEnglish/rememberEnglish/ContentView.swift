//
//  ContentView.swift
//  rememberEnglish
//
//  Created by apple on 2023/05/20.
//

import SwiftUI

struct ContentView: View {
    @State var data: Chapters = Chapters()
    @State private var isShowAddSheet = false
    
    var body: some View {
        List {
            ForEach(data.chapters) { chapter in
                NavigationLink(destination: DetailSentenceView(chapter: chapter)) {
                    Text(chapter.section)
                        .padding(10)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(action: {
                        deleteChapter(chapter)
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
            AddListView(data: $data, isShowAddSheet: $isShowAddSheet)
        }
    }
    
    private func deleteChapter(_ chapter: Chapter) {
        if let index = data.chapters.firstIndex(of: chapter) {
            data.chapters.remove(at: index)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
        }
    }
}
