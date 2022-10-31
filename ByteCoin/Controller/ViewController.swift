//
//  ViewController.swift
//  ByteCoin

//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    var coinManager = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        coinManager.fetchPrice(at: 0)
    }
    
}


//MARK: - UIPickerViewDelegare


extension ViewController : UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.fetchPrice(at : row)
    }
}



//MARK: - UIPickerViewDataSource

extension ViewController : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    
}

//MARK: - CoinManagerDelegate

extension ViewController : CoinManagerDelegate{
    func didUpdateCurrency(_ coinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.currencyLabel.text = coin.curreny
            self.resultLabel.text = coin.rateString
        }
    }
    
    
}
