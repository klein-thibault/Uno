//
//  GameScene.swift
//  Uno
//
//  Created by Thibault Klein on 10/17/20.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let drawPile = SKSpriteNode(imageNamed: "Deck")
    let playedPile = SKSpriteNode()
    let resetButton = SKLabelNode(text: "Reset")
    var game: Game!
    let gameplay = UnoGameplay()
    let players = [
        Player(name: "John", number: 1),
        Player(name: "Marc", number: 2)
    ]
    
    private var playerCardsNodes: [CardNode] = []
    private var colorSelectionNodes: [WildColorSelectionNode] = []

    override func didMove(to view: SKView) {
        setupGame()
        setupTable()
        setupButtons()

        game.start()
        
        renderPlayedCardsStack()

        for player in players {
            setupPlayerHand(player)
            renderPlayerHand(player)
        }
    }
    
    func touchDown(atPoint pos: CGPoint) {
        let touchedNode = self.atPoint(pos)
        
        if touchedNode.name == drawPile.name {
            drawCard()
        }

        if touchedNode.name == resetButton.name {
            // reset game
        }
        
        if let playerCardNode = touchedCard(name: touchedNode.name) {
            let player = playerCardNode.player
            let card = playerCardNode.card
            let successPlay = game.play(player: player, card: card)
            
            if successPlay {
                playerCardsNodes.removeCard(playerCardNode)
                playerCardNode.removeFromParent()
                renderPlayedCardsStack()
                renderPlayerHand(player)
            }
        }
        
        if let colorSelectionNode = touchedColorSelection(name: touchedNode.name) {
            let card = colorSelectionNode.card
            let color = colorSelectionNode.cardColor
            card.selectedColor = color
            colorSelectionNodes.forEach { $0.removeFromParent() }
        }
    }
    
    func touchMoved(toPoint pos: CGPoint) {
    }
    
    func touchUp(atPoint pos: CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    // MARK: - UI Rendering Functions
    
    private func setupTable() {
        addChild(drawPile)
        drawPile.position = CGPoint(x: 80, y: 0)
        drawPile.size = Constants.Card.size
        drawPile.name = "Draw Pile"
        
        addChild(playedPile)
        playedPile.position = CGPoint(x: -80, y: 0)
        playedPile.size = Constants.Card.size
    }
    
    private func setupButtons() {
        addChild(resetButton)
        resetButton.position = CGPoint(x: 0, y: 160)
        resetButton.name = "Reset Button"
    }
    
    private func setupGame() {
        game = Game.generateGame(withPlayers: players)
        game.delegate = self
    }
    
    private func setupPlayerHand(_ player: Player) {
        for card in player.cards {
            let cardNode = CardNode(card: card, player: player)
            playerCardsNodes.append(cardNode)
        }
    }
    
    private func renderPlayerHand(_ player: Player) {
        let nodes = playerCardsNodes.filter { $0.player == player }
        let numberOfCards = nodes.count
        let totalCardsWidth = CGFloat(numberOfCards) * Constants.Card.size.width
        var nextXPosition = -(totalCardsWidth / 2) + (Constants.Card.size.width / 2)
        let yPosition: CGFloat = player.number == 1 ? -160 : 160
        
        for cardNode in nodes {
            if childNode(withName: cardNode.name!) == nil {
                addChild(cardNode)
            }
            cardNode.position = CGPoint(x: nextXPosition, y: yPosition)
            nextXPosition += cardNode.size.width
        }
    }
    
    private func renderPlayedCardsStack() {
        guard let activeCard = game.activeCard else { return }
        playedPile.texture = SKTexture(imageNamed: activeCard.imageName)
    }
    
    private func renderWildCardColorSelectionButtons(wildCard: WildCard) {
        for color in [CardColor.blue, .green, .red, .yellow] {
            let node = WildColorSelectionNode(card: wildCard, cardColor: color)
            node.name = color.name
            colorSelectionNodes.append(node)
        }
        
        var nextXPosition: CGFloat = -(CGFloat(colorSelectionNodes.count) / 2) + (Constants.ColorSelection.size.width / 2)
        for node in colorSelectionNodes {
            addChild(node)
            node.position = CGPoint(x: nextXPosition, y: 0)
            node.zPosition = .greatestFiniteMagnitude
            nextXPosition += node.frame.size.width
        }
    }
    
    // MARK: - Touch Functions
    
    private func touchedCard(name: String?) -> CardNode? {
        return playerCardsNodes.first { $0.name == name }
    }
    
    private func touchedColorSelection(name: String?) -> WildColorSelectionNode? {
        return colorSelectionNodes.first { $0.name == name }
    }
    
    // MARK: - Action Functions
    
    func drawCard() {
        let card = gameplay.drawCardFromPile(game: game)
        let player = gameplay.addCardToPlayerHand(game: game, card: card)
        let cardNode = CardNode(card: card, player: player)
        playerCardsNodes.append(cardNode)
        renderPlayerHand(player)
    }
}

// MARK: - GameDelegate -
extension GameScene: GameDelegate {
    func askForWildCardColor(_ wildCard: WildCard) {
        renderWildCardColorSelectionButtons(wildCard: wildCard)
    }
}
