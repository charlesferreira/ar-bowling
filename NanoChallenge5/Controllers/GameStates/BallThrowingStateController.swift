//
//  BallThrowingStateController.swift
//  NanoChallenge5
//
//  Created by Charles Ferreira on 02/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import SceneKit

class BallThrowingStateController: GameStateController {
    
    @IBOutlet weak var instructionLabel: UILabel!
    
    var ballsThrown = 0
    var canThrow = true
    
    func setup() {
        resetPins()
        instructionLabel.text = Constants.Text.instructionsHold
        game.sceneView.scene.physicsWorld.contactDelegate = self
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
        game.throwBall()
    }
    
    private func resetPins() {
        let pinSet = PinSet.create(position: game.pinsPlaceholder.position)
        game.sceneView.scene.rootNode.addChildNode(pinSet)
    }
}

extension BallThrowingStateController: SCNPhysicsContactDelegate {
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let nodes = [contact.nodeA, contact.nodeB]
        guard let pinHead = nodes.first(where: { $0.name == Constants.NodeNames.pinHead }) else { return }
        
        let delay = SCNAction.wait(duration: Constants.Game.pinLifeTimeAfterKnockDown)
        let fadeOut = SCNAction.fadeOut(duration: Constants.FX.pinFadeOutDuration)
        let remove = SCNAction.run { $0.removeFromParentNode() }
        pinHead.parent?.runAction(SCNAction.sequence([delay, fadeOut, remove]))
        pinHead.removeFromParentNode()
    }
    
}
