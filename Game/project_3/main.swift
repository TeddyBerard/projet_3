//
//  main.swift
//  project_3
//
//  Created by Teddy Bérard on 10/04/2018.
//  Copyright © 2018 Teddy Bérard. All rights reserved.
//

import Foundation

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
