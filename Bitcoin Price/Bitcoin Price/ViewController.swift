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
    
    // MARK: Initialization
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://blockchain.info/ticker") {
            let task = URLSession.shared.dataTask(with: url) { dados, requisicao, erro in
                if erro == nil {
                    if let dadosRetorno = dados {
                        do {
                            if let objetoJson = try JSONSerialization.jsonObject(with: dadosRetorno, options: [])
                                as? [String: Any] {
                                if let brl = objetoJson["BRL"]  as? [String: Any]{
                                    if let preco = brl["buy"] as? Double {
                                        print(preco)
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
    // MARK: Actions
    
    // MARK: Methods
    
}

