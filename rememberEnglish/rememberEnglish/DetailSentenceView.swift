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
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRemember: Bool = false
    @State private var nowSentence: String = ""
    @State private var showAlert = false
    @State private var rememberAlert = false
    @State private var selectedTab = 0

    let synthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(chapter.sentences.indices, id: \.self) { index in
                
                VStack(alignment: .leading) {
                    if isRemember {
                        Text("\(chapter.sentences[index].translate)")
                        Text(speechRecognizer.transcript)
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
                .onAppear {
                    self.nowSentence = chapter.sentences[index].sentence
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .navigationBarItems(
            trailing: Button(action: {
                self.checkSentence()
                if !self.isRemember {
                    self.timeIntervalPage()
                }
                self.checkMode()
            }) {
                Image(systemName: isRemember ? "record.circle.fill" : "record.circle")
            }
        )
        .alert("번역", isPresented: $showAlert) {
            Button("Ok") {}
        } message: {
            Text("모든 문장을 번역해야합니다.")
        }
        .alert("다시", isPresented: $rememberAlert) {
            Button("Ok") {}
        } message: {
            Text("다시외우고 와라")
        }
    }
}

extension DetailSentenceView {
    private func speechText(of sentence: String) {
        let utterance = AVSpeechUtterance(string: sentence)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        synthesizer.speak(utterance)
    }
    
    private func checkSentence() {
        if self.isRemember {
            speechRecognizer.stopTranscribing()
        } else {
            speechRecognizer.transcribe()
        }
    }
    
    private func timeIntervalPage() {
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            if self.isRemember {
                stopTime(timer: timer)
            }
            
            if selectedTab < chapter.sentences.count {
                if speechRecognizer.transcript.contains(nowSentence) {
                    speechRecognizer.reset()
                    self.selectedTab += 1
                } else {
                    self.rememberAlert = true
                    stopTime(timer: timer)
                }
            } else {
                stopTime(timer: timer)
            }
        }
    }
    
    private func stopTime(timer: Timer) {
        timer.invalidate()
        self.selectedTab = 0
        self.isRemember.toggle()
    }
    
    private func checkMode() {
        let checkTranslate = chapter.sentences.filter { $0.translate == "" }
        if checkTranslate.isEmpty {
            self.isRemember.toggle()
            selectedTab = 0
        } else {
            self.showAlert = true
        }
    }
}
