//
//  CoreDataManager.swift
//  BallinStats
//
//  Created by Gerardo Leal on 24/08/23.
//

import CoreData

class CoreDataManager {
    private let persistanceContainer: NSPersistentContainer

    init(modelName: String) {
        self.persistanceContainer = NSPersistentContainer(name: modelName)
    }

    static let shared : CoreDataManager = {
        let coreDataManager = CoreDataManager(modelName: "BallinStats")
        return coreDataManager
    }()

    var viewContext: NSManagedObjectContext {
        // reference to scratchpad on the store
        return persistanceContainer.viewContext
    }

    func saveContext() {
        if self.viewContext.hasChanges {
        do {
          try viewContext.save()
        } catch {
          let nserror = error as NSError
          fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
      }
    }

    func load() {
        persistanceContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError(String(describing: error?.localizedDescription))
            }
            print(storeDescription)
        }
    }
}

extension CoreDataManager {
    func saveTeam(team: TeamDetails) { // this is the function that saves into the DB
        let tempTeam = Team(context: viewContext)
        tempTeam.id = Int32(team.id)
        tempTeam.abbreviation = team.abbreviation
        tempTeam.city = team.city
        tempTeam.conference = team.conference
        tempTeam.division = team.division
        tempTeam.fullName = team.fullName
        tempTeam.logoString = team.logoString
        tempTeam.name = team.name

        saveContext()
    }

    func deleteTeamById(with id: Int32) { // this is the function that saves into the DB
        let fetchRequest: NSFetchRequest<Team> = Team.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id==\(id)")
        if let result = try? viewContext.fetch(fetchRequest) {
            for object in result {
                viewContext.delete(object)
            }
        }

        saveContext()
    }

    func checkIfItemExist(id: Int) -> Bool {
        let managedContext = CoreDataManager.shared.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Team")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "id == %d" ,id)

        do {
            let count = try managedContext.count(for: fetchRequest)
            return count > 0 
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
}
