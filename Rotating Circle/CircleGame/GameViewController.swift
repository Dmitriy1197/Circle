//
//  GameViewController.swift
//  Rotating Circle
//
//  Created by Dima on 30.10.2024.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = GameScene(size: view.bounds.size) // Використовуємо розміри вікна
        scene.scaleMode = .aspectFill

        let skView = SKView(frame: view.bounds)
        skView.presentScene(scene)
        view.addSubview(skView)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

