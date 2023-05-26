//
//  AddListView.swift
//  rememberEnglish
//
//  Created by apple on 2023/05/23.
//

import SwiftUI

struct AddListView: View {
    @State var title: String = ""
    @State private var sentences: [String] = []
    @State private var newSentence: String = ""
    @Binding var data: Chapters
    @Binding var isShowAddSheet: Bool
    
    var body: some View {
        VStack {
            TextField("Enter Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
            HStack {
                TextField("Enter sentence", text: $newSentence)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    addSentence()
                }) {
                    Image(systemName: "plus")
                }
                .disabled(newSentence.isEmpty)
                .padding(.leading, 8)
            }
        }
        .padding(10)
        Spacer()
        Text("Title: \(self.title)")
        List {
            ForEach(sentences, id: \.self) { sentence in
                SentenceView(sentence: sentence) {
                    removeSentence(sentence)
                }
            }
        }
        Spacer()
        Button(action: {
            data.addChapter(chapter: Chapter(section: title, sentences: sentences.map {Sentence(sentence: $0)}))
            self.isShowAddSheet = false
        }) {
            Text("저장")
        }
    }
}

struct SentenceView: View {
    let sentence: String
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            Text(sentence)
            
            Spacer()
            
            Button(action: onDelete) {
                Image(systemName: "minus")
            }
        }
    }
}

extension AddListView {
    private func addSentence() {
        sentences.append(newSentence)
        newSentence = ""
    }
    
    private func removeSentence(_ sentence: String) {
        if let index = sentences.firstIndex(of: sentence) {
            sentences.remove(at: index)
        }
    }
}
