//
//  ViewController.swift
//  Bitcoin Price
//
//  Created by Pedro Léda on 17/09/21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Properties
    
    
    // MARK: Outlets
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var buttonUpdate: UIButton!
    
    // MARK: Initialization
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //        self.getBitcoinPrice()
    }
    // MARK: Actions
    @IBAction func updatePrice(_ sender: Any) {
        self.getBitcoinPrice()
    }
    
    // MARK: Methods
    private func priceFormatter(price: NSNumber) -> String{
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.locale = Locale(identifier: "pt_BR")
        
        if let finalPrice = nf.string(from: price) {
            return finalPrice
        }
        return "0,00"
    }
    
    private func getBitcoinPrice() {
        
        self.buttonUpdate.setTitle("Atualizando...", for: .normal)
        
        if let url = URL(string: "https://blockchain.info/ticker") {
            let task = URLSession.shared.dataTask(with: url) { dados, requisicao, erro in
                if erro == nil {
                    if let dadosRetorno = dados {
                        do {
                            if let objetoJson = try JSONSerialization.jsonObject(with: dadosRetorno, options: [])
                                as? [String: Any] {
                                if let brl = objetoJson["BRL"]  as? [String: Any]{
                                    if let preco = brl["buy"] as? Double {
                                        let formattedPrice = self.priceFormatter(price: NSNumber(value: preco))
                                        
                                        DispatchQueue.main.async(execute: {
                                            self.labelPrice.text = "R$ \(formattedPrice)"
                                            self.buttonUpdate.setTitle("Atualizar", for: .normal)
                                        })
                                    }
                                }
                            }
                        } catch {
                            print("Error :(")
                        }
                    }
                } else {
                    print("Error :(")
                }
            }
            task.resume()
        }
    }
    
    private func setupUI() {
        setupButton()
    }
    
    private func setupButton() {
        buttonUpdate.layer.cornerRadius = 15
        buttonUpdate.clipsToBounds = true
    }
}

