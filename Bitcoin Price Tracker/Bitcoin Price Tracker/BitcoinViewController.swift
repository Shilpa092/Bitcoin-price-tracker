//
//  ViewController.swift
//  Bitcoin Price Tracker
//
//  Created by Admin on 16/05/22.
//

import UIKit

class BitcoinViewController: UIViewController {

    @IBOutlet weak var usdLabel: UILabel!
    
    @IBOutlet weak var jpyLabel: UILabel!
    
    @IBOutlet weak var eurLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       getPrice()
        
            }
    func getPrice(){
        if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR"){
        URLSession.shared.dataTask(with: url) { (data: Data?, response:URLResponse?, error:Error?) in
            print(data, response)
            if error == nil {
                if data != nil {
                    if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:Double]{
                        DispatchQueue.main.async {
                
                        if let usdPrice = json["USD"]{
                            
                            self.usdLabel.text = self.getStringFor(price: usdPrice, currencyCode: "USD")
                            }
                            
                            
                        
                        if let eurPrice = json["EUR"]{
                            self.eurLabel.text = self.getStringFor(price: eurPrice, currencyCode: "EUR")
                        }                
                        if let jpyPrice = json["JPY"]{
                            self.jpyLabel.text = self.getStringFor(price: jpyPrice, currencyCode: "JPY")
                        }
                        
                    }
                
        
            }
            }
        
                    }        else
                        {
                print("error ")
            }
        
        
    }.resume()
        }
}
    
        

    func getStringFor(price:Double,currencyCode:String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        if let priceString = formatter.string(from: NSNumber(value: price)){
            return priceString
        }
        return "error"
    }

    @IBAction func refreshTapped(_ sender: Any) {
        getPrice()
    }
}

    

        
                






