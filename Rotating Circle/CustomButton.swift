//
//  CustomButton.swift
//  Rotating Circle
//
//  Created by Dima on 31.10.2024.
//

import SpriteKit

class CustomButton: SKSpriteNode{
    
    
    var action: (() -> Void)?
    
    init(title: String, size: CGSize, backgroundColor: UIColor) {
        super.init(texture: nil, color: backgroundColor, size: size)
        self.isUserInteractionEnabled = true
        
        let label = SKLabelNode(text: title)
        label.fontSize = 60
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.fontColor = .black
        addChild(label)
        self.color = backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            action?() 
        }
}
