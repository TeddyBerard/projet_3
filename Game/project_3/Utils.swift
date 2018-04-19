//
//  utils.swift
//  project_3
//
//  Created by Teddy Bérard on 16/04/2018.
//  Copyright © 2018 Teddy Bérard. All rights reserved.
//

import Foundation

class Utils {
    var Class = ["1", "Combattant", "2", "Mage", "3", "Colosse", "4", "Nain"]
    
    
    func checkNbrPlayer(line: String) -> Bool { // check if the result is a good number 
        let num = Int(line)
        if line.isEmpty || num == nil || num == 0 || num == 1 {
            return false
        }
        return true
    }
    
    func checkNbrCharacter(line: String) -> Bool { // check if the result is a good number
        let num = Int(line)
        if line.isEmpty || num == nil || num == 0 {
            return false
        }
        return true
    }
    
    func checkNameExist(line: String, names: [String]) -> Bool { // compare if the name exist
        if line.isEmpty || line == "" || names.contains(line) {
            return false
        }
        return true
    }
    
    func checkClass(line: String) -> Bool { // compare if the class exist
        if line.isEmpty || line == "" || !self.Class.contains(line) {
            print(self.Class)
            print(line)
            return false
        }
        return true
    }
    
    func selectGoodCharacter(Characters : [Perso], line: String) -> Int { // select the character
        for i in 0..<Characters.count {
            if line == Characters[i].name && Characters[i].life > 0 {
                return i
            }
        }
        return -1
    }
    
    func selectGoodCible(Player: Int, Players: [Team], line: String) -> (Int, Int) { // select the cible
        for i in 0..<Players.count {
            if i != Player {
                for nbr in 0..<Players[i].perso.count {
                    if line == Players[i].perso[nbr].name && Players[i].perso[nbr].life > 0 {
                        return (i, nbr)
                    }
                }
            }
        }
        return (-1, -1)
    }
    
    func canHeal(Characters: [Perso]) -> Bool {
        for i in 0..<Characters.count {
            if Characters[i].life < Characters[i].lifeMax && Characters[i].life > 0 {
                return true
            }
        }
        return false
    }
    
    func selectHeal(Player: Int, Characters: [Perso], line: String) -> Int { // select the heal
        for i in 0..<Characters.count {
            if Characters[i].life < Characters[i].lifeMax && Characters[i].life > 0 && line == Characters[i].name {
                return i
            }
        }
        return -1
    }
    
    func TeamNeedHeal(Player: Int, Characters: [Perso], Selected: Int) -> Bool { // give if the team need heal
        if Selected == -1 { return false }
        if Characters[Selected].canHeal == false {
            return true
        }
        for i in 0..<Characters.count {
            if Characters[i].life < Characters[i].lifeMax && Characters[i].life > 0 {
                return true
            }
        }
        return false
    }
    
    func countAlivePlayer(Players: [Team]) -> Bool { // count Alive player
        var Alive = 0
        for i in 0..<Players.count {
            if Players[i].loose == true {
                Alive += 1
            }
        }
        if Alive == 1 {
            return true
        }
        return false
    }
    
    func setAlivePlayer(Player: [Team]) { // set the loose
        for i in 0..<Player.count {
            var alive = 0
            for nbr in 0..<Player[i].perso.count {
                if Player[i].perso[nbr].life > 0 {
                    alive += 1
                }
            }
            if alive == 0 {
                Player[i].loose = true
            }
        }
    }
    
    func getWinner(Players: [Team]) -> Int { // get the winner
        for i in 0..<Players.count {
            if Players[i].loose == false {
                return i
            }
        }
        return -1
    }
}
