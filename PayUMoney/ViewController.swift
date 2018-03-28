//
//  ViewController.swift
//  PayUMoney
//
//  Created by OmniproEdge on 22/03/18.
//  Copyright © 2018 karpomkarpipoom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum TestPayment : String {
        
        case merchantID     = "396132"
        case merchantkey    = "40747T"
        case baseURL        = "https://test.payu.in"
        case salt           = "cJHb2BC9"
        
    }
    
    let testParam : PUMTxnParam = PUMTxnParam()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        testParam.amount = "100"
        testParam.email = "bala@yopmail.com"
        testParam.firstname = "bala"
        testParam.txnID = "ga7di6ft8qwasd"
        testParam.phone = "8148222948"
        testParam.furl = "https://www.payumoney.com/mobileapp/payumoney/failure.php"
        testParam.surl = "https://www.payumoney.com/mobileapp/payumoney/success.php"
        testParam.productInfo = "iphone X"
        testParam.environment = .test
        
        testParam.key = TestPayment.merchantkey.rawValue
        testParam.merchantid = TestPayment.merchantID.rawValue
        
        testParam.udf1 = ""
        testParam.udf2 = ""
        testParam.udf3 = ""
        testParam.udf4 = ""
        testParam.udf5 = ""
        testParam.udf6 = ""
        testParam.udf7 = ""
        testParam.udf8 = ""
        testParam.udf9 = ""
        testParam.udf10 = ""
        
        let hashValue = String.localizedStringWithFormat("%@|%@|%@|%@|%@|%@|||||||||||%@",TestPayment.merchantkey.rawValue,testParam.txnID!,testParam.amount!,testParam.productInfo!,testParam.firstname!,testParam.email!,TestPayment.salt.rawValue)

        
        testParam.hashValue = hashValue.sha512()      // need to convert sha
        
        PlugNPlay.presentPaymentViewController(withTxnParams: testParam, on: self) { (responce, error, otherParam) in
            print(responce as Any)
            print("---------------------------------------------")
            print(error as Any)
            print("---------------------------------------------")
            print(otherParam as Any)

        }
    }


}

extension String {
    
    func sha512() -> String {
        let data = self.data(using: .utf8)!
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        data.withUnsafeBytes({
            _ = CC_SHA512($0, CC_LONG(data.count), &digest)
        })
        return digest.map({ String(format: "%02hhx", $0) }).joined(separator: "")
    }
    
}
