//
//  StringExtensions.swift
//  AMProject
//
//  Created by Jakub Kołodziej on 22/10/2018.
//  Copyright © 2018 Jakub Kołodziej. All rights reserved.
//

import Foundation

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}
