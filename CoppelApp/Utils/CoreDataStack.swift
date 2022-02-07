//
//  CoreDataStack.swift
//  CoppelApp
//
//  Created by Jose Cadena on 06/02/22.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoppelApp")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { return persistentContainer.viewContext }
    
    class func saveContext () {
        let context = persistentContainer.viewContext
        
        guard context.hasChanges else {
            return
        }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func saveAsFav(movie: Movie){
        let newFav = TVShow(context: CoreDataStack.context)
        newFav.adult = movie.adult ?? false
        newFav.backdrop_path = movie.backdrop_path ?? ""
        newFav.id = Int64(movie.id ?? 0)
        newFav.original_language = movie.original_language ?? ""
        newFav.original_title = movie.original_title ?? ""
        newFav.overview = movie.overview ?? ""
        newFav.popularity = movie.popularity ?? 0
        newFav.poster_path = movie.poster_path ?? ""
        newFav.release_date = movie.release_date ?? ""
        newFav.title = movie.title ?? ""
        newFav.video = movie.video ?? false
        newFav.vote_average = movie.vote_average ?? 0
        newFav.vote_count = Int64(movie.vote_count ?? 0)
//        newFav.addToFavs(newFav)
        CoreDataStack.saveContext()
    }
    
    func removeFromFavorites(movie:Movie){
        let fetchRequest: NSFetchRequest<TVShow> = TVShow.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(TVShow.release_date), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let tvShows = try CoreDataStack.context.fetch(fetchRequest)
            if let toDelete = tvShows.first(where: {$0.id == movie.id ?? 0}){
                CoreDataStack.context.delete(toDelete)
                try CoreDataStack.context.save()
            }
            
        } catch {
            
        }
    }
    
    func removeAll(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "TVShow")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try CoreDataStack.context.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func getMovies() -> [Movie] {
        let fetchRequest: NSFetchRequest<TVShow> = TVShow.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(TVShow.release_date), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let tvShows = try CoreDataStack.context.fetch(fetchRequest)
            var movies = [Movie]()
            tvShows.forEach{
                let movie = Movie.init(poster_path: $0.poster_path, adult: $0.adult, overview: $0.overview, release_date: $0.release_date, genre_ids: [], id: Int($0.id), original_title: $0.original_title, original_language: $0.original_language, title: $0.title, backdrop_path: $0.backdrop_path, popularity: $0.popularity, vote_count: Int($0.vote_count), video: $0.video, vote_average: $0.vote_average)
                movies.append(movie)
            }
            return movies
        } catch {
            return []
        }
    }
    
}
extension TVShow{
//    @objc(addToFavsObject:)
//    @NSManaged public func addToFavs(_ value: TVShow)
}
