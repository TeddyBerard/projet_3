//
//  main.swift
//  project_3
//
//  Created by Teddy Bérard on 10/04/2018.
//  Copyright © 2018 Teddy Bérard. All rights reserved.
//

import Foundation

func start() { // print for start the game
    print("Bienvenue à arena game")
    sleep(2)
    print("Entre \"help\" si tu as besoin d'aide ou \"start\" pour démarer le jeu !")
    print("> ", terminator: "")
}

func help() { // help for user.
    print("Le principe est simple deux joueurs s'affronte dans une arêne, chaque joueur à 3 champions ")
    print("4 classes sont disponnible :")
    printClass()
    print("Après la selection des champions vous devrez battre l'équipe adverse en combats")
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
    print("- Combattant : Un guerrier")
    print("- Mage : Un soigneur")
    print("- Colosse : Un tank")
    print("- Nain : Un nain furieux")
}

func fillChamp(nbr: Int) -> Perso {
    var champ1 = Perso()
    print("Choisie le nom de ton combatant n\(nbr): ", terminator: "")
    champ1.name = readLine()!
    var check = false
    while check == false {
        printClass()
        print("Choisie sa classe : ", terminator: "")
        let line = readLine()!
        check = checkClass(line: line)
        if check == false { print("Veuillez choisir un classe définie !")
        } else {
            champ1 = selectClass(line: line, perso: champ1)
            break
        }
    }
    return champ1
}

func launch() {
    var champTeam1 = [Perso]()
    var champTeam2 = [Perso]()
    print("Joueur 1 entrez votre nom : ")
    print("> ", terminator: "")
    let team1 = Team.init(name: readLine()!)
    print("Bonjour \(team1.name) prépare ton équipe !")
    champTeam1.append(fillChamp(nbr: 1))
    champTeam1.append(fillChamp(nbr: 2))
    champTeam1.append(fillChamp(nbr: 3))
    team1.perso = champTeam1
    print("L'équipe 1 as terminer la selection des champions !")
    sleep(2)
    print("Joueur 2 entrez votre nom :")
    print("> ", terminator: "")
    let team2 = Team.init(name: readLine()!)
    print("Bonjour \(team2.name) prépare ton équipe !")
    champTeam2.append(fillChamp(nbr: 1))
    champTeam2.append(fillChamp(nbr: 2))
    champTeam2.append(fillChamp(nbr: 3))
    team2.perso = champTeam2
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
