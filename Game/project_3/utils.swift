//
//  utils.swift
//  project_3
//
//  Created by Teddy Bérard on 16/04/2018.
//  Copyright © 2018 Teddy Bérard. All rights reserved.
//

import Foundation

// MARK: - Comparateur

func checkClass(line: String) -> Bool { // Check if the class exist
    let dicoClass = ["Combattant", "Mage", "Colosse", "Nain"]
    if dicoClass.contains(line) {
        return true
    }
    return false
}

func fillChamp(nbr: Int, name: [String]) -> Perso { // check if the user enter a good name
    var champ1 = Perso()
    var verifName = 0
    while verifName == 0 {
        printArcade(line: "Choisie le nom de ton combatant n\(nbr): ", term: 1, speed: 0)
        champ1.name = readLine()!
        if champ1.name != "" { verifName = 1}
        if name.contains(champ1.name!) {
            verifName = 0
            printArcade(line: "Nom de champion déjà selectionner", term: 0, speed: 0)
        }
    }
    var check = false
    while check == false {
        printClass()
        printArcade(line: "Choisie sa classe : ", term: 1, speed: 0)
        let line = readLine()!
        check = checkClass(line: line)
        if check == false { printArcade(line: "Veuillez choisir une classe définie !", term: 0, speed: 0)
        } else {
            champ1 = selectClass(line: line, perso: champ1)
            break
        }
    }
    return champ1
}

func selectClass(line: String, perso: Perso) -> Perso { // init the stat for all class
    switch line {
    case "Combattant":
        perso.dmg = 10
        perso.life = 100
        perso.lifeMax = 100
        perso.type = line
    case "Mage":
        perso.dmg = 17
        perso.life = 75
        perso.lifeMax = 75
        perso.type = line
    case "Colosse":
        perso.dmg = 4
        perso.life = 175
        perso.lifeMax = 175
        perso.type = line
    case "Nain":
        perso.dmg = 30
        perso.life = 45
        perso.lifeMax = 45
        perso.type = line
    default:
        exit(84)
    }
    return perso
}

func fillAndCompareTeam(nameChamp2: [String]) -> ([Perso], [String]) { // compare if all champ does'nt have the same name
    var champTeam1 = [Perso]()
    var nameChamp = nameChamp2
    
    champTeam1.append(fillChamp(nbr: 1, name: nameChamp))
    nameChamp.append(champTeam1[0].name!)
    champTeam1.append(fillChamp(nbr: 2, name: nameChamp))
    nameChamp.append(champTeam1[1].name!)
    champTeam1.append(fillChamp(nbr: 3, name: nameChamp))
    nameChamp.append(champTeam1[2].name!)
    return (champTeam1, nameChamp)
}

func printInfoTeam(joueur: Team) { // print the stat of all champ user's
    printArcade(line: "Les champions de l'équipe de \(joueur.name) sont :", term: 0, speed: 0)
    for nbr in 0..<3 {
        printArcade(line: "- \(String(describing: joueur.perso![nbr].name!)) est de type \(String(describing: joueur.perso![nbr].type!)) :", term: 0, speed: 0)
        printArcade(line: "- \(String(describing: joueur.perso![nbr].life!)) point de vie", term: 0, speed: 0)
        printArcade(line: "- \(String(describing: joueur.perso![nbr].dmg!)) point de dégats", term: 0, speed: 0)
        print("")
    }
}

// MARK: - Getteur

func getEtatTeam(joueur: Team) -> Bool { // get if the team have loose
    var nbr = 0
    
    while nbr != 3 {
        if joueur.perso![nbr].life! <= 0 {
            return false
        }
        nbr += 1
    }
    return true
}

func getMage(nameOfChamp: String, champs: [Perso]) -> Bool { // get type mage
    for nbr in 0..<champs.count {
        if champs[nbr].type == "Mage" && champs[nbr].name == nameOfChamp {
            return true
        }
    }
    return false
}

func getNameChamps(player: Team) -> [String] { // get the name of characters
    var nbr = 0
    var names = [String]()
    while nbr != player.perso?.count {
        if (player.perso?[nbr].life)! > 0 {
            names.append((player.perso?[nbr].name)!)
        }
        nbr += 1
    }
    return names
}
