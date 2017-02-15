//
//  PGPKeySettingTableViewController.swift
//  pass
//
//  Created by Mingshen Sun on 21/1/2017.
//  Copyright © 2017 Bob Sun. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class PGPKeySettingTableViewController: UITableViewController {

    @IBOutlet weak var pgpPublicKeyURLTextField: UITextField!
    @IBOutlet weak var pgpPrivateKeyURLTextField: UITextField!
    @IBOutlet weak var pgpKeyPassphraseTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pgpPublicKeyURLTextField.text = Defaults[.pgpPublicKeyURL]?.absoluteString
        pgpPrivateKeyURLTextField.text = Defaults[.pgpPrivateKeyURL]?.absoluteString
        pgpKeyPassphraseTextField.text = Defaults[.pgpKeyPassphrase]
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "savePGPKeySegue" {
            guard pgpPublicKeyURLTextField.text != nil else {
                return false
            }
            guard pgpPrivateKeyURLTextField.text != nil else {
                return false
            }
            
            guard URL(string: pgpPublicKeyURLTextField.text!) != nil else {
                let alertMessage = "Please set Public Key URL first."
                let alert = UIAlertController(title: "Cannot Save", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            }
            guard URL(string: pgpPrivateKeyURLTextField.text!) != nil else {
                let alertMessage = "Please set Private Key URL first."
                let alert = UIAlertController(title: "Cannot Save", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            }
            
            if URL(string: pgpPublicKeyURLTextField.text!)!.scheme! == "http" &&
                URL(string: pgpPrivateKeyURLTextField.text!)!.scheme! == "http" {
                let alertMessage = "HTTP connection is not supported."
                let alert = UIAlertController(title: "Cannot Save Settings", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
}
