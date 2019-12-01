//
//  DefaultKeys.swift
//  pass
//
//  Created by Mingshen Sun on 21/1/2017.
//  Copyright © 2017 Bob Sun. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

public var SharedDefaults = UserDefaults(suiteName: Globals.groupIdentifier)!

public enum GitAuthenticationMethod: String, DefaultsSerializable {
    case password, key
}

public enum GitSSHKeySource: String, DefaultsSerializable {
    case file, armor, url
}

public extension DefaultsKeys {
    static let pgpKeySource = DefaultsKey<String?>("pgpKeySource")
    static let pgpPublicKeyURL = DefaultsKey<URL?>("pgpPublicKeyURL")
    static let pgpPrivateKeyURL = DefaultsKey<URL?>("pgpPrivateKeyURL")

    // Keep them for legacy reasons.
    static let pgpPublicKeyArmor = DefaultsKey<String?>("pgpPublicKeyArmor")
    static let pgpPrivateKeyArmor = DefaultsKey<String?>("pgpPrivateKeyArmor")
    static let gitSSHPrivateKeyArmor = DefaultsKey<String?>("gitSSHPrivateKeyArmor")
    static let passcodeKey = DefaultsKey<String?>("passcodeKey")

    static let gitURL = DefaultsKey<URL>("gitURL", defaultValue: URL(string: "https://")!)
    static let gitAuthenticationMethod = DefaultsKey<GitAuthenticationMethod>("gitAuthenticationMethod", defaultValue: GitAuthenticationMethod.password)
    static let gitUsername = DefaultsKey<String>("gitUsername", defaultValue: "git")
    static let gitBranchName = DefaultsKey<String>("gitBranchName", defaultValue: "master")
    static let gitSSHPrivateKeyURL = DefaultsKey<URL?>("gitSSHPrivateKeyURL")
    static let gitSSHKeySource = DefaultsKey<GitSSHKeySource?>("gitSSHKeySource")
    static let gitSignatureName = DefaultsKey<String?>("gitSignatureName")
    static let gitSignatureEmail = DefaultsKey<String?>("gitSignatureEmail")

    static let lastSyncedTime = DefaultsKey<Date?>("lastSyncedTime")

    static let isTouchIDOn = DefaultsKey<Bool>("isTouchIDOn", defaultValue: false)

    static let isHideUnknownOn = DefaultsKey<Bool>("isHideUnknownOn", defaultValue: false)
    static let isHideOTPOn = DefaultsKey<Bool>("isHideOTPOn", defaultValue: false)
    static let isRememberPGPPassphraseOn = DefaultsKey<Bool>("isRememberPGPPassphraseOn", defaultValue: false)
    static let isRememberGitCredentialPassphraseOn = DefaultsKey<Bool>("isRememberGitCredentialPassphraseOn", defaultValue: false)
    static let isShowFolderOn = DefaultsKey<Bool>("isShowFolderOn", defaultValue: true)
    static let isHidePasswordImagesOn = DefaultsKey<Bool>("isHidePasswordImagesOn", defaultValue: false)
    static let searchDefault = DefaultsKey<SearchBarScope?>("searchDefault", defaultValue: .all)
    static let passwordGeneratorFlavor = DefaultsKey<String>("passwordGeneratorFlavor", defaultValue: "Apple")

    static let encryptInArmored = DefaultsKey<Bool>("encryptInArmored", defaultValue: false)
}
