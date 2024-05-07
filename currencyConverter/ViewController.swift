//
//  ViewController.swift
//  currencyConverter
//
//  Created by İmat Gökaslan on 7.05.2024.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var trLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClick(_ sender: Any) {
    // 1) request & Session
    // 2) response & data
    // 3) Parsing & JSON Serialization
        
        //1.kısım
    let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/CurrencyData/main/currency.json")
    let session = URLSession.shared
        //closure
    let task = session.dataTask(with: url!) { data, response, error in
        if error != nil {
            let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            let okbutton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okbutton)
            self.present(alert, animated: true, completion: nil)
                
        }else{
            //2.
            if data != nil {
                do{
                    let jSonResponce = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String ,Any>
                    DispatchQueue.main.async {
                        if let rates = jSonResponce["rates"] as? [String : Any]{
                            //print(rates)
                            if let cad = rates["CAD"] as? Double {
                                self.cadLabel.text = "CAD: \(cad)"}
                            
                            if let usd = rates["USD"] as? Double {
                                self.usdLabel.text = "USD: \(usd)"}
                            
                            if let tr = rates["TRY"] as? Double {
                                self.trLabel.text = "TRY: \(tr)"}
                            
                            if let jpy = rates["JPY"] as? Double {
                                self.jpyLabel.text = "JPY: \(jpy)"}
                            
                            if let gbp = rates["gbp"] as? Double {
                                self.gbpLabel.text = "GBP: \(gbp)"}

                        }
                    }
                    
                    
                    
                }catch{
                    print("error!!")
                }
            }
            
        }
        }
        task.resume()
        
        
    }
    
    
    
    
    
}

