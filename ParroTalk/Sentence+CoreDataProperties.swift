//
//  Sentence+CoreDataProperties.swift
//  ParroTalk
//
//  Created by apple on 2023/05/28.
//
//

import Foundation
import CoreData


extension Sentence {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sentence> {
        return NSFetchRequest<Sentence>(entityName: "Sentence")
    }

    @NSManaged public var sentence: String?
    @NSManaged public var translate: String?
    @NSManaged public var date: Date?
    @NSManaged public var chapter: Chapter?
    
    public var wrappedSentence: String {
        sentence ?? "Unknown Sentence"
    }
    
    public var wrappedTranslate: String {
        translate ?? "Unkown Translate"
    }
    
    public var wrappedDate: Date {
        date ?? Date()
    }
}

extension Sentence : Identifiable {

}
