//
//  PersistanceController.swift
//  ParroTalk
//
//  Created by apple on 2023/05/27.
//

import Foundation
import CoreData
import OSLog

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ChapterModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                os_log("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            os_log("Data Saved ")
        } catch {
            os_log("Failed to save data")
        }
    }
    
    func createChapter(title: String, sentences: [AddSentence], context: NSManagedObjectContext) {
        let chapter = Chapter(context: context)
        chapter.date = Date()
        chapter.title = title
        
        sentences.forEach {sent in
            let sentence = Sentence(context: context)
            sentence.date = Date()
            sentence.chapter = chapter
            sentence.sentence = sent.sentence
            sentence.translate = sent.translate
            
            self.save(context: context)
        }
    }
    
    func deleteChapter(chapter: Chapter, context: NSManagedObjectContext) {
        context.delete(chapter)
        do {
            try context.save()
        } catch {
            os_log("Failed to delete Chapter")
        }
    }
}
