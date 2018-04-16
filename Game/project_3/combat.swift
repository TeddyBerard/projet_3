//
//  combat.swift
//  project_3
//
//  Created by Teddy Bérard on 16/04/2018.
//  Copyright © 2018 Teddy Bérard. All rights reserved.
//

import Foundation

func getCible(team: Team, name: String) -> Int { // return the index of champ cibled
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
            if (team1.perso?[champCible].life)! > 0 {
                if (team1.perso?[champCible].life)! + (team1.perso?[champSelected].dmg)! > (team1.perso?[champCible].lifeMax)! {
                    team1.perso?[champCible].life! = (team1.perso?[champCible].lifeMax!)!
                } else {
                    team1.perso?[champCible].life = (team1.perso?[champCible].life)! + (team1.perso?[champSelected].dmg)!
                }
            }
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
