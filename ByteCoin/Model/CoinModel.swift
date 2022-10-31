//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Abhijith H on 31/10/22.
//

import Foundation

struct CoinModel{
    
    let rate : Double
    
    let curreny : String
    
    var rateString : String{
        return String(format: "%.4f", rate)
    }
}
