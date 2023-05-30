//
//  Chapter+CoreDataProperties.swift
//  ParroTalk
//
//  Created by apple on 2023/05/28.
//
//

import Foundation
import CoreData


extension Chapter {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chapter> {
        return NSFetchRequest<Chapter>(entityName: "Chapter")
    }
    
    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var sentences: NSSet?
    
    public var wrappedTitle: String {
        title ?? "Unknown Title"
    }
    
    public var wrappedDate: Date {
        date ?? Date()
    }
    
    public var sentenceArray: [Sentence] {
        let set = sentences as? Set<Sentence> ?? []
        
        return set.sorted {
            $0.wrappedDate < $1.wrappedDate
        }
    }
}

// MARK: Generated accessors for sentences
extension Chapter {

    @objc(addSentencesObject:)
    @NSManaged public func addToSentences(_ value: Sentence)

    @objc(removeSentencesObject:)
    @NSManaged public func removeFromSentences(_ value: Sentence)

    @objc(addSentences:)
    @NSManaged public func addToSentences(_ values: NSSet)

    @objc(removeSentences:)
    @NSManaged public func removeFromSentences(_ values: NSSet)

}

extension Chapter : Identifiable {

}
