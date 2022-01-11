//
//  CoreDataStorage.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 06/01/22.
//

import CoreData
import UIKit

public class CoreDataStorage {
    static let shared = CoreDataStorage()
    
    private init() {
    }
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveCharacter(name: String, id: Int, image: Data, url: String, descriptionText: String) {
        let character = CharacterStorage(context: context)
        character.name = name
        character.id = Int32(id)
        character.img = image
        character.url = url
        character.charDescription = descriptionText
        do {
            try context.save()
            print("Chracter saved!")
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func removeCharacter(id: Int){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CharacterStorage")
        let filter = NSPredicate(format: "id = %d", id)
        request.predicate = filter
        do {
            let characters = (try context.fetch(request)) as! [NSManagedObject]
            if let character = characters.first {
                context.delete(character)
                try context.save()
            }
            
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func checkFavoriteCharacter(id: Int) -> Bool {
        let request = CharacterStorage.fetchRequest()
        let filter = NSPredicate(format: "id = %d", id)
        request.predicate = filter
        do {
            let character = try context.fetch(request)
            if character.count > 0 {
                return true
            }
        } catch  {
            print(error.localizedDescription)
        }
        return false
    }
    
    func getCharacters() -> [CharacterStorage]{
        let request = CharacterStorage.fetchRequest()
        let sortDescritor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDescritor]
        
        do{
            let characters = try context.fetch(request)
            
            return characters
        }catch{
            print(error.localizedDescription)
        }
        
        return []
    }
}
