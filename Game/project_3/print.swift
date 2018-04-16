//
//  print.swift
//  project_3
//
//  Created by Teddy Bérard on 16/04/2018.
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

func printClass() { // print help class
    printArcade(line: "- Combattant : Un guerrier", term: 0, speed: 0)
    printArcade(line: "- Mage : Un soigneur", term: 0, speed: 0)
    printArcade(line: "- Colosse : Un tank", term: 0, speed: 0)
    printArcade(line: "- Nain : Un nain furieux", term: 0, speed: 0)
}
