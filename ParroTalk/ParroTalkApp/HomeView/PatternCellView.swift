//
//  PatternCellView.swift
//  ParroTalk
//
//  Created by apple on 2023/06/06.
//

import SwiftUI

struct PatternCellView: View {
    var body: some View {
        HStack {
            VStack {
                Text("im gonna")
                    .modifier(BodyTitleModifier())
                Text("난 ~ 할거야")
                    .modifier(BodyContentModifier())
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("학습전")
                    .modifier(LabelContentModifier())
                    .padding(.bottom, 15)
                Image(systemName: "chevron.forward.circle.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.accentColor)
            }
            .padding([.top, .bottom], 20)
        }
        .padding([.leading, .trailing], 28)
        .background(.white)
        .cornerRadius(25, corners: [.bottomRight, .topLeft, .topRight])
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.33), radius: 0.6)
        .padding(27)
        
    }
}

struct PatternCellView_Previews: PreviewProvider {
    static var previews: some View {
        PatternCellView()
    }
}
