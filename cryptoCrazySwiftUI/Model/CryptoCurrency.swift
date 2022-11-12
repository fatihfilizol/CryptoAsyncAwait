//
//  CryptoCurrency.swift
//  cryptoCrazySwiftUI
//
//  Created by Fatih Filizol on 28.10.2022.
//

import Foundation

struct CryptoCurrency: Hashable, Decodable, Identifiable {
    
    
    let id = UUID()
    let currency : String
    let price : String
    
    
    private enum CodingKeys : String, CodingKey{
        
        case currency = "currency"
        case price = "price"
        
    }
    
}
