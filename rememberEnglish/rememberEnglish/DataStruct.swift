//
//  DataStruct.swift
//  rememberEnglish
//
//  Created by apple on 2023/05/21.
//

import Foundation

struct Sentence: Hashable {
    let id: UUID = UUID()
    let sentence: String
    var translate: String = ""
}

class Chapter: ObservableObject, Identifiable, Equatable {
    let id = UUID()
    let section: String
    @Published var sentences: [Sentence]
    
    init(section: String, sentences: [Sentence]) {
        self.section = section
        self.sentences = sentences
    }
    
    static func == (lhs: Chapter, rhs: Chapter) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Chapters {
    var chapters: [Chapter] = [
        Chapter(section: "I'm gonna~", sentences:
                    [
                        Sentence(sentence: "I'm gonna talk to him"),
                        Sentence(sentence: "I'm gonna do my job"),
                        Sentence(sentence: "I'm gonna go take a shower")
                    ]
               ),
        Chapter(section: "I'm not gonna~", sentences:
                    [
                        Sentence(sentence: "I'm gonna talk to him"),
                        Sentence(sentence: "I'm gonna do my job"),
                        Sentence(sentence: "I'm gonna go take a shower")
                    ]
               )
    ]
    
    mutating func addChapter(chapter: Chapter) {
        self.chapters.append(chapter)
    }
}
