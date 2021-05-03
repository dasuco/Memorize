//
//  Array+Only.swift
//  Memorize
//
//  Created by Sucias Colomer, David on 14/04/2021.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
