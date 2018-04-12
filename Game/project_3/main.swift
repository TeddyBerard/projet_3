//
//  main.swift
//  project_3
//
//  Created by Teddy Bérard on 10/04/2018.
//  Copyright © 2018 Teddy Bérard. All rights reserved.
//

import Foundation

func printArcade(line: String, term: Int, speed: UInt32) {
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
    printArcade(line: "Bienvenue à arena game !", term: 0, speed: 120000)
    sleep(2)
    printArcade(line: "Entre \"help\" si tu es perdu ou \"start\" pour démarer le jeu !", term: 0, speed: 120000)
    print("> ", terminator: "")
}

func help() { // help for user.
    printArcade(line: "Le principe est simple deux joueurs s'affronte dans une arêne, chaque joueur à 3 champions ", term: 0, speed: 120000)
    printArcade(line: "4 classes sont disponnible :", term: 0, speed: 120000)
    printClass()
    printArcade(line: "Après la selection des champions vous devrez battre l'équipe adverse en combats", term: 0, speed: 120000)
    print("")
}

func checkClass(line: String) -> Bool {
    let dicoClass = ["Combattant", "Mage", "Colosse", "Nain"]
    if dicoClass.contains(line) {
        return true
    }
    return false
}

func selectClass(line: String, perso: Perso) -> Perso {
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

func printClass() {
    printArcade(line: "- Combattant : Un guerrier", term: 0, speed: 0)
    printArcade(line: "- Mage : Un soigneur", term: 0, speed: 0)
    printArcade(line: "- Colosse : Un tank", term: 0, speed: 0)
    printArcade(line: "- Nain : Un nain furieux", term: 0, speed: 120000)
}

func fillChamp(nbr: Int, name: [String]) -> Perso {
    var champ1 = Perso()
    var verifName = 0
    while verifName == 0 {
        printArcade(line: "Choisie le nom de ton combatant n\(nbr): ", term: 1, speed: 120000)
        champ1.name = readLine()!
        if champ1.name != "" { verifName = 1}
        if name.contains(champ1.name!) {
            verifName = 0
            printArcade(line: "Nom de champion déjà selectionner", term: 0, speed: 120000)
        }
    }
    var check = false
    while check == false {
        printClass()
        printArcade(line: "Choisie sa classe : ", term: 1, speed: 120000)
        let line = readLine()!
        check = checkClass(line: line)
        if check == false { printArcade(line: "Veuillez choisir un classe définie !", term: 0, speed: 120000)
        } else {
            champ1 = selectClass(line: line, perso: champ1)
            break
        }
    }
    return champ1
}

func fillAndCompareTeam(nameChamp2: [String]) -> ([Perso], [String]) {
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

func printInfoTeam(joueur: Team) {
    var nbr = 0
    printArcade(line: "Les champions de l'équipe de \(joueur.name) sont :", term: 0, speed: 120000)
    while nbr != 3 {
        printArcade(line: "- \(String(describing: joueur.perso![nbr].name!)) est de type \(String(describing: joueur.perso![nbr].type!)) :", term: 0, speed: 120000)
        printArcade(line: "- \(String(describing: joueur.perso![nbr].life!)) point de vie", term: 0, speed: 120000)
        printArcade(line: "- \(String(describing: joueur.perso![nbr].dmg!)) point de dégats", term: 0, speed: 120000)
        nbr += 1
    }
}

func getEtatTeam(joueur: Team) -> Bool {
    var nbr = 0
    
    while nbr != 3 {
        if joueur.perso![nbr].life! <= 0 {
            return false
        }
        nbr += 1
    }
    return true
}

func printAliveChamp(champs: [Perso], joueur: Team) {
    var nbr = 0
    printArcade(line: "\(joueur.name) choisie ton champion : ", term: 0, speed: 120000)
    while nbr != champs.count {
        if champs[nbr].life! > 0 {
            printArcade(line: "- \(champs[nbr].name!)", term: 0, speed: 120000)
        }
        nbr += 1
    }
}

func launch() {
    var champTeam1 = [Perso]()
    var champTeam2 = [Perso]()
    var nameChamp = [String]()
    var nameChamp1 = [String]()
    var nameChamp2 = [String]()

    printArcade(line: "Joueur 1 entrez votre nom : ", term: 0, speed: 120000)
    print("> ", terminator: "")
    let team1 = Team.init(name: readLine()!)
    printArcade(line: "Bonjour \(team1.name) prépare ton équipe !", term: 0, speed: 120000)
    (champTeam1, nameChamp1) = fillAndCompareTeam(nameChamp2: nameChamp1)
    team1.perso = champTeam1
    printArcade(line: "L'équipe 1 as terminer la selection des champions !", term: 0, speed: 120000)
    sleep(2)
    printArcade(line: "Joueur 2 entrez votre nom :", term: 0, speed: 120000)
    print("> ", terminator: "")
    let team2 = Team.init(name: readLine()!)
    printArcade(line: "Bonjour \(team2.name) prépare ton équipe !", term: 0, speed: 120000)
    (champTeam2, nameChamp2) = fillAndCompareTeam(nameChamp2: nameChamp1)
    nameChamp = nameChamp1 + nameChamp2
    team2.perso = champTeam2
}

func combats(team1: Team, team2: Team, nameChamp: [String]) {
    while getEtatTeam(joueur: team1) != false || getEtatTeam(joueur: team2) != false {
        printInfoTeam(joueur: team2)
        printAliveChamp(champs: team1.perso!, joueur: team1)
        print("> ", terminator: "")
        let champSelected = readLine()
        printInfoTeam(joueur: team1)
        printAliveChamp(champs: team2.perso!, joueur: team2)
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
