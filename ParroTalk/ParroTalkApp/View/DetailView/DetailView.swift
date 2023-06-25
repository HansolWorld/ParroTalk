//
//  DetailSentenceView.swift
//  ParroTalk
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
    @State private var rememberAlert: Bool = false
    @State private var timer: Timer?
    @State private var checkTest: Bool = false
    
    @StateObject var speechRecognizer: SpeechRecognizer = SpeechRecognizer()
    
    let synthesizer = AVSpeechSynthesizer()
    var chapter: FetchedResults<Chapter>.Element
   
    var body: some View {
        VStack {
            TabView(selection: $seletecdIndex) {
                ForEach(Array(self.chapter.sentenceArray.enumerated()), id: \.0) { index, sentence in
                    VStack {
                        switch self.isMode {
                        case .test:
                            TestView(translate: sentence.wrappedTranslate, sentence: sentence.wrappedSentence, timeCount: timeCount, checkTest: $checkTest, speechRecognizer: speechRecognizer)
                        case .remember:
                            RememberView(seletecdIndex: $seletecdIndex, sentence: sentence, index: index)
                        }
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .onAppear() {
                UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color("AccentColor"))
                UIPageControl.appearance().pageIndicatorTintColor = UIColor.white
            }
            .alert("다시", isPresented: $rememberAlert) {
                Button("Ok") {}
            } message: {
                Text("다시외우고 와라")
            }
            HStack {
                Spacer()
                Button(action: {
                    self.checkMode()
                    self.startSpeechRecognizer()
                    self.timeIntervalPage()
                }) {
                    Image(systemName: "mic.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                }
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 55)
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
                if self.checkTest {
                    self.timeCount = 0
                    self.speechRecognizer.transcribe()
                    self.seletecdIndex += 1
                    self.checkTest = false
                }
                if self.timeCount == 10 {
                    stopTimer()
                    self.rememberAlert = true
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


struct DetailView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
                .environment(\.managedObjectContext, DataController().container.viewContext)
        }
        .accentColor(.accentColor)
    }
}
