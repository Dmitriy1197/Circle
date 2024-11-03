//
//  GameScene.swift
//  Rotating Circle
//
//  Created by Dima on 30.10.2024.
//

import SpriteKit
import UIKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    //MARK: - Properties
    var circle: Circle!
    var collisionCount: Int = 0
    
    //MARK: - Methods
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        createCircle()
        createButtons()
        startObstacleSpawing()
    }
    
    //MARK: - Circle
    func createCircle() {
        circle = Circle(radius: 50, fillColor: .blue, strokeColor: .black)
        circle.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(circle)
        print("Circle added at position: \(circle.position)")
    }
    //MARK: - Buttons
    func createButtons(){
        let increaseButton = CustomButton(title: "+", size: CGSize(width: 50, height: 50), backgroundColor: .green)
        increaseButton.position = CGPoint(x: size.width / 2 + 60, y: increaseButton.size.height + 50)
        increaseButton.action = { [weak self] in
            guard let currentRadius = self?.circle.radius else { return }
            self?.circle.setRadius(currentRadius + 10)
        }
        addChild(increaseButton)
        let decreaseButton = CustomButton(title: "-", size: CGSize(width: 50, height: 50), backgroundColor: .red)
        decreaseButton.position = CGPoint(x: size.width / 2 - 60, y: decreaseButton.size.height + 50)
        decreaseButton.action = { [weak self] in
            guard let currentRadius = self?.circle.radius else { return }
            let newRadius = max(currentRadius - 10, 10)
            self?.circle.setRadius(newRadius)
        }
        addChild(decreaseButton)
    }
    //MARK: - Obstacles
    func startObstacleSpawing(){
        let spawn = SKAction.run { [weak self] in
            self?.spawnObstacles()
        }
        let delay = SKAction.wait(forDuration: 2.0, withRange: 1.0)
        let sequence = SKAction.sequence([spawn, delay])
        let repeatSpawn = SKAction.repeatForever(sequence)
        self.run(repeatSpawn)
    }
    
    func spawnObstacles(){
        let obstacleHeight: CGFloat = 20
        let obstacleWidth: CGFloat = 100
        let circleY = circle.position.y
        let upperBound = min(circleY - 10, size.height - obstacleHeight / 2)
        let lowerBound = max(circleY + 10, obstacleHeight / 2)
        let yPosition: CGFloat = Bool.random() ? CGFloat.random(in: obstacleHeight / 2...upperBound) : CGFloat.random(in: lowerBound...(size.height - obstacleHeight / 2))
        
        let obstacle = Obstacle(width: obstacleWidth, height: obstacleHeight)
        obstacle.position = CGPoint(x: size.width + obstacleWidth, y: yPosition)
        addChild(obstacle)
        obstacle.startMoving(duration: 3.0)
        print("Obstacle spawned at position: \(obstacle.position)")
    }
    
    func triggerVibration() {
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        }
    }
    //MARK: - Collision
    func didBegin(_ contact: SKPhysicsContact) {
        
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        print("Contact detected between \(bodyA.categoryBitMask) and \(bodyB.categoryBitMask)")
        
        if let circle = bodyA.node as? Circle ?? bodyB.node as? Circle,
           circle.radius >= 60,
           (bodyA.categoryBitMask == PhysicsCategory.obstacle || bodyB.categoryBitMask == PhysicsCategory.obstacle) {
            print("Collision detected with circle of radius: \(circle.radius)")
            triggerVibration()
            
            if bodyA.categoryBitMask == PhysicsCategory.obstacle {
                bodyA.node?.removeFromParent()
            } else {
                bodyB.node?.removeFromParent()
            }
            collisionCount += 1
            print("Collision count: \(collisionCount)")
            if collisionCount >= 5 {
                showGameOverAlert()
            }
        }
    }
    //MARK: - Alert
    func showGameOverAlert() {
        let alert = UIAlertController(title: "Game Over", message: "You have reached 5 collisions. Do you want to restart the game?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { [weak self] _ in
            self?.restartGame()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if let viewController = self.view?.window?.rootViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func restartGame() {
        collisionCount = 0
        self.removeAllChildren()
        self.didMove(to: self.view!)
    }
}
