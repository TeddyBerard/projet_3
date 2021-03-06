//
//  print.swift
//  project_3
//
//  Created by Teddy Bérard on 16/04/2018.
//  Copyright © 2018 Teddy Bérard. All rights reserved.
//

import Foundation

class UIGame {
    var start = "------------------------------\nBienvenue dans arena game !\n------------------------------"
    var askNbPlayer = "Entrez le nombre de joueurs"
    var Nbrfalse = "Entrer un nombre de joueurs correcte"
    var NbrCharacfalse = "Entrer un nombre de champion correcte"
    var NameExist = "Nom incorrecte entre un autre nom "
    var promt = "> "
    var asknumberCharacter = "Choisissez le nombre de champions jouable !"
    var askClassCorrect  = "Choisie une classe jouable"
    var cible = "Choisissez une cible :"
    var heal = "Choisissez un champion à soigner :"
    var character = "Choisissez votre champion :"
    var errSelectCharacter = "Choisissez un champion de votre équipe"
    var errorHeal = "Votre équipe ne peux pas être soigner"
    var errorSelect = "Aucun de vos champions ne correspond"
    var weaponSpawnAlert = "Une arme apparaît !"

    
    func printArcade(line: String, term: Int, speed: UInt32 = 120000) { // print like zelda games
        var nbr = 0
        var sub: String?
        while nbr != line.count {
            let cha = line.index(line.startIndex, offsetBy: nbr)
            sub = String(line[cha])
            usleep(speed)
            nbr += 1
            print(sub ?? "MDR", terminator: "")
        }
        if term == 0 {print("")}
    }
    
    func prompt(line: String) -> String { // print the prompt and get the command of player
        printArcade(line: line, term: 0, speed: 0)
        printArcade(line: promt, term: 1, speed: 0)
        return readLine()!
    }
}
