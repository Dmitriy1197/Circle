//
//  Obstacle.swift
//  Rotating Circle
//
//  Created by Dima on 31.10.2024.
//

import SpriteKit
class Obstacle: SKShapeNode{
    init(width: CGFloat, height: CGFloat) {
        super.init()
        self.path = CGPath(rect: CGRect(x: -width / 2, y: -height / 2, width: width, height: height), transform: nil)
        self.fillColor = .brown
        self.strokeColor = .white
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
        self.physicsBody?.contactTestBitMask = PhysicsCategory.circle
        self.physicsBody?.collisionBitMask = PhysicsCategory.circle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func startMoving(duration: TimeInterval){
        let moveLeft = SKAction.moveBy(x: -UIScreen.main.bounds.width - self.frame.width, y: 0, duration: duration / 2)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveLeft, remove])
        self.run(sequence)
    }
}
