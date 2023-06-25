//
//  AddListView.swift
//  ParroTalk
//
//  Created by apple on 2023/05/23.
//

import SwiftUI

struct AddListView: View {
    @State var title: String = ""
    @State private var sentences: [AddSentence] = []
    @State private var currentSentence: String = ""
    @State private var currentTranslate: String = ""
    private var currentState: Bool {
        currentSentence.isEmpty || currentTranslate.isEmpty
    }
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text("제목")
                            .modifier(TextFieldTitleModifier())
                        TextField("ex) I'm gonna~", text: $title)
                            .padding(14)
                            .background(Color("SecondaryColor"))
                            .cornerRadius(100, corners: .allCorners)
                        Divider()
                            .overlay(Color("AccentColor"))
                        Text("문장")
                            .modifier(TextFieldTitleModifier())
                        TextField("Enter sentence", text: $currentSentence)
                            .padding(14)
                            .background(Color("SecondaryColor"))
                            .cornerRadius(100, corners: .allCorners)
                        Text("번역")
                            .modifier(TextFieldTitleModifier())
                        TextField("Enter translate", text: $currentTranslate)
                            .padding(14)
                            .background(Color("SecondaryColor"))
                            .cornerRadius(100, corners: .allCorners)
                    }
                    .padding(.top, 14)
                    .padding(.bottom, 25)
                    .padding(.horizontal, 24)
                    .background(Color("BackgroundColor"))
                    .cornerRadius(20, corners: .allCorners)
                    .padding(.horizontal, 27)
                    .padding(.vertical, 18)
                    
                    Button(action: {
                        addSentence()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 36, height: 36)
                            .foregroundColor(currentState ? Color.gray : Color("AccentColor"))
                    }
                    .disabled(currentState)

                }
                Spacer()
                List {
                    ForEach(sentences, id: \.self) { addSentence in
                        SentenceView(addSentence: addSentence) {
                            removeSentence(addSentence)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                Spacer()
            }
            .toolbar() {
                Button(action: {
                    DataController().createChapter(title: title, sentences: sentences, context: managedObjectContext)
                    dismiss()
                }) {
                    Text("저장")
                }
            }
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
                    .modifier(BodyTitleModifier())
                Text(addSentence.translate)
                    .modifier(BodyContentModifier())
            }
            Spacer()
            Button(action: onDelete) {
                Image(systemName: "minus")
                    .foregroundColor(Color("AccentColor"))
            }
        }
        .padding(24)
        .background(.white)
        .cornerRadius(25, corners: [.bottomRight, .topLeft, .topRight])
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.08), radius: 5)
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

struct AddListView_Previews: PreviewProvider {
    static var previews: some View {
        AddListView()
    }
}
