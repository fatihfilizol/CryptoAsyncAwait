//
//  WebSevice.swift
//  cryptoCrazySwiftUI
//
//  Created by Fatih Filizol on 28.10.2022.
//

import Foundation

class WebService{
    /*
    func downloadCurrenciesAsync(url:URL) async throws-> [CryptoCurrency]{
        
        let (data,_) = try await URLSession.shared.data(from: url)
        
        let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
        
        return currencies ?? []
        
    }
    */
    
    func downloadCurrnciesContinuation(url:URL)async throws -> [CryptoCurrency]{
        // async olmayan fonksiyonu async hale getirmek
        try await withCheckedThrowingContinuation({ continuation in
            downloadCurrencies(url: url) { result in
                switch result {
                case.success(let cryptos):
                    continuation.resume(returning: cryptos ?? [])
                case.failure(let error) :
                    continuation.resume(throwing: error)
                }
            }
        })
    }
    
    func downloadCurrencies (url : URL, completion: @escaping(Result<[CryptoCurrency]?,DownloaderError>)->Void){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.badUrl))
            }
            
            guard let data = data,  error == nil else{
                
                return completion(.failure(.noData))
                
            }
            guard let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else{
                return completion(.failure(.dataParseError))
            }
            completion(.success(currencies))
        }.resume()
        
    }
     
    
}

enum DownloaderError : Error {
    
    case badUrl
    case noData
    case dataParseError
}
