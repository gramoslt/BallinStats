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

        do {
            try viewContext.save()
        } catch let error {
            fatalError(String(describing: error.localizedDescription))
        }
    }
}
