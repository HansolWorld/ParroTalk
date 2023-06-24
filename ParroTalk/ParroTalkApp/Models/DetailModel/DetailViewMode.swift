//
//  DetailViewMode.swift
//  ParroTalk
//
//  Created by apple on 2023/05/29.
//

import Foundation

enum Mode {
    case remember
    case test
    
    mutating func toggle() {
        switch self {
        case .remember:
            self = .test
        case .test:
            self = .remember
        }
    }
}
