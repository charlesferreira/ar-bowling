//
//  BallThrowingStateController.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import SceneKit

class BallThrowingStateController: GameStateController {
    
    @IBOutlet weak var currentBallLabel: UILabel!
    @IBOutlet weak var currentFrameLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    
    var canThrow = true
    var ballCount = 0
    var pins = 0
    
    func setup() {
        resetPins()
        instructionLabel.text = Constants.Text.instructionsHold
        game.sceneView.scene.physicsWorld.contactDelegate = self
        updateHeader()
    }
    
    func teardown() {
        game.sceneView.scene.physicsWorld.contactDelegate = nil
    }
    
    func update(at time: TimeInterval) {
        game.camera.update(at: time)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard canThrow else { return }
        game.showBallPlaceholder()
        instructionLabel.text = Constants.Text.instructionsRelease
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard canThrow else { return }
//        canThrow = false
        ballCount += 1
        game.throwBall()
        waitForBallToFadeOut()
    }
    
    private func waitForBallToFadeOut() {
        Timer.scheduledTimer(withTimeInterval: Constants.Game.ballLifeTime, repeats: false) { [weak self] _ in
            guard let this = self else { return }
            let throwResults = this.game.scoreboard.score(pins: this.pins)
            switch throwResults {
            case .nextBall:
                this.setUpNextBall()
            case .frameComplete:
                this.showScoreboard(gameOver: false)
            case .gameOver:
                this.showScoreboard(gameOver: true)
            }
        }
    }
    
    private func resetPins() {
        let pinSet = PinSet.create(position: game.pinsPlaceholder.position)
        game.sceneView.scene.rootNode.addChildNode(pinSet)
    }
    
    func updateHeader() {
        currentBallLabel.text = (game.scoreboard.currentFrame.ballIndex + 1).description
        currentFrameLabel.text = (game.scoreboard.frameIndex + 1).description
    }
    
    private func setUpNextBall() {
        // todo: implementar
    }
    
    private func showScoreboard(gameOver: Bool) {
        // todo: implementar
    }
}

extension BallThrowingStateController: SCNPhysicsContactDelegate {
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let nodes = [contact.nodeA, contact.nodeB]
        guard let pinHead = nodes.first(where: { $0.name == Constants.NodeNames.pinHead }) else { return }
        
        // animations
        let delay = SCNAction.wait(duration: Constants.Game.pinLifeTimeAfterKnockDown)
        let fadeOut = SCNAction.fadeOut(duration: Constants.FX.pinFadeOutDuration)
        let remove = SCNAction.run { $0.removeFromParentNode() }
        pinHead.parent?.runAction(SCNAction.sequence([delay, fadeOut, remove]))
        pinHead.removeFromParentNode()
        
        // contabiliza o pino derrubado
        pins += 1
    }
    
}
