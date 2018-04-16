//
//  main.swift
//  project_3
//
//  Created by Teddy Bérard on 10/04/2018.
//  Copyright © 2018 Teddy Bérard. All rights reserved.
//

import Foundation

func printArcade(line: String, term: Int, speed: UInt32) { // print like zelda games
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

func start() { // print for start the game
    printArcade(line: "Bienvenue à arena game !", term: 0, speed: 0)
    sleep(2)
    printArcade(line: "Entre \"help\" si tu es perdu ou \"start\" pour démarer le jeu !", term: 0, speed: 0)
    print("> ", terminator: "")
}

func help() { // help for user.
    printArcade(line: "Le principe est simple deux joueurs s'affronte dans une arêne, chaque joueur à 3 champions ", term: 0, speed: 0)
    printArcade(line: "4 classes sont disponnible :", term: 0, speed: 0)
    printClass()
    printArcade(line: "Après la selection des champions vous devrez battre l'équipe adverse en combats", term: 0, speed: 0)
    print("")
}

func checkClass(line: String) -> Bool { // Check if the class exist
    let dicoClass = ["Combattant", "Mage", "Colosse", "Nain"]
    if dicoClass.contains(line) {
        return true
    }
    return false
}

func selectClass(line: String, perso: Perso) -> Perso { // init the stat for all class
    switch line {
    case "Combattant":
        perso.dmg = 10
        perso.life = 100
        perso.type = line
    case "Mage":
        perso.dmg = 17
        perso.life = 75
        perso.type = line
    case "Colosse":
        perso.dmg = 4
        perso.life = 175
        perso.type = line
    case "Nain":
        perso.dmg = 30
        perso.life = 45
        perso.type = line
    default:
        exit(84)
    }
    return perso
}

func printClass() { // print help class
    printArcade(line: "- Combattant : Un guerrier", term: 0, speed: 0)
    printArcade(line: "- Mage : Un soigneur", term: 0, speed: 0)
    printArcade(line: "- Colosse : Un tank", term: 0, speed: 0)
    printArcade(line: "- Nain : Un nain furieux", term: 0, speed: 0)
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
    var nbr = 0
    printArcade(line: "Les champions de l'équipe de \(joueur.name) sont :", term: 0, speed: 0)
    while nbr != 3 {
        printArcade(line: "- \(String(describing: joueur.perso![nbr].name!)) est de type \(String(describing: joueur.perso![nbr].type!)) :", term: 0, speed: 0)
        printArcade(line: "- \(String(describing: joueur.perso![nbr].life!)) point de vie", term: 0, speed: 0)
        printArcade(line: "- \(String(describing: joueur.perso![nbr].dmg!)) point de dégats", term: 0, speed: 0)
        print("")
        nbr += 1
    }
}

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

func getNameChamps(player: Team) -> [String] { // get the names of all champs
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

func heal(player: Team, champSelected: String) -> (String, Int) { // execute the heal action
    var nbr = 0
    var names = getNameChamps(player: player)
    var champCible: String = ""
    printArcade(line: "Veuillez selectionner votre champion dans le besoin !", term: 0, speed: 0)
    while nbr == 0 {
    print("> ", terminator: "")
        champCible = readLine()!
        if !names.contains(champCible) {
            printArcade(line: "Veuillez selectionner un champion vivant de votre équipe !", term: 0, speed: 0)
            for trn in 0..<names.count {
                printArcade(line: "\(names[trn])", term: 0, speed: 0)
            }
        } else {
            nbr = 1
        }
    }
    printArcade(line: "\(champSelected) à soigner \(champCible)", term: 0, speed: 0)
    return  (champCible, 0)
}

func attack(player: Team, champSelected: String) -> (String, Int) { // execute the attack action
    var nbr = 0
    var names = getNameChamps(player: player)
    var champCible: String = ""
    printArcade(line: "Veuillez selectionner le champion à attaquer !", term: 0, speed: 0)
    while nbr == 0 {
        print("> ", terminator: "")
        champCible = readLine()!
        if !names.contains(champCible) {
            printArcade(line: "Veuillez selectionner un champion vivant de l'équipe adverse !", term: 0, speed: 0)
            for trn in 0..<names.count {
                printArcade(line: "\(names[trn])", term: 0, speed: 0)
            }
        } else {
            nbr = 1
        }
    }
    printArcade(line: "\(champSelected) à attaquer \(champCible)", term: 0, speed: 0)
    return (champCible, 1)
}

func printAliveChamp(champs: [Perso], player: Team, enemi: Team, names: [String]) -> (Int, Int, Int) { // print alive champs
    var nbr = 0
    var act = 0
    printArcade(line: "\(player.name) choisie ton champion : ", term: 0, speed: 0)
    while nbr != champs.count {
        if champs[nbr].life! > 0 {
            printArcade(line: "- \(champs[nbr].name!)", term: 0, speed: 0)
        }
        nbr += 1
    }
    var champSelected : String = ""
    var champCible : String = ""
    var verifName = 0
    while verifName == 0 {
        print("> ", terminator: "")
        champSelected = readLine()!
        if names.contains(champSelected) {
            verifName = 1
        } else {
            printArcade(line: "Veuillez selectionner un champion existant !", term: 0, speed: 0)
        }
    }
    if getMage(nameOfChamp: champSelected, champs: player.perso!) == true {
        (champCible, act) = heal(player: player, champSelected: champSelected)
    } else {
        (champCible, act) = attack(player: enemi, champSelected: champSelected)
    }
    print("")
    print("select == \(getCible(team: player, name: champSelected)), cible ==\(getCible(team: enemi, name: champCible))")
    print("")
    return (getCible(team: player, name: champSelected), getCible(team: enemi, name: champCible), act)
}

func launch() { // start the game
    var champTeam1 = [Perso]()
    var champTeam2 = [Perso]()
    var nameChamp = [String]()
    var nameChamp1 = [String]()
    var nameChamp2 = [String]()

    printArcade(line: "Joueur 1 entrez votre nom : ", term: 0, speed: 0)
    print("> ", terminator: "")
    let team1 = Team.init(name: readLine()!)
    printArcade(line: "Bonjour \(team1.name) prépare ton équipe !", term: 0, speed: 0)
    (champTeam1, nameChamp1) = fillAndCompareTeam(nameChamp2: nameChamp1)
    team1.perso = champTeam1
    printArcade(line: "L'équipe 1 as terminer la selection des champions !", term: 0, speed: 0)
    sleep(2)
    printArcade(line: "Joueur 2 entrez votre nom :", term: 0, speed: 0)
    print("> ", terminator: "")
    let team2 = Team.init(name: readLine()!)
    printArcade(line: "Bonjour \(team2.name) prépare ton équipe !", term: 0, speed: 0)
    (champTeam2, nameChamp2) = fillAndCompareTeam(nameChamp2: nameChamp1)
    nameChamp = nameChamp1 + nameChamp2
    team2.perso = champTeam2
    combats(team1: team1, team2: team2, nameChamp: nameChamp)
}

func getCible(team: Team, name: String) -> Int {
    var nbr = 0
    while nbr < 3 {
        if team.perso?[nbr].name == name {
            return nbr
        }
        nbr += 1
    }
    return 0
}

func combats(team1: Team, team2: Team, nameChamp: [String]) { // get combats in game
    var champSelected: Int = 0
    var champCible: Int = 0
    var act: Int = 0
    while getEtatTeam(joueur: team1) != false || getEtatTeam(joueur: team2) != false {
        printInfoTeam(joueur: team2)
        (champSelected, champCible, act) = printAliveChamp(champs: team1.perso!, player: team1, enemi: team2, names: nameChamp)
        if act == 0 {
            team1.perso?[champCible].life = (team1.perso?[champCible].life)! + (team1.perso?[champSelected].dmg)!
        } else {
            team2.perso?[champCible].life = (team2.perso?[champCible].life)! - (team1.perso?[champSelected].dmg)!
            if (team2.perso?[champCible].life!)! <= 0 {
                printArcade(line: "\(team2.perso?[champCible].name! ?? "") est mort", term: 0, speed: 0)
            }
        }
        printInfoTeam(joueur: team1)
        (champSelected, champCible, act) = printAliveChamp(champs: team2.perso!, player: team2, enemi: team1, names: nameChamp)
        if act == 0 {
            team2.perso?[champCible].life = (team2.perso?[champCible].life)! + (team2.perso?[champSelected].dmg)!
        } else {
            team1.perso?[champCible].life = (team1.perso?[champCible].life)! - (team2.perso?[champSelected].dmg)!
            if (team1.perso?[champCible].life!)! <= 0 {
                printArcade(line: "\(team1.perso?[champCible].name ?? "") est mort", term: 0, speed: 0)
            }
        }
    }
}

start()
var line = readLine()

if line! == "help" {
    help()
} else if line! == "start" {
    launch()
} else {
    help()
    exit(84)
}
