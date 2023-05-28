//
//  DetailSentenceView.swift
//  rememberEnglish
//
//  Created by apple on 2023/05/23.
//

import SwiftUI
import AVFoundation

struct DetailView: View {
    @State private var selectedTab = 0
    @State private var nowSentence: String = ""
    @State private var translate: String = ""
    @State private var isRemember: Bool = false
    @State private var showAlert = false
    @State private var rememberAlert = false
    
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    let synthesizer = AVSpeechSynthesizer()
    var chapter: FetchedResults<Chapter>.Element

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(chapter.sentenceArray.indices, id: \.self) { index in
                VStack(alignment: .leading) {
                    if isRemember {
                        Text("\(chapter.sentenceArray[index].wrappedTranslate)")
                        Text(speechRecognizer.transcript)
                    } else {
                        Text(chapter.sentenceArray[index].wrappedSentence)
                            .onTapGesture {
                                speechText(of: chapter.sentenceArray[index].wrappedSentence)
                            }
                        Text("\(chapter.sentenceArray[index].wrappedTranslate)")
                    }
                }
                .tag(index)
                .padding(50)
                .onAppear {
                    self.nowSentence = chapter.sentenceArray[index].wrappedSentence
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .navigationBarItems(
            trailing: Button(action: {
                self.checkSentence()
                self.timeIntervalPage()
                self.checkMode()
            }) {
                Image(systemName: isRemember ? "record.circle.fill" : "record.circle")
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
    private func speechText(of sentence: String) {
        let utterance = AVSpeechUtterance(string: sentence)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        print("aaaaa", utterance)
        self.synthesizer.speak(utterance)
    }

    private func checkSentence() {
        if self.isRemember {
            speechRecognizer.stopTranscribing()
        } else {
            speechRecognizer.transcribe()
        }
    }

    private func timeIntervalPage() {
        if !self.isRemember {
            Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
                if selectedTab < chapter.sentenceArray.count && speechRecognizer.transcript.contains(nowSentence) {
                        speechRecognizer.reset()
                        self.selectedTab += 1
                } else {
                    self.rememberAlert = true
                    stopTime(timer: timer)
                }
            }
        }
    }

    private func stopTime(timer: Timer) {
        timer.invalidate()
        self.selectedTab = 0
        self.isRemember.toggle()
    }

    private func checkMode() {
        self.isRemember.toggle()
        if !self.isRemember {
            selectedTab = 0
        }
    }
}
