//
//  DetailSentenceView.swift
//  rememberEnglish
//
//  Created by apple on 2023/05/23.
//

import SwiftUI
import AVFoundation

struct DetailSentenceView: View {
    @StateObject var chapter: Chapter
    @State private var isRemember: Bool = false
    @State private var showAlert = false
    @State private var selectedTab = 0

    let synthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(chapter.sentences.indices, id: \.self) { index in
                VStack(alignment: .leading) {
                    if isRemember {
                        Text("\(chapter.sentences[index].translate)")
                    } else {
                        Text(chapter.sentences[index].sentence)
                            .onTapGesture {
                                speechText(of: chapter.sentences[index].sentence)
                            }
                        Text("\(chapter.sentences[index].translate)")
                        TextField("한국어로 번역해 주세요", text: $chapter.sentences[index].translate)
                            .background(Color(uiColor: .secondarySystemBackground))
                            .textFieldStyle(.roundedBorder)
                    }
                }
                .padding(50)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .navigationBarItems(
            trailing: Button(action: {
                self.checkMode()
                self.timeIntervalPage()
            }) {
                Image(systemName: isRemember ? "record.circle.fill" : "record.circle")
            }
        )
        .alert("번역", isPresented: $showAlert) {
            Button("Ok") {}
        } message: {
            Text("모든 문장을 번역해야합니다.")
        }
    }
}

extension DetailSentenceView {
    private func checkMode() {
        let checkTranslate = chapter.sentences.filter { $0.translate == "" }
        if checkTranslate.isEmpty {
            self.isRemember.toggle()
            selectedTab = 0
        } else {
            self.showAlert = true
        }
    }
    
    private func timeIntervalPage() {
        if self.isRemember == true {
            Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
                if selectedTab < chapter.sentences.count {
                    selectedTab += 1
                } else {
                    timer.invalidate()
                    selectedTab = 0
                }
            }
        }
    }
    
    private func speechText(of sentence: String) {
        let utterance = AVSpeechUtterance(string: sentence)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        synthesizer.speak(utterance)
    }
}
