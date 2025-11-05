//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Chiraphat Techasiri on 11/3/25.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    @Published var allCoins = [Coin]()
    @Published var porfolioCoins = [Coin]()
    
    private let dataService = CoinDataService()
    
    init() {
        allCoins.append(Coin.mockCoin)
        porfolioCoins.append(Coin.mockCoin)
    }
    
    func fetchCoins() async {
        do {
            let coins = try await dataService.getCoins()
            await MainActor.run {
                self.allCoins = coins
            }
        } catch (NetworkingErrors.badURl) {
            print("Networking Error: Bad URL")
        } catch (NetworkingErrors.cannotDecodeContentData) {
            print("Networking Error: Cannot Decode Content Data")
        } catch (NetworkingErrors.badServerResponse) {
            print("Networking Error: Bad Server Response")
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
}
