//
//  Game.swift
//  project_3
//
//  Created by Teddy Bérard on 16/04/2018.
//  Copyright © 2018 Teddy Bérard. All rights reserved.
//

import Foundation

class Game {
    var players: [Team]
    var nameChamp: [String]
    var namePlayer: [String]
    var ui: UIGame
    var utils: Utils
    var combat: Combats
    var UserRes: String
    var nbrPlayer: Int
    var nbrCharacter: Int
    
    func start() { // Start the game
        self.ui.printArcade(line: self.ui.start, term: 0)
        sleep(2)
        self.ui.printArcade(line: self.ui.askNbPlayer, term: 0)
        self.setNbrPlayer()
        self.setNbrCharacter()
        initPlayer()
        self.combats()
    }
    
    func setNbrPlayer() { // set the number of player
        while 0 == 0 {
            self.prompt()
            if self.utils.checkNbrPlayer(line: self.UserRes) == true {
                self.nbrPlayer = Int(self.UserRes)!
                self.UserRes = ""
                break
            } else {
                self.ui.printArcade(line: self.ui.Nbrfalse, term: 0)
            }
        }
    }
    
    func setNbrCharacter() { // set the number of characters
        self.ui.printArcade(line: self.ui.askNbrCharacter, term: 0)
        while 0 == 0 {
            self.prompt()
            if self.utils.checkNbrCharacter(line: self.UserRes) == true {
                self.nbrCharacter = Int(self.UserRes)!
                self.UserRes = ""
                break
            } else {
                self.ui.printArcade(line: self.ui.NbrCharacfalse, term: 0)
            }
        }
    }
    
    func setNamePlayer() -> String { // set the name of player and compare if does'nt exist
        var Name: String = ""
        while self.utils.checkNameExist(line: self.UserRes, names: namePlayer) != true {
            self.prompt()
            if self.utils.checkNameExist(line: self.UserRes, names: namePlayer) == false {
                self.ui.printArcade(line: self.ui.NameExist, term: 0)
            } else {
                self.namePlayer.append(self.UserRes)
                Name = self.UserRes
                self.UserRes = ""
                break
            }
        }
        return Name
    }
    
    func setNameCharacters() -> String { // set the name of character and compare if does'nt exist
        var Name: String = ""
        while self.utils.checkNameExist(line: self.UserRes, names: self.nameChamp) != true {
            self.prompt()
            if self.utils.checkNameExist(line: self.UserRes, names: nameChamp) == false {
                self.ui.printArcade(line: self.ui.NameExist, term: 0)
            } else {
                self.nameChamp.append(self.UserRes)
                Name = self.UserRes
                self.UserRes = ""
                break
            }
        }
        return Name
    }
    
    
    func setClassCharacter() -> Perso { // set the class of character
        let character = Perso()
        while 0 == 0 {
            self.ui.printArcade(line: "Choisie ça classe : ", term: 0)
            self.ui.printArcade(line: "- Combattant / 1 : Un guerrier", term: 0)
            self.ui.printArcade(line: "- Mage / 2 : Un soigneur", term: 0)
            self.ui.printArcade(line: "- Colosse / 3 : Un tank", term: 0)
            self.ui.printArcade(line: "- Nain 4 : Un nain furieux", term: 0)
            prompt()
            if self.utils.checkClass(line:self.UserRes) == false {
                self.ui.printArcade(line: self.ui.askClassCorrect, term: 0)
            } else {
                let myClass = self.UserRes
                self.UserRes = ""
                switch myClass  {
                        case "Combattant":
                            return Combattant()
                        case "1":
                            return Combattant()
                        case "Mage":
                            return Mage()
                        case "2":
                            return Mage()
                        case "Colosse":
                            return Colosse()
                        case "3":
                            return Colosse()
                        case "Nain":
                            return Nain()
                        case "4":
                            return Nain()
                        default:
                            return character
                }
            }
        }
    }
    
    func setCharacters(Name: String) -> [Perso] { // set the name and the class and add to array of characters [Perso]
        var Characters = [Perso]()
        for i in 0..<self.nbrCharacter {
            var character = Perso()
            self.ui.printArcade(line: "Bonjour \(Name) entre le nom de ton champion numero \(i + 1): ", term: 0)
            let name = self.setNameCharacters()
            character = setClassCharacter()
            character.name = name
            Characters.append(character)
        }
        return Characters
    }
    
    func initPlayer() { // set the name and the array of character
        for i in 0..<self.nbrPlayer {
            let player = Team()
            self.ui.printArcade(line: "Bonjour joueur \(i + 1) entre ton nom : ", term: 0)
            player.name = self.setNamePlayer()
            player.perso = self.setCharacters(Name: player.name)
            self.players.append(player)
        }
    }
    
    func printInfoTeam(Player: Team) { // print the information of any characters
        for i in 0..<Player.perso.count {
            if Player.perso[i].life > 0 {
                self.ui.printArcade(line: "\(Player.perso[i].name) : ", term: 0)
                self.ui.printArcade(line: "\(Player.perso[i].dmg) points de dégats.", term: 0)
                self.ui.printArcade(line: "\(Player.perso[i].life) points de vie.", term: 0)
            } else {
                self.ui.printArcade(line: "\(Player.perso[i].name) est mort !", term: 0)
            }
            print("")
        }
    }
    
    func printInfoAnotherPlayer(player: Int) { // print info for any team mate
        for i in 0..<self.players.count {
            if i != player {
                printInfoTeam(Player: self.players[i])
            }
        }
    }
    
    func getCible(player: Int) { // print the available cible
        for i in 0..<self.players.count {
            if i != player {
                for nbr in 0..<self.players[i].perso.count {
                    if self.players[i].perso[nbr].life > 0 {
                        self.ui.printArcade(line: "\(self.players[i].name) : \(self.players[i].perso[nbr].name) : \(self.players[i].perso[nbr].life) / \(self.players[i].perso[nbr].lifeMax)", term: 0)
                    }
                }
            }
        }
    }
    
    func getCibleToHeal(player: Int) { // print the available heal cible
        for i in 0..<self.players[player].perso.count {
            self.ui.printArcade(line: "\(self.players[player].perso[i].name) : \(self.players[player].perso[i].life) / \(self.players[player].perso[i].lifeMax)", term: 0)
        }
    }
    
    func selectCible(player: Int, Selected: Int) -> (Int, Int) { // set the cible and return this index first for the player and second to characters
        var i = -1
        var nbr = -1
        while 0 == 0 {
            self.ui.printArcade(line: self.ui.cible, term: 0)
            prompt()
            (i, nbr) = utils.selectGoodCible(Player: player, Players: players, line: UserRes)
            if (i, nbr) != (-1, -1) {
                UserRes = ""
                return (i, nbr)
            } else {
                getCible(player: player)
            }
        }
    }
    
    
    func selectCibleToHEal(player: Int, Selected: Int) -> (Int, Int) { // set the heal cible and return this index first for the player and second to characters
        var i = 0
        while 0 == 0 {
            self.ui.printArcade(line: self.ui.heal, term: 0)
            prompt()
            if utils.canHeal(Characters: players[player].perso) == true {
                i = self.utils.selectHeal(Player: player, Characters: players[player].perso, line: UserRes)
                if i != -1 {
                    UserRes = ""
                    return (player, i)
                } else {
                    self.getCibleToHeal(player: player)
                }
            } else {
                self.ui.printArcade(line: self.ui.heal, term: 0)
            }
        }
    }
    
    func printMyCharacters(player: Int) { // print the avaible characters
        for i in 0..<players[player].perso.count {
            if players[player].perso[i].life > 0 {
                self.ui.printArcade(line: "- \(players[player].perso[i].name)", term: 0)
            }
        }
    }
    
    func chooseCharacter(player: Int) -> Int { // set the characters choose
        var Selected = -1
        var Heal = false
        while Selected == -1 {
            self.ui.printArcade(line: "\(players[player].name) \(self.ui.character)", term: 0)
            printMyCharacters(player: player)
            prompt()
            Selected = utils.selectGoodCharacter(Characters: players[player].perso, line: UserRes)
            Heal = utils.TeamNeedHeal(Player: player, Characters: players[player].perso, Selected: Selected)
            if Selected != -1 && Heal == true {
                UserRes = ""
                return Selected
            } else {
                if Heal == false && Selected != -1 {
                    self.ui.printArcade(line: self.ui.errorHeal, term: 0)
                } else {
                    self.ui.printArcade(line: self.ui.errorSelect, term: 0)
                }
            }
        }
        return -1
    }
    
    func TakeWeapon(player: Int, Selected: Int, dmg: Int, name: String) { // action for take or not the weapon
        while 0 == 0 {
            prompt()
            if UserRes == "Oui" {
                self.ui.printArcade(line: "\(players[player].perso[Selected].name) prend l'arme", term: 0)
                players[player].perso[Selected].dmg = players[player].perso[Selected].dmg + dmg
                players[player].perso[Selected].weapon = (name, dmg)
                break
            } else if UserRes == "Non" {
                self.ui.printArcade(line: "\(players[player].perso[Selected].name) ne prend pas l'arme", term: 0)
                break
            } else {
                self.ui.printArcade(line: "Oui / Non", term: 0)
            }
        }
    }
    
    func SpawnWeapon(player: Int, Selected: Int) { // condition for take a weapon
        let r = arc4random_uniform(10)
        if r > 7 {
            var name = ""
            var dmg = 0
            self.ui.printArcade(line: self.ui.weaponSpawnAlert, term: 0)
            if players[player].perso[Selected].canHeal == true {
                let random = Int(arc4random_uniform(UInt32(self.combat.weaponHeal.count)))
                (name, dmg) = self.combat.weaponHeal[random]
            } else {
                let random = Int(arc4random_uniform(UInt32(self.combat.weaponHeal.count)))
                (name, dmg) = self.combat.weapon[random]
            }
            self.ui.printArcade(line: "\(players[player].perso[Selected].name) ouvre le coffre et \(name) apparaît voulez vous qu'il la prenne ? (Oui / Non)", term: 0)
            self.TakeWeapon(player: player, Selected: Selected, dmg: dmg, name: name)
        }
    }
    
    func looseIfOnlyMage() { // The player loose if this team has only Mage
        var m = -1
        for i in 0..<players.count {
            for nbr in 0..<players[i].perso.count {
                if players[i].perso[nbr].lifeMax == 75 || players[i].perso[nbr].life <= 0 {
                    m += 1
                }
            }
            if m == players[i].perso.count {
                self.ui.printArcade(line: "\(players[i].name) n'as plus que des mages et donc ne peux plus attaquer !", term: 0)
                players[i].loose = true
            }
        }
        
    }
    
    func combats() { // The Combat
        while self.utils.countAlivePlayer(Players: self.players) == false {
            for i in 0..<self.players.count {
                looseIfOnlyMage()
                if self.players[i].loose == false {
                    var m = 0
                    var nbr = 0
                    var Selected = -1
                    while Selected == -1 {
                     Selected = chooseCharacter(player: i)
                    }
                    self.SpawnWeapon(player: i, Selected: Selected)
                    self.printInfoAnotherPlayer(player: i)
                    if self.players[i].perso[Selected].canHeal == false {
                        self.getCible(player: i)
                        (m, nbr) = self.selectCible(player: i, Selected: Selected)
                    } else {
                        self.getCibleToHeal(player: i)
                        (m, nbr) = self.selectCibleToHEal(player: i, Selected: Selected)
                    }
                    self.combat.action(Character: players[i].perso[Selected], Cible: players[m].perso[nbr], ui: self.ui)
                }
                self.utils.setAlivePlayer(Player: self.players)
                if self.utils.countAlivePlayer(Players: self.players) == true {
                    break
                }
            }
        }
        let winner = self.utils.getWinner(Players: players)
        self.ui.printArcade(line: "\(players[winner].name) à gagner 🎉🎉🎉", term: 0)
    }
    
    func prompt() { // print the prompt and get the command of player
        self.ui.printArcade(line: self.ui.promt, term: 1, speed: 0)
        self.UserRes = readLine()!
    }
    
    init(UI: UIGame, Utils: Utils) {
        self.players = []
        self.nameChamp = []
        self.namePlayer = []
        self.ui = UI
        self.utils = Utils
        self.combat = Combats()
        self.UserRes = ""
        self.nbrPlayer = 2
        self.nbrCharacter = 0
    }
}
