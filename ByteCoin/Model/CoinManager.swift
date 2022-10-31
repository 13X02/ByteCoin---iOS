//
//  CoinManager.swift
//  ByteCoin
//
//

import Foundation
protocol CoinManagerDelegate{
    func didUpdateCurrency(_ coinManager:CoinManager ,coin:CoinModel)
}
struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "USE_YOUR_APIKEY_FROM_COINAPI"
    var delegate : CoinManagerDelegate?
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR","INR"]
    func fetchPrice(at pos : Int){
        let urlString = "\(baseURL)/\(currencyArray[pos])?apikey=\(apiKey)"
        performRequest(with:urlString)
        
    }
    
    func performRequest(with urlString : String){
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler: {(data,response,error) in
                if error != nil{
                    print(error)
                    return
                }
                if let safeData = data{
                    if let coin = self.parseJSON(coinData: safeData){
                        self.delegate?.didUpdateCurrency(self, coin: coin)
                    }
                }
            })
            
            task.resume()
        }
    }
    func parseJSON(coinData:Data)->CoinModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let rate = decodedData.rate
            let currency = decodedData.asset_id_quote
            let coinModel = CoinModel(rate: rate, curreny: currency)
            return coinModel
        }
        catch{
            print(error)
            return nil
        }
    }

    
}
