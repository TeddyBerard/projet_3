//
//  Characternnage.swift
//  project_3
//
//  Created by Teddy Bérard on 10/04/2018.
//  Copyright © 2018 Teddy Bérard. All rights reserved.
//

import Foundation

class Character { // class for all champs
    var name: String = "" // name of champ
    var life: Int = 0 // this life
    var lifeMax: Int = 0 // max life of character
    var domages: Int = 0 // this domage
    var canHeal: Bool = false
    var weapon: (String, Int) = ("", 0)
}

class Magus : Character { // traduire
    override init() {
        super.init()
        self.canHeal = true
        self.domages = 20
        self.lifeMax = 75
        self.life = 75
        self.weapon = ("", 0)
    }
    
}

class Colossus : Character {
    override init() {
        super.init()
        self.domages = 7
        self.lifeMax = 130
        self.life = 130
        self.weapon = ("", 0)
    }
}

class Fighter : Character {
    override init() {
        super.init()
        self.domages = 10
        self.lifeMax = 100
        self.life = 100
        self.weapon = ("", 0)
    }
}

class Dwarf : Character {
    override init() {
        super.init()
        self.domages = 35
        self.lifeMax = 45
        self.life = 45
        self.weapon = ("", 0)
    }
}
