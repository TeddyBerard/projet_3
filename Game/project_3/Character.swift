//
//  personnage.swift
//  project_3
//
//  Created by Teddy Bérard on 10/04/2018.
//  Copyright © 2018 Teddy Bérard. All rights reserved.
//

import Foundation

class Perso { // class for all champs
    var name: String // name of champ
    var life: Int // this life
    var lifeMax: Int // max life of character
    var dmg: Int // this domage
    var canHeal: Bool
    var weapon: (String, Int)
    init() { // without init
        self.name = ""
        self.life = 0
        self.lifeMax = 0
        self.dmg = 0
        self.canHeal = false
        self.weapon = ("", 0)
    }
    
}

class Mage : Perso {
    override init() {
        super.init()
        self.canHeal = true
        self.dmg = 20
        self.lifeMax = 75
        self.life = 75
        self.name = ""
        self.weapon = ("", 0)
    }
    
}

class Colosse : Perso {
    override init() {
        super.init()
        self.dmg = 7
        self.lifeMax = 130
        self.life = 130
        self.name = ""
        self.weapon = ("", 0)
    }
}

class Combattant : Perso {
    override init() {
        super.init()
        self.dmg = 10
        self.lifeMax = 100
        self.life = 100
        self.name = ""
        self.weapon = ("", 0)
    }
}

class Nain : Perso {
    override init() {
        super.init()
        self.dmg = 35
        self.lifeMax = 45
        self.life = 45
        self.name = ""
        self.weapon = ("", 0)   
    }
}
