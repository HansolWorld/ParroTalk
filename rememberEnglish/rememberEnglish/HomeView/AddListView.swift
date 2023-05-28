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
    @State private var newSentence: String = ""
    @State private var newTranslate: String = ""
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            TextField("Enter Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
            HStack {
                TextField("Enter sentence", text: $newSentence)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack {
                TextField("Enter translate", text: $newTranslate)
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
        let newAddSentence = AddSentence(sentence: newSentence, translate: newTranslate)
        self.sentences.append(newAddSentence)
        self.newSentence = ""
        self.newTranslate = ""
    }
    
    private func removeSentence(_ sentence: AddSentence) {
        if let index = sentences.firstIndex(of: sentence) {
            sentences.remove(at: index)
        }
    }
}
