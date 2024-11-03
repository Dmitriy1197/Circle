//
//  Circle.swift
//  Rotating Circle
//
//  Created by Dima on 31.10.2024.
//

import SpriteKit
class Circle: SKShapeNode{
    
    private var currentRadius: CGFloat
    
    init(radius: CGFloat, fillColor:SKColor, strokeColor: SKColor){
        self.currentRadius = radius
        super.init()
        self.path = CGPath(ellipseIn: CGRect(x: -radius, y: -radius, width: radius*2, height: radius*2), transform: nil)
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.circle
        self.physicsBody?.contactTestBitMask = PhysicsCategory.obstacle
        self.physicsBody?.collisionBitMask = PhysicsCategory.obstacle
        rotate()
    }
    
    func rotate(){
        let rotationAction = SKAction.rotate(byAngle: CGFloat.pi * 2, duration: 2)
        let repeatAction = SKAction.repeatForever(rotationAction)
        self.run(repeatAction)
    }
    
    func setRadius(_ newRadius: CGFloat) {
        self.currentRadius = newRadius
        
        self.path = CGPath(ellipseIn: CGRect(x: -newRadius, y: -newRadius, width: newRadius * 2, height: newRadius * 2), transform: nil)
        self.physicsBody = SKPhysicsBody(circleOfRadius: newRadius)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.circle
        self.physicsBody?.contactTestBitMask = PhysicsCategory.obstacle
        self.physicsBody?.collisionBitMask = PhysicsCategory.obstacle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var radius: CGFloat {
        return currentRadius
    }
}
