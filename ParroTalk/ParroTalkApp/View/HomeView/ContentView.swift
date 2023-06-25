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
        VStack {
            if chapters.isEmpty {
                Text("+ 버튼을 눌러\n 오늘의 스터디를 추가해 주세요.")
                    .foregroundColor(.accentColor)
                PatternCellView(title: "Empty", content: "텅 빈.", complete: false)
                    .padding(.horizontal, 27)
            } else {
                List(chapters, id:\.self) { chapter in
                    ZStack {
                        NavigationLink(destination: DetailView(chapter: chapter)) {
                            EmptyView()
                        }
                        PatternCellView(title: chapter.wrappedTitle, content: "나는 ~ 할거야", complete: chapter.complete)
                    }
                    .listRowSeparator(.hidden)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(action: {
                            DataController().deleteChapter(chapter: chapter, context: managedObjectContext)
                        }) {
                            ZStack {
                                Text("Delete")
                            }
                        }
                        .tint(Color("DeleteColor"))

                    }
                }
                .listStyle(.plain)
            }
            Spacer()
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
        .padding(.top, 60)
    }
}


extension ContentView {
    private func deleteChapter(offsets: IndexSet) {
        withAnimation {
            offsets.map { chapters[$0] }.forEach(managedObjectContext.delete)
        }
    }
}


struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
                .environment(\.managedObjectContext, DataController().container.viewContext)
        }
        .accentColor(.accentColor)
    }
}
