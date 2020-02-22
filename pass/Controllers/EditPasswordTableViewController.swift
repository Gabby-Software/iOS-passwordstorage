//
//  EditPasswordTableViewController.swift
//  pass
//
//  Created by Mingshen Sun on 12/2/2017.
//  Copyright © 2017 Bob Sun. All rights reserved.
//

import UIKit
import passKit

class EditPasswordTableViewController: PasswordEditorTableViewController {
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "saveEditPasswordSegue" {
            // check name
            guard checkName() else {
                return false
            }
        }
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "saveEditPasswordSegue" {
            let editedPlainText = plainText
            let (name, url) = getNameURL()
            if password!.plainText != editedPlainText || password!.url.path != url.path {
                password!.updatePassword(name: name, url: url, plainText: editedPlainText)
            }
        }
    }
}
