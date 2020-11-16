//
//  PlayersGenerator.swift
//  Uno
//
//  Created by Thibault Klein on 10/18/20.
//

import Foundation

struct PlayersGenerator {
    static func generatePlayersRotation(_ players: [Player]) -> LinkedList<Player> {
        let playersRotation = LinkedList<Player>()
        
        for player in players {
            playersRotation.append(player)
        }

        if let lastPlayer = playersRotation.last {
            // Creates a loop to do a round-robin player rotation
            lastPlayer.next = playersRotation.first
        }

        return playersRotation
    }
}
