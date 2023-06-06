//
//  FontStyle.swift
//  ParroTalk
//
//  Created by apple on 2023/06/06.
//

import SwiftUI

struct BodyTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
            .fontWeight(.bold)
    }
}

struct BodyContentModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 15))
            .fontWeight(.regular)
    }
}


struct LabelContentModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 10))
            .fontWeight(.regular)
            .background(Color("AccentColor"))
            .cornerRadius(4)
    }
}
