//
//  WildColorSelectionNode.swift
//  Uno
//
//  Created by Thibault Klein on 11/13/20.
//

import SpriteKit

final class WildColorSelectionNode: SKSpriteNode {
    let card: WildCard
    let cardColor: CardColor
    
    // MARK: - Init Functions
    
    init(card: WildCard, cardColor: CardColor) {
        self.card = card
        self.cardColor = cardColor
        
        super.init(texture: nil,
                   color: UIColor.cardColor(cardColor),
                   size: CGSize(width: 50, height: 50))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
