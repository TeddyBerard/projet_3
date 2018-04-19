//
//  combat.swift
//  project_3
//
//  Created by Teddy Bérard on 16/04/2018.
//  Copyright © 2018 Teddy Bérard. All rights reserved.
//

import Foundation

class Combats {
    
    var weapon = [("Azoth", 14), ("Parashu", 6), ("Gae bolga", 8)]
    var weaponHeal = [("Les pommes d'Idunn", 12), ("Megingjord", 8)]
    
    func action(Character: Perso, Cible: Perso, ui: UIGame) {
        if Character.canHeal == true {
            heal(Character: Character, Cible: Cible)
            ui.printArcade(line: "\(Character.name) à soigner \(Cible.name)", term: 0)
        } else {
            attack(Character: Character, Cible: Cible)
            ui.printArcade(line: "\(Character.name) à attaquer \(Cible.name)", term: 0)
        }
    }
    
    func attack(Character: Perso, Cible: Perso) { // attack the cible
        Cible.life = Cible.life - Character.dmg
        
    }
    
    func heal(Character: Perso, Cible: Perso) { // heal the cible
        Cible.life = Cible.life + Character.dmg
        if Cible.life > Cible.lifeMax {
            Cible.life = Cible.lifeMax
        }
    }
}
