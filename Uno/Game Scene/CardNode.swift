//
//  CardNode.swift
//  Uno
//
//  Created by Thibault Klein on 11/4/20.
//

import SpriteKit

final class CardNode: SKSpriteNode {
    let card: Card
    let player: Player

    // MARK: - Init Functions

    init(card: Card, player: Player) {
        self.card = card
        self.player = player

        super.init(texture: SKTexture(imageNamed: card.imageName),
                   color: .clear,
                   size: Constants.Card.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
