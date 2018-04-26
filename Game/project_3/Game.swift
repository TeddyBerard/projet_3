//
//  Game.swift
//  project_3
//
//  Created by Teddy Bérard on 16/04/2018.
//  Copyright © 2018 Teddy Bérard. All rights reserved.
//

import Foundation

class Game {
    private var players: [Team]
    private var nameChamp: [String]
    private var namePlayer: [String]
    private var ui: UIGame
    private var utils = Utils()
    private var fight = Fight()
    private var userResult: String
    private var numberPlayer: Int
    private var numberCharacter: Int
    private var weapon: [(String, Int)]
    
    init(uI: UIGame, weapon: [(String, Int)]) {
        self.players = []
        self.nameChamp = []
        self.namePlayer = []
        self.ui = uI
        self.userResult = ""
        self.numberPlayer = 2
        self.numberCharacter = 0
        self.weapon = weapon
    }
    
    func start(player1: Team, player2: Team) { // Start the game

        self.ui.printArcade(line: self.ui.start, term: 0)
        self.EnumPlayer() // set -> configuration
        if userResult != "Test" {
            self.EnumCharacter()
            initPlayer()
        } else {
            self.players.append(player1)
            self.players.append(player2)
        }
    }
    
    func initTestPlayer(player1: Team, NamePlayer: String, NameChamp1: String, NameChamp2: String) -> Team {
        let Champ1 = Dwarf()
        let Champ2 = Magus()
        player1.name = NamePlayer
        Champ1.name = NameChamp1
        Champ2.name = NameChamp2
        player1.character.append(Champ1)
        player1.character.append(Champ2)
        return player1
    }
    
    private func EnumPlayer() { // set the number of player
        while true {
            userResult = self.ui.prompt(line: self.ui.askNbPlayer)
            if userResult == "Test" { break }
            if self.utils.IsGoodnumberPlayer(line: self.userResult) == true {
                
                self.numberPlayer = Int(self.userResult)!
                self.userResult = ""
                break
            } else {
                self.ui.printArcade(line: self.ui.Nbrfalse, term: 0)
            }
        }
    }
    
    private func EnumCharacter() { // set the number of characters
        while true {
            userResult = self.ui.prompt(line: self.ui.asknumberCharacter)
            if self.utils.IsGoodnumberCharacter(line: self.userResult) == true {
                self.numberCharacter = Int(self.userResult)!
                self.userResult = ""
                break
            } else {
                self.ui.printArcade(line: self.ui.NbrCharacfalse, term: 0)
            }
        }
    }
    
    private func NameThePlayer(i: Int) -> String { // set the name of player and compare if does'nt exist
        var Name: String = ""
        while self.utils.IsGoodName(line: self.userResult, names: namePlayer) != true {
            userResult = self.ui.prompt(line: "Bonjour joueur \(i + 1) entre ton nom : ")
            if self.utils.IsGoodName(line: self.userResult, names: namePlayer) == false {
                self.ui.printArcade(line: self.ui.NameExist, term: 0)
            } else {
                self.namePlayer.append(self.userResult)
                Name = self.userResult
                self.userResult = ""
                break
            }
        }
        return Name
    }
    
    private func NameTheCharacter(i: Int, name: String) -> String { // set the name of character and compare if does'nt exist
        var Name: String = ""
        while self.utils.IsGoodName(line: self.userResult, names: self.nameChamp) != true {
            userResult = self.ui.prompt(line: "Bonjour \(name) entre le nom de ton champion numero \(i + 1): ")
            if self.utils.IsGoodName(line: self.userResult, names: nameChamp) == false {
                self.ui.printArcade(line: self.ui.NameExist, term: 0)
            } else {
                self.nameChamp.append(self.userResult)
                Name = self.userResult
                self.userResult = ""
                break
            }
        }
        return Name
    }
    
    
    private func selectClassCharacter() -> Character { // set the class of character
        let character = Character()
        while true {
            self.ui.printArcade(line: "Choisie ça classe : ", term: 0)
            self.ui.printArcade(line: "- Combattant / 1 : Un guerrier", term: 0)
            self.ui.printArcade(line: "- Mage / 2 : Un soigneur", term: 0)
            self.ui.printArcade(line: "- Colosse / 3 : Un tank", term: 0)
            self.ui.printArcade(line: "- Nain 4 : Un nain furieux", term: 0)
            userResult = self.ui.prompt(line: "")
            if self.utils.IsGoodClass(line:self.userResult) == false {
                self.ui.printArcade(line: self.ui.askClassCorrect, term: 0)
            } else {
                let myClass = self.userResult
                self.userResult = ""
                switch myClass  {
                        case "Combattant":
                            return Fighter()
                        case "1":
                            return Fighter()
                        case "Mage":
                            return Magus()
                        case "2":
                            return Magus()
                        case "Colosse":
                            return Colossus()
                        case "3":
                            return Colossus()
                        case "Nain":
                            return Dwarf()
                        case "4":
                            return Dwarf()
                        default:
                            return character
                }
            }
        }
    }
    
    private func NameCharacters(name: String) -> [Character] { // set the name and the class and add to array of characters [Character]
        var Characters = [Character]()
        for i in 0..<self.numberCharacter {
            var character = Character()
            let nameCharacter = self.NameTheCharacter(i: i, name: name)
            character = selectClassCharacter()
            character.name = nameCharacter
            Characters.append(character)
        }
        return Characters
    }
    
    private func initPlayer() { // set the name and the array of character
        for i in 0..<self.numberPlayer {
            let player = Team()
            player.name = self.NameThePlayer(i: i)
            player.character = self.NameCharacters(name: player.name)
            self.players.append(player)
        }
    }
    
    private func printInfoTeam(player: Team) { // print the information of any characters
        for i in 0..<player.character.count {
            if player.character[i].life > 0 {
                self.ui.printArcade(line: "\(player.character[i].name) : ", term: 0)
                self.ui.printArcade(line: "\(player.character[i].domages) points de dégats.", term: 0)
                self.ui.printArcade(line: "\(player.character[i].life) points de vie.", term: 0)
            } else {
                self.ui.printArcade(line: "\(player.character[i].name) est mort !", term: 0)
            }
            print("")
        }
    }
    
    private func printInfoAnotherPlayer(player: Team) { // print info for any team mate
        for allPlayers in  self.players {
            if allPlayers.name != player.name {
                printInfoTeam(player: allPlayers)
            }
        }
    }
    
    private func TargetCible(player: Team) { // print the available cible
        for i in 0..<self.players.count {
            if self.players[i].name != player.name {
                for nbr in 0..<self.players[i].character.count {
                    if self.players[i].character[nbr].life > 0 {
                        self.ui.printArcade(line: "\(self.players[i].name) : \(self.players[i].character[nbr].name) : \(self.players[i].character[nbr].life) / \(self.players[i].character[nbr].lifeMax)", term: 0)
                    }
                }
            }
        }
    }
    
    private func TargetCibleToHeal(player: Team) { // print the available heal cible
        for character in player.character {
            self.ui.printArcade(line: "\(character.name) : \(character.life) / \(character.lifeMax)", term: 0)
        }
    }
    
    private func selectGoodCible(player: Team, players: [Team], line: String) -> (Team, Int) { // select the cible
        for Allplayer in players {
            if Allplayer.name != player.name {
                for nbr in 0..<Allplayer.character.count {
                    if line == Allplayer.character[nbr].name && Allplayer.character[nbr].life > 0 {
                        return (Allplayer, nbr)
                    }
                }
            }
        }
        return (Team(), -1)
    }
    
    private func selectCible(player: Team, selected: Int) -> (Team, Int) { // set the cible and return this index first for the player and second to characters
        var i = Team()
        var nbr = -1
        while true {
            userResult = self.ui.prompt(line: self.ui.cible)
            (i, nbr) = selectGoodCible(player: player, players: players, line: userResult)
            if nbr != -1 {
                userResult = ""
                return (i, nbr)
            } else {
                TargetCible(player: player)
            }
        }
    }
    
    private func selectHeal(player: Team, characters: [Character], line: String) -> Int { // select the heal
        var i = 0
        for character in player.character {
            if character.life < character.lifeMax && character.life > 0 && line == character.name {
                return i
            }
            i = i + 1
        }
        return -1
    }
    
    private func canHeal(characters: [Character]) -> Bool {
        for i in 0..<characters.count {
            if characters[i].life < characters[i].lifeMax && characters[i].life > 0 {
                return true
            }
        }
        return false
    }
    
    
    private func selectCibleToHEal(player: Team, selected: Int) -> (Team, Int) { // set the heal cible and return this index first for the player and second to characters
        var i = 0
        while true {
            userResult = self.ui.prompt(line: self.ui.heal)
            if canHeal(characters: player.character) == true {
                i = selectHeal(player: player, characters: player.character, line: userResult)
                if i != -1 {
                    userResult = ""
                    return (player, i)
                } else {
                    self.TargetCibleToHeal(player: player)
                }
            } else {
                self.ui.printArcade(line: self.ui.heal, term: 0)
            }
        }
    }
    
    private func printMyCharacters(player: Team) { // print the avaible characters
        for character in player.character {
            if character.life > 0 {
                self.ui.printArcade(line: "- \(character.name)", term: 0)
            }
        }
    }
    
    private func TeamNeedHeal(player: Team, characters: [Character], selected: Int) -> Bool { // give if the team need heal
        if selected == -1 { return false }
        if characters[selected].canHeal == false {
            return true
        }
        for i in 0..<characters.count {
            if characters[i].life < characters[i].lifeMax && characters[i].life > 0 {
                return true
            }
        }
        return false
    }
    
    private func selectGoodCharacter(characters : [Character], line: String) -> Int { // select the character
        for i in 0..<characters.count {
            if line == characters[i].name && characters[i].life > 0 {
                return i
            }
        }
        return -1
    }
    
    private func chooseCharacter(player: Team) -> Int { // set the characters choose
        var selected = -1
        var Heal = false
        while selected == -1 {
            self.ui.printArcade(line: "\(player.name) \(self.ui.character)", term: 0)
            printMyCharacters(player: player)
            userResult = self.ui.prompt(line: "")
            selected = selectGoodCharacter(characters: player.character, line: userResult)
            Heal = TeamNeedHeal(player: player, characters: player.character, selected: selected)
            if selected != -1 && Heal == true {
                userResult = ""
                return selected
            } else {
                if Heal == false && selected != -1 {
                    self.ui.printArcade(line: self.ui.errorHeal, term: 0)
                } else {
                    self.ui.printArcade(line: self.ui.errorSelect, term: 0)
                }
            }
        }
        return -1
    }
    
    private func TakeWeapon(player: Team, selected: Int, domages: Int, name: String) { // action for take or not the weapon
        while true {
            userResult = self.ui.prompt(line: "Oui / Non")
            if userResult == "Oui" {
                self.ui.printArcade(line: "\(player.character[selected].name) prend l'arme", term: 0)
                player.character[selected].domages = player.character[selected].domages + domages
                player.character[selected].weapon = (name, domages)
                break
            } else if userResult == "Non" {
                self.ui.printArcade(line: "\(player.character[selected].name) ne prend pas l'arme", term: 0)
                break
            }
        }
    }
    
    private func SpawnWeapon(player: Team, selected: Int) { // condition for take a weapon
        let r = arc4random_uniform(10)
        if r > 7 {
            var name = ""
            var domages = 0
            self.ui.printArcade(line: self.ui.weaponSpawnAlert, term: 0)
            let random = Int(arc4random_uniform(UInt32(self.weapon.count)))
            (name, domages) = weapon[random]
            self.ui.printArcade(line: "\(player.character[selected].name) ouvre le coffre et \(name) apparaît voulez vous qu'il la prenne ? (Oui / Non)", term: 0)
            self.TakeWeapon(player: player, selected: selected, domages: domages, name: name)
        }
    }
    
    private func looseIfOnlyMage() { // The player loose if this team has only Mage
        for i in 0..<players.count {
            var m = 0
            for nbr in 0..<players[i].character.count {
                if players[i].character[nbr].canHeal == true || players[i].character[nbr].life <= 0 {
                    m += 1
                }
            }
            if m == players[i].character.count {
                self.ui.printArcade(line: "\(players[i].name) n'as plus d'attaquant !", term: 0)
                players[i].loose = true
            }
        }
        
    }
    
    private func IndexOfWinner(players: [Team]) -> Int { // get the winner
        for i in 0..<players.count {
            if players[i].loose == false {
                return i
            }
        }
        return -1
    }
    
    private func countAlivePlayer(players: [Team]) -> Bool { // count Alive player
        var Alive = 0
        for i in 0..<players.count {
            if players[i].loose == true {
                Alive += 1
            }
        }
        if Alive == 1 {
            return true
        }
        return false
    }
    
    func TheFight() { // The Fight
        while !countAlivePlayer(players: self.players) {
            for player in self.players {
                looseIfOnlyMage()
                if player.loose == false {
                    var m = Team()
                    var number = 0 // changer
                    var selected = -1
                    while selected == -1 {
                     selected = chooseCharacter(player: player)
                    }
                    self.SpawnWeapon(player: player, selected: selected)
                    self.printInfoAnotherPlayer(player: player)
                    if !player.character[selected].canHeal {
                        self.TargetCible(player: player) 
                        (m, number) = self.selectCible(player: player, selected: selected) // mettre dans combat
                    } else {
                        self.TargetCibleToHeal(player: player)
                        (m, number) = self.selectCibleToHEal(player: player, selected: selected)
                    }
                    self.fight.action(character: player.character[selected], cible: m.character[number], ui: self.ui)
                }
                player.AlivePlayer(player: players)
                if countAlivePlayer(players: players) { // count dans team
                    break
                }
            }
        }
        let winner = IndexOfWinner(players: players)
        self.ui.printArcade(line: "\(players[winner].name) à gagner 🎉🎉🎉", term: 0)
    }
}
