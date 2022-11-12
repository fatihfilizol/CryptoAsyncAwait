//
//  CryptoViewModel.swift
//  cryptoCrazySwiftUI
//
//  Created by Fatih Filizol on 12.11.2022.
//

import Foundation

@MainActor
class CryptoListViewModel : ObservableObject{
    
    @Published var cryptoList = [CryptoViewModel]()
    
    let webService = WebService()

    /*
    func downloadCryptosAsync(url:URL) async {
        do{
            let cryptos = try await webService.downloadCurrenciesAsync(url: url)
            DispatchQueue.main.async {
                self.cryptoList = cryptos.map(CryptoViewModel.init)
            }
        }catch{
            print("Error")
        }
        
        
    }
     */
    
    func downloadCryptosContinuation(url:URL) async {
        do{
            let cryptos = try await webService.downloadCurrnciesContinuation(url: url)
            
            //Main Actor kullanıldığı için dispatchQueue kullanılmasına gerek kalmadı
            self.cryptoList = cryptos.map(CryptoViewModel.init)
            
            /*
            DispatchQueue.main.async {
                self.cryptoList = cryptos.map(CryptoViewModel.init)
            }
            */
        }catch{
            print("Error")
        }
        
        
    }
    
    /*
    func downloadCryptos(url:URL){
        
        webService.downloadCurrencies(url: url) { result in
            
            switch result{
                
                case .failure(let error):
                    print(error)
                case .success(let cryptos) :
                    if let cryptos = cryptos {
                        DispatchQueue.main.async {
                            self.cryptoList = cryptos.map(CryptoViewModel.init)
                        }
                        
                    }
                
            }
            
        }
     
    }
     */
}



struct CryptoViewModel{
    
    let crypto : CryptoCurrency
    
    var id : UUID?{
        
        crypto.id
        
    }
    
    var currency : String {
        
        crypto.currency
        
    }
    
    var price : String {
        
        crypto.price
        
    }
    
}
