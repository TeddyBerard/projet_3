//
//  team.swift
//  project_3
//
//  Created by Teddy Bérard on 10/04/2018.
//  Copyright © 2018 Teddy Bérard. All rights reserved.
//

import Foundation

class Team { // class for player
    var perso: [Perso] // see personnage.swift
    var name: String // name of player
    var loose: Bool
    init() {
        self.name = "" // init name
        self.perso = []
        self.loose = false
    }
}
