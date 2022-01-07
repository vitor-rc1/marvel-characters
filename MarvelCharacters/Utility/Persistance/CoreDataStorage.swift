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
    
    func saveCharacter(name: String, id: Int, url: String) {
        let character = NSEntityDescription.insertNewObject(forEntityName: "Character", into: context)
        character.setValue(name, forKey: "name")
        character.setValue(id, forKey: "id")
        character.setValue(url, forKey: "url")
        // salvar
        do {
            try context.save()
            print("Chracter saved!")
        } catch  {
            print("An error has occurred.")
        }
    }
}
