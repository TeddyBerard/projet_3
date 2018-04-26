//
//  team.swift
//  project_3
//
//  Created by Teddy Bérard on 10/04/2018.
//  Copyright © 2018 Teddy Bérard. All rights reserved.
//

import Foundation

class Team { // class for player
    var character: [Character] = [] // see Character.swift
    var name: String = "" // name of player
    var loose: Bool = false
    
    func AlivePlayer(player: [Team]) { // set the loose
        for i in 0..<player.count {
            var alive = 0
            for nbr in 0..<player[i].character.count {
                if player[i].character[nbr].life > 0 {
                    alive += 1
                }
            }
            if alive == 0 {
                player[i].loose = true
            }
        }
    }
}
