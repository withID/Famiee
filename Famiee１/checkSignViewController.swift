//
//  checkSignViewController.swift
//  Famiee１
//
//  Created by taiki on 2019/03/23.
//  Copyright © 2019 高岸　憲伸. All rights reserved.
//

import UIKit
import EthereumKit
import CryptoSwift

class checkSignViewController: UIViewController {

    @IBOutlet var Cer: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let image = UserDefaults.standard.object(forKey: "box")
        Cer.image = UIImage(data: image as! Data)
        
        
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    @IBAction func Write(_ sender: Any) {
        
        let key = randomString(length: 16)
        let vi = randomString(length: 16)
        let mnemonic = Mnemonic.create(entropy: Data(hex: "044102030405060708090a0b0c0d0e0f"))
        
        let seed = try! Mnemonic.createSeed(mnemonic: mnemonic)
        
        let wallet: Wallet
        do {
            wallet = try Wallet(seed: seed, network: .ropsten, debugPrints: true)
        } catch let error {
            fatalError("Error: \(error.localizedDescription)")
        }
        
        
        let address = wallet.address()
        
        let configuration = Configuration(
            network: .ropsten,
            nodeEndpoint: "https://ropsten.infura.io/z1sEfnzz0LLMsdYMX4PV",
            etherscanAPIKey: "XE7QVJNVMKJT75ATEPY1HPWTPYCVCKMMJ7",
            debugPrints: true
        )
        
        let geth = Geth(configuration: configuration)
        
        
        geth.getBalance(of: address) { _ in }
        
        geth.getTransactionCount(of: address) { result in
            switch result {
            case .success(let nonce):
                let wei: BInt
                do {
                    wei = try Converter.toWei(ether: "0.00001")
                } catch let error {
                    fatalError("Error: \(error.localizedDescription)")
                }
                
                do {
                    
                    let aes = try AES(key: key, iv: vi)
                    print(key)
                    print(vi)
                    // aes128
                    let ciphertext = try aes.encrypt(Array("Nullam quis risus eget urna mollis ornare vel eu leo.".utf8))
                    print(ciphertext)
                    
                    let decrypt =  try aes.decrypt(ciphertext)
                    print("複合化したよ\(decrypt)")
                    
//                    print(Array("Nullam quis risus eget urna mollis ornare vel eu leo.".utf8))
                    let data = NSData(bytes: decrypt, length: decrypt.count)
                    let string = String(data: data as Data, encoding: .utf8)
                    print(string as Any)
                } catch { }
                //メッセージの内容
                let str = "☺️😛😇🤑😎"
                let data: Data? = str.data(using: .utf8)
                
                
                let rawTransaction = RawTransaction(wei: "100", to: address, gasPrice: Converter.toWei(GWei: 10), gasLimit: 121000, nonce: nonce, data: data!)
                
                let tx: String
                do {
                    tx = try wallet.sign(rawTransaction: rawTransaction)
                } catch let error {
                    fatalError("Error: \(error.localizedDescription)")
                }
                
                geth.sendRawTransaction(rawTransaction: tx) {result in
                    switch result {
                    case .success(let transaction):
                        print(transaction.id)
                    case .failure(_):
                        print("he")
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
    
    

