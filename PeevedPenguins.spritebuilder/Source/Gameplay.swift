//
//  Gameplay.swift
//  
//
//  Created by Muhammed Othman on 7/27/15.
//
//

import UIKit

class Gameplay: CCNode {
   
    weak var gamePhysicsNode: CCPhysicsNode!
    weak var catapultArm: CCNode!
    weak var levelNode: CCNode!
    weak var contentNode: CCNode!
    
    // called when CCB file has completed loading
    func didLoadFromCCB() {
        userInteractionEnabled = true
        let level = CCBReader.load("Levels/Level1")
        levelNode.addChild(level)
    }
    
    // called on every touch in this scene
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        launchPenguin()
    }
    
    func launchPenguin() {
        // loads the Penguin.ccb we have set up in SpriteBuilder
        let penguin = CCBReader.load("Penguin") as! Penguin
        // position the penguin at the bowl of the catapult
        penguin.position = ccpAdd(catapultArm.position, CGPoint(x: 16, y: 50))
        
        // add the penguin to the gamePhysicsNode (because the penguin has physics enabled)
        gamePhysicsNode.addChild(penguin)
        
        // manually create & apply a force to launch the penguin
        let launchDirection = CGPoint(x: 1, y: 0)
        let force = ccpMult(launchDirection, 8000)
        penguin.physicsBody.applyForce(force)
        // ensure followed object is in visible are when starting
        position = CGPoint.zeroPoint
        let actionFollow = CCActionFollow(target: penguin, worldBoundary: boundingBox())
        contentNode.runAction(actionFollow)
    }

    func retry() {
        let gameplayScene = CCBReader.loadAsScene("Gameplay")
        CCDirector.sharedDirector().presentScene(gameplayScene)
    }
}
