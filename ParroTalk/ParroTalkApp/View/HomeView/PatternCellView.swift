//
//  PatternCellView.swift
//  ParroTalk
//
//  Created by apple on 2023/06/06.
//

import SwiftUI

struct PatternCellView: View {
    var title: String
    var content: String
    var complete: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            VStack {
                Text(title)
                    .modifier(BodyTitleModifier())
                Text(content)
                    .modifier(BodyContentModifier())
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("학습전")
                    .modifier(LabelContentModifier())
                    .padding(.bottom, 15)
                    .opacity(complete ? 0 : 1)
                Image(systemName: "chevron.forward.circle.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.accentColor)
            }
            .padding(.vertical, 20)
        }
        .padding(.horizontal, 28)
        .background(.white)
        .cornerRadius(25, corners: [.bottomRight, .topLeft, .topRight])
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.08), radius: 5)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}


struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


struct PatternCellView_Previews: PreviewProvider {
    static var previews: some View {
        PatternCellView(title: "I'm gonna", content: "난 ~ 할거야", complete: false)
    }
}
