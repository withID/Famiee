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
    var firstName = UserDefaults.standard.object(forKey: "Name") as! String
    var firstMessage = UserDefaults.standard.object(forKey: "Message") as! String
    var secoundName = UserDefaults.standard.object(forKey: "Name2Text") as! String
    var secoundMessage = UserDefaults.standard.object(forKey: "Message2") as! String
    var ciphertext = Array<UInt8>()
    
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
        let vi = "abcdefghijklmnop"
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
                    self.ciphertext = try aes.encrypt(Array("\(self.firstName)と\(self.secoundName)は、以下の誓いのものとにカップルであることを誓いました。\(self.firstMessage),\(self.secoundMessage)".utf8))
                    print(self.ciphertext)
                    
                    let decrypt =  try aes.decrypt(self.ciphertext)
                    print("複合化したよ\(decrypt)")
                    
//                    print(Array("Nullam quis risus eget urna mollis ornare vel eu leo.".utf8))
                    let data = NSData(bytes: decrypt, length: decrypt.count)
                    let string = String(data: data as Data, encoding: .utf8)
                    print(string as Any)
                    UserDefaults.standard.set(key, forKey: "key")
                } catch { }
                //メッセージの内容
                let cipher = "\(self.ciphertext)"
                print(cipher)
                let data: Data? =  cipher.data(using: .utf8)
                print(data)
                
                if UserDefaults.standard.object(forKey: "check") as! String == "" {
                    
                }else{
                    
                }
                
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
                        UserDefaults.standard.set(transaction.id, forKey: "TxID")
                    case .failure(_):
                        print("トランザクションを遅れていない")
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
    
    

