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
    
    func saveCharacter(name: String, id: Int, image: Data) {
        let character = NSEntityDescription.insertNewObject(forEntityName: "Character", into: context)
        character.setValue(name, forKey: "name")
        character.setValue(id, forKey: "id")
        character.setValue(image, forKey: "img")
        // salvar
        do {
            try context.save()
            print("Chracter saved!")
        } catch  {
            print("An error has occurred.")
        }
    }
    
    func removeCharacter(id: Int){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Character")
        let filter = NSPredicate(format: "id = %d", id)
        request.predicate = filter
        do {
            let characters = (try context.fetch(request)) as! [NSManagedObject]
            if let character = characters.first {
                context.delete(character)
                try context.save()
            }
            
        } catch  {
            print("An error has occurred.")
        }
    }
    
    func checkFavoriteCharacter(id: Int) -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Character")
        let filter = NSPredicate(format: "id = %d", id)
        request.predicate = filter
        do {
            let character = try context.fetch(request)
            if character.count > 0 {
                return true
            }
        } catch  {
            print("An error has occurred.")
        }
        return false
    }
    
    func getCharacters() -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Character")
        
        do {
            let characters = try context.fetch(request)
            
            if characters.count > 0 {
                return characters as! [NSManagedObject]
            }
        } catch  {
            print("An error has occurred.")
        }
        return []
    }
}
