//
//  ArticleManager.swift
//  ibohun2020_Example
//
//  Created by Ivan BOHUN on 2/14/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import CoreData

public class ArticleManager {
    
    var managedObjectContext: NSManagedObjectContext
    
    public init() {
        guard let modelURL = Bundle(for: Article.self).url(forResource: "Article", withExtension: "momd") else {
            fatalError("Could not locate data file")
        }
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Could not initialize object model from \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("Unable to resolve document directory")
        }
        let storeURL = docURL.appendingPathComponent("Article").appendingPathExtension("sqlite")
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }
    
    
    public func newArticle() -> Article {
        return NSEntityDescription.insertNewObject(forEntityName: "Article", into: managedObjectContext) as! Article
    }

    public func getAllArticles() -> [Article] {

        let articlesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")

        do {
            let fetchedArticles = try managedObjectContext.fetch(articlesFetch) as! [Article]

            return fetchedArticles
        }
        catch {
            fatalError("Failed to fetch articles: \(error)")
        }

    }

    public func getArticles(withLang lang: String) -> [Article] {

        let articlesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        do {
            articlesFetch.predicate = NSPredicate(format: "language == %@", lang)
            let fetchedArticles = try managedObjectContext.fetch(articlesFetch) as! [Article]

            return fetchedArticles
        }
        catch {
            fatalError("Failed to fetch articles: \(error)")
        }
    }
    

    public func getArticles(containString str: String) -> [Article] {

        let articlesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")

        do {
            articlesFetch.predicate = NSPredicate(format: "title CONTAINS[c] %@ OR content CONTAINS[c] %@", str, str)
            let fetchedArticles = try managedObjectContext.fetch(articlesFetch) as! [Article]

            return fetchedArticles
        }
        catch {
            fatalError("Failed to fetch articles: \(error)")
        }

    }

    public func removeArticle(article: Article) {
        managedObjectContext.delete(article)
    }

    public func save() {
        do {
            try managedObjectContext.save()
            print("MOC is saved")
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
   
}

