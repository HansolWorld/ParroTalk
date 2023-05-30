//
//  AddListView.swift
//  rememberEnglish
//
//  Created by apple on 2023/05/23.
//

import SwiftUI

struct AddListView: View {
    @State var title: String = ""
    @State private var sentences: [AddSentence] = []
    @State private var currentSentence: String = ""
    @State private var currentTranslate: String = ""
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            TextField("Enter Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
            HStack {
                TextField("Enter sentence", text: $currentSentence)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack {
                TextField("Enter translate", text: $currentTranslate)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    addSentence()
                }) {
                    Image(systemName: "plus")
                }
                .disabled(currentSentence.isEmpty || currentTranslate.isEmpty)
                .padding(.leading, 8)
            }
        }
        .padding(10)
        Spacer()
        Text("Title: \(self.title)")
        List {
            ForEach(sentences, id: \.self) { addSentence in
                SentenceView(addSentence: addSentence) {
                    removeSentence(addSentence)
                }
            }
        }
        Spacer()
        Button(action: {
            DataController().createChapter(title: title, sentences: sentences, context: managedObjectContext)
            dismiss()
        }) {
            Text("저장")
        }
    }
}

struct SentenceView: View {
    let addSentence: AddSentence
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(addSentence.sentence)
                Text(addSentence.translate)
            }
            Spacer()
            Button(action: onDelete) {
                Image(systemName: "minus")
            }
        }
    }
}

extension AddListView {
    private func addSentence() {
        let newAddSentence = AddSentence(sentence: currentSentence, translate: currentTranslate)
        self.sentences.append(newAddSentence)
        self.currentSentence = ""
        self.currentTranslate = ""
    }
    
    private func removeSentence(_ sentence: AddSentence) {
        if let index = sentences.firstIndex(of: sentence) {
            sentences.remove(at: index)
        }
    }
}
