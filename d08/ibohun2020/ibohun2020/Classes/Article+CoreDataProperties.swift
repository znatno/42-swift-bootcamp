//
//  Article+CoreDataProperties.swift
//  Pods
//
//  Created by Ivan BOHUN on 2/14/20.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var image: Data?
    @NSManaged public var language: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var modificationDate: Date?

    override public var description: String {
        return "title: \(title ?? ""), content: \(content ?? ""), language: \(language ?? ""), creationDate: \(creationDate ?? Date()), modificationDate: \(modificationDate ?? Date())"
    }
    
}
