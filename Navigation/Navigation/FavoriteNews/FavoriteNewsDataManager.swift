//
//  FavoriteNewsDataManager.swift
//  Navigation
//
//  Created by Sokolov on 20.01.2023.
//

import CoreData

class FavoriteNewsDataManager {
    
    static let shared = FavoriteNewsDataManager()
    
    init(){
        
        reloadNews()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "FavoriteNewsData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            print("storeDescription = \(storeDescription)")
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    } ()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    var news = [News]()
    
    
    func reloadNews() {
        let request = News.fetchRequest()
        
        let news = (try? persistentContainer.viewContext.fetch(request)) ?? []
        
        self.news = news
    }
    
    func createNews(id: String, title: String, image: String, text: String, likes: String, views: String) {
                
        persistentContainer.performBackgroundTask { contextBackground in
            let news =  News(context: contextBackground)
            news.id = id
            news.title = title
            news.image = image
            news.text = text
            news.likes = likes
            news.views = views
            
            do {
                try contextBackground.save()
            } catch {
                print(error)
            }
            
            self.reloadNews()
//            completion()
        }
//        saveContext()
    }
    
    func deleteNews(news: News) {
        persistentContainer.viewContext.delete(news)
        reloadNews()
    }
    
    
    func getNews(searchText: String!=nil, context: NSManagedObjectContext!=nil) -> [News] {
        let fetchRequest = News.fetchRequest()
        if let searchText, searchText != "" {
            fetchRequest.predicate = NSPredicate(format: "title contains[c] %@", searchText)
        }
        return (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
    }
}
