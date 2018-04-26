//
//  combat.swift
//  project_3
//
//  Created by Teddy Bérard on 16/04/2018.
//  Copyright © 2018 Teddy Bérard. All rights reserved.
//

import Foundation

class Fight {
    func action(character: Character, cible: Character, ui: UIGame) {
        if character.canHeal == true {
            heal(character: character, cible: cible)
            ui.printArcade(line: "\(character.name) à soigner \(cible.name)", term: 0)
        } else {
            attack(character: character, cible: cible)
            ui.printArcade(line: "\(character.name) à attaquer \(cible.name)", term: 0)
        }
    }
    
    func attack(character: Character, cible: Character) { // attack the cible
        cible.life = cible.life - character.domages
        if cible.life < 0 {
            cible.life = 0
        }
    }
    
    func heal(character: Character, cible: Character) { // heal the cible
        cible.life = cible.life + character.domages
        if cible.life > cible.lifeMax {
            cible.life = cible.lifeMax
        }
    }
}
