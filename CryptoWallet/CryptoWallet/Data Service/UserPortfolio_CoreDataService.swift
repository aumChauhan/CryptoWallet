import Foundation
import CoreData

class UserPortfolio_CoreDataService {
    
    @Published var savedEntitiesArrays: [UserPortfolio_Entity] = []
    private let container = NSPersistentContainer(name: "UserPortfolio_DataModels")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error Loading CoreData \(error.localizedDescription)")
            }
        }
        
        self.fetchData()
    }
    
    func fetchData() {
        let fetchRequest = NSFetchRequest<UserPortfolio_Entity>(entityName: "UserPortfolio_Entity")
        
        do {
            savedEntitiesArrays = try container.viewContext.fetch(fetchRequest)
        } catch let error {
            print("Error Fetching CoreData \(error.localizedDescription)")
        }
    }
    
    func addCoin(coin: Coin_DataModel, holdingAmount: Double) {
        let newCoin = UserPortfolio_Entity(context: container.viewContext)
        newCoin.coinID = coin.id
        newCoin.userAmountHolding = holdingAmount
        
        saveData()
        fetchData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error Saving CoreData \(error.localizedDescription)")
        }
    }
    
    func update2(coinEntity: UserPortfolio_Entity, amount: Double) {
        coinEntity.userAmountHolding = amount
        saveData()
        fetchData()
    }
    
    func update(coin: Coin_DataModel, amount: Double) {
        var oldCoin = UserPortfolio_Entity(context: container.viewContext)
        
        for coins in savedEntitiesArrays {
            if coins.userAmountHolding == coin.userCurrentHolding {
                oldCoin = coins
                oldCoin.userAmountHolding = amount
            }
        }
        saveData()
        fetchData()
    }
    
    func delete2(coin: Coin_DataModel) {
        for coins in savedEntitiesArrays {
            if coins.userAmountHolding == coin.userCurrentHolding {
                container.viewContext.delete(coins)
            }
        }
        saveData()
        fetchData()
    }
}
