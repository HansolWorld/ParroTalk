//
//  addSentence.swift
//  ParroTalk
//
//  Created by apple on 2023/05/28.
//

import Foundation

struct AddSentence: Hashable {
    let id: UUID = UUID()
    let sentence: String
    let translate: String
}
