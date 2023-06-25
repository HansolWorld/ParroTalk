//
//  TextView.swift
//  ParroTalk
//
//  Created by apple on 2023/06/11.
//

import SwiftUI

struct TestView: View {
    
    var translate: String
    var sentence: String
    var timeCount: Int
    @Binding var checkTest: Bool
    @StateObject var speechRecognizer: SpeechRecognizer
    
    var body: some View {
        VStack {
            Text("Count Down")
                .modifier(MidiumTitleModifier())
                .foregroundColor(Color("AccentColor"))
                .padding(.bottom, 7)
            Text("\(10 - self.timeCount)")
                .modifier(AccentContentModifier())
                .foregroundColor(Color("AccentColor"))
                .padding(.bottom, 20)
            Text("\(self.speechRecognizer.transcript)")
                .padding(10)
                .background(.white)
                .cornerRadius(100, corners: .allCorners)
                .modifier(BodyTitleModifier())
                .padding(.bottom, 6)
            Text(translate)
                .foregroundColor(Color("DisabledColor"))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 30)
        .background(Color("BackgroundColor"))
        .cornerRadius(25, corners: .allCorners)
        .padding(27)
        .onChange(of: speechRecognizer.transcript) { _ in
            self.checkTranscript()
        }
    }
}


extension TestView {
    private func checkTranscript() {
        if self.speechRecognizer.transcript.contains(sentence) {
            self.speechRecognizer.stopTranscribing()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.checkTest = true
            })
        }
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(translate: "문장을 말해라", sentence: "", timeCount: 0, checkTest: .constant(false), speechRecognizer: SpeechRecognizer())
    }
}
