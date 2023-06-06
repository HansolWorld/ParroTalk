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
                Text("난 ~ 할거야")
            }
            Spacer()
            VStack {
                Text("학습전")
                    .padding(3)
                    .background(Color("AccentColor"))
                    .cornerRadius(4)
                Image(systemName: "chevron.right.circle.fill")
                    .foregroundColor(.accentColor)
            }
        }
    }
}

struct PatternCellView_Previews: PreviewProvider {
    static var previews: some View {
        PatternCellView()
    }
}
