//
//  PortfolioDataService.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/22/25.
//

import Combine
import CoreData
import Foundation

class PortfolioDataService {
    @Published var savedEntities = [PortfolioEntity]()
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("There was an error loading the Core Data: \(error)")
            }
            self.getPortfolio()
        }
    }
    
    //MARK: PUBLIC
    
    func updatePortfolio(coin: Coin, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    //MARK: PRIVATE
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("There was an error fetching the Saved Entities: \(error)")
        }
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func add(coin: Coin, amount: Double) {
        let newEntity = PortfolioEntity(context: container.viewContext)
        newEntity.coinID = coin.id
        newEntity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    /// this just saves the data and fetches from Core Data again instead of appending it to the savedEntities list
    private func applyChanges() {
        save()
        getPortfolio()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("There way an error saving to Core Data: \(error)")
        }
    }
}
