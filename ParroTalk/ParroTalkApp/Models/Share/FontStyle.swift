//
//  FontStyle.swift
//  ParroTalk
//
//  Created by apple on 2023/06/06.
//

import SwiftUI

struct AccentContentModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 40))
            .fontWeight(.bold)
    }
}

struct BodyTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
            .fontWeight(.bold)
    }
}

struct MidiumTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
            .fontWeight(.medium)
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
            .padding([.bottom, .top], 3)
            .padding([.leading, .trailing], 10)
            .background(Color("AccentColor"))
            .cornerRadius(4)
    }
}


struct TextFieldTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16))
            .fontWeight(.bold)
            .padding([.leading, .trailing], 14)
    }
}
