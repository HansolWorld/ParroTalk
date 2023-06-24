//
//  RememberView.swift
//  ParroTalk
//
//  Created by apple on 2023/06/11.
//

import SwiftUI
import AVFoundation

struct RememberView: View {
    @Binding var seletecdIndex: Int
    
    var sentence: Sentence
    var index: Int
    
    let synthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        VStack {
            Button(action: {
                self.speechText(to: sentence.wrappedSentence)
                seletecdIndex = index
            }) {
                Image(systemName: "speaker.wave.2.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .padding(20)
                    .tint(Color(.white))
                    .background(Color("AccentColor"))
                    .cornerRadius(30)
            }
            .padding(.bottom, 30)
            Text(sentence.wrappedSentence)
                .modifier(BodyTitleModifier())
            Text(sentence.wrappedTranslate)
                .modifier(BodyTitleModifier())
                .foregroundColor(Color("DisabledColor"))
        }
        .padding(.vertical, 35)
        .frame(maxWidth: .infinity)
        .background(Color("BackgroundColor"))
        .cornerRadius(25, corners: .allCorners)
        .padding(10)
    }
}

extension RememberView {
    private func speechText(to sentence: String) {
        let utterance = AVSpeechUtterance(string: sentence)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        
        self.synthesizer.speak(utterance)
    }
}
