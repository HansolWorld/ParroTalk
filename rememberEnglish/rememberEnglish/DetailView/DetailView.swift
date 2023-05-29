//
//  DetailSentenceView.swift
//  rememberEnglish
//
//  Created by apple on 2023/05/23.
//

import SwiftUI
import AVFoundation

struct DetailView: View {
    @State private var seletecdIndex: Int = 0
    @State private var timeCount: Int = 0
    @State private var currentSentence: String = ""
    @State private var translate: String = ""
    @State private var isMode: Mode = .remember
    @State private var showAlert: Bool = false
    @State private var rememberAlert: Bool = false
    @State private var timer: Timer?
    
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    
    let synthesizer = AVSpeechSynthesizer()
    var chapter: FetchedResults<Chapter>.Element

    var body: some View {
        TabView(selection: $seletecdIndex) {
            ForEach(Array(self.chapter.sentenceArray.enumerated()), id: \.0) { index, sentence in
                VStack(alignment: .center) {
                    switch self.isMode {
                    case .test:
                        Text("\(10 - self.timeCount)")
                            .font(.headline)
                            .padding(.bottom, 20)
                        Text("\(self.chapter.sentenceArray[seletecdIndex].wrappedTranslate)")
                        Text(self.speechRecognizer.transcript)
                    case .remember:
                        Text(sentence.wrappedSentence)
                            .onTapGesture {
                                self.speechText(to: sentence.wrappedSentence)
                                seletecdIndex = index
                            }
                        Text("\(sentence.wrappedTranslate)")
                    }
                }
                .padding(50)
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .navigationBarItems(
            trailing: Button(action: {
                self.checkMode()
                self.startSpeechRecognizer()
                self.timeIntervalPage()
            }) {
                Image(systemName: isMode == .test ? "record.circle.fill" : "record.circle")
            }
        )
        .alert("다시", isPresented: $rememberAlert) {
            Button("Ok") {}
        } message: {
            Text("다시외우고 와라")
        }
    }
}

extension DetailView {
    private func speechText(to sentence: String) {
        let utterance = AVSpeechUtterance(string: sentence)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        
        self.synthesizer.speak(utterance)
    }

    private func startSpeechRecognizer() {
        switch self.isMode {
        case .remember:
            self.speechRecognizer.stopTranscribing()
        case .test:
            self.speechRecognizer.transcribe()
        }
    }

    private func timeIntervalPage() {
        switch self.isMode {
        case .remember:
            stopTimer()
        case .test:
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                self.timeCount += 1
                if self.timeCount == 10 {
                    if self.speechRecognizer.transcript.contains(self.currentSentence) {
                        self.timeCount = 0
                        self.seletecdIndex += 1
                    } else {
                        stopTimer()
                        self.rememberAlert = true
                    }
                }
                
                if self.seletecdIndex == chapter.sentenceArray.count {
                    stopTimer()
                }
            }
        }
    }
    
    private func stopTimer() {
        self.timer?.invalidate()
        self.timeCount = 0
        self.seletecdIndex = 0
        self.isMode = .remember
    }

    private func checkMode() {
        self.isMode.toggle()
        self.seletecdIndex = 0
    }
}
