//
//  main.swift
//  project_3
//
//  Created by Teddy Bérard on 10/04/2018.
//  Copyright © 2018 Teddy Bérard. All rights reserved.
//

import Foundation

var weapon = [("Azoth", 14), ("Parashu", 6), ("Gae bolga", 8), ("Les pommes d'Idunn", 12), ("Megingjord", 8)] // weapon for the game
var mygame = Game(uI: UIGame(), weapon: weapon)
var player1 = Team()
var player2 = Team()

player1 = mygame.initTestPlayer(player1: player1, NamePlayer: "Joueur 1", NameChamp1: "Drax", NameChamp2: "Kirby")
player2 = mygame.initTestPlayer(player1: player2, NamePlayer: "Joueur 2", NameChamp1: "Mario", NameChamp2: "Sonic")

mygame.start(player1: player1, player2: player2) // start the game
mygame.TheFight()
