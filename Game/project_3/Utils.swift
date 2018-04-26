//
//  utils.swift
//  project_3
//
//  Created by Teddy Bérard on 16/04/2018.
//  Copyright © 2018 Teddy Bérard. All rights reserved.
//

import Foundation

class Utils {
    var Class = ["1", "Combattant", "2", "Mage", "3", "Colosse", "4", "Nain"]
    
    func IsGoodnumberPlayer(line: String) -> Bool { // check if the result is a good number
        let num = Int(line)
        return line.isEmpty && num == nil && num == 0 && num == 1
    }
    
    func IsGoodnumberCharacter(line: String) -> Bool { // check if the result is a good number
        let num = Int(line)
        if line.isEmpty || num == nil || num == 0 {
            return false
        }
        return true
    }
    
    func IsGoodName(line: String, names: [String]) -> Bool { // compare if the name exist
        if line.isEmpty || line == "" || names.contains(line) {
            return false
        }
        return true
    }
    
    func IsGoodClass(line: String) -> Bool { // compare if the class exist
        if line.isEmpty || line == "" || !self.Class.contains(line) {
            print(self.Class)
            print(line)
            return false
        }
        return true
    }
    
    
}
