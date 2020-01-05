//
//  Map.swift
//  BoomBoomBois
//
//  Created by Nathan Chang on 1/5/20.
//  Copyright © 2020 Sean Cao, Robert Beit, Aryan Aru Agarwal. All rights reserved.
//

import Foundation

import SpriteKit

class Map: SKNode
{
    var size:CGSize
    var gameScale:CGFloat
    var playableHeight:CGFloat
    var playableMargin:CGFloat
    
    init(map_size: CGSize)
    {
        size = map_size
        gameScale = size.width / 1024
        playableHeight = size.width
        playableMargin = (size.height-playableHeight)/2.0
        
        super.init()
        super.xScale = 0.5 * gameScale
        super.yScale = 0.5 * gameScale
        super.position = CGPoint(x:0, y:playableMargin)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // add map terrain
    func setMap(mapSetting: Int, gameLayer: SKNode)
    {
        let tileSet = SKTileSet(named: "Grid Tile Set")!
        let tileSize = CGSize(width: 128, height: 128)
        let columns = 32
        let rows = 48
        
        if let bottomLayerNode = self.childNode(withName: "background") as? SKTileMapNode {
            bottomLayerNode.removeFromParent()
        }
        
        let bottomLayer = SKTileMapNode(tileSet: tileSet, columns: columns, rows: rows, tileSize: tileSize)
        bottomLayer.name = "background"
        
        if (mapSetting == 1) {
            let grassTiles = tileSet.tileGroups.first { $0.name == "Grass" }
            bottomLayer.fill(with: grassTiles)
        } else if (mapSetting == 2) {
            let dirtTiles = tileSet.tileGroups.first { $0.name == "Dirt"}
            bottomLayer.fill(with: dirtTiles)
        } else {
            let dirtTiles = tileSet.tileGroups.first { $0.name == "Dirt"}
            bottomLayer.fill(with: dirtTiles)
        }
        
        self.addChild(bottomLayer)
        
        if (mapSetting==1){
            for i in 1...10 {
                let bottomBush = SKSpriteNode(imageNamed: "Bush")
                bottomBush.name = "obstacle"
                bottomBush.physicsBody = SKPhysicsBody(rectangleOf: bottomBush.size)
                bottomBush.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
                bottomBush.physicsBody?.contactTestBitMask = PhysicsCategory.projectile
                bottomBush.physicsBody?.collisionBitMask = PhysicsCategory.player | PhysicsCategory.pickupTile
                bottomBush.physicsBody?.isDynamic = false
                bottomBush.setScale(0.3)
                
                var X = size.width/2
                var Y = CGFloat(i) * bottomBush.size.height/2 + playableMargin
                bottomBush.position = CGPoint(x:CGFloat(X),y:CGFloat(Y))
                gameLayer.addChild(bottomBush)
                
                let topBush = SKSpriteNode(imageNamed: "Bush")
                topBush.name = "obstacle"
                topBush.physicsBody = SKPhysicsBody(rectangleOf: topBush.size)
                topBush.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
                topBush.physicsBody?.contactTestBitMask = PhysicsCategory.projectile
                topBush.physicsBody?.collisionBitMask = PhysicsCategory.player | PhysicsCategory.pickupTile
                topBush.physicsBody?.isDynamic = false
                topBush.setScale(0.3)
                X = size.width/2
                Y = size.height - playableMargin - (CGFloat(i) * topBush.size.height/2)
                topBush.position = CGPoint(x:CGFloat(X),y:CGFloat(Y))
                gameLayer.addChild(topBush)
                
                let leftBush = SKSpriteNode(imageNamed: "Bush")
                leftBush.name = "obstacle"
                leftBush.physicsBody = SKPhysicsBody(rectangleOf: leftBush.size)
                leftBush.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
                leftBush.physicsBody?.contactTestBitMask = PhysicsCategory.projectile
                leftBush.physicsBody?.collisionBitMask = PhysicsCategory.player | PhysicsCategory.pickupTile
                leftBush.physicsBody?.isDynamic = false
                leftBush.setScale(0.3)
                X = CGFloat(i) * leftBush.size.height/2
                Y = size.height/2
                leftBush.position = CGPoint(x:CGFloat(X),y:CGFloat(Y))
                gameLayer.addChild(leftBush)
                
                let rightBush = SKSpriteNode(imageNamed: "Bush")
                rightBush.name = "obstacle"
                rightBush.physicsBody = SKPhysicsBody(rectangleOf: rightBush.size)
                rightBush.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
                rightBush.physicsBody?.contactTestBitMask = PhysicsCategory.projectile
                rightBush.physicsBody?.collisionBitMask = PhysicsCategory.player | PhysicsCategory.pickupTile
                rightBush.physicsBody?.isDynamic = false
                rightBush.setScale(0.3)
                X = size.width -  (CGFloat(i) * rightBush.size.height/2)
                Y = size.height/2
                rightBush.position = CGPoint(x:CGFloat(X),y:CGFloat(Y))
                gameLayer.addChild(rightBush)
            }
            let bush = SKSpriteNode(imageNamed: "Bush")
            bush.name = "obstacle"
            bush.physicsBody = SKPhysicsBody(rectangleOf: bush.size)
            bush.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
            bush.physicsBody?.contactTestBitMask = PhysicsCategory.projectile
            bush.physicsBody?.collisionBitMask = PhysicsCategory.player | PhysicsCategory.pickupTile
            bush.physicsBody?.isDynamic = false
            bush.setScale(0.3)
            let X = size.width/2
            let Y = size.height/2
            bush.position = CGPoint(x:CGFloat(X),y:CGFloat(Y))
            gameLayer.addChild(bush)
            
        } else {
            for _ in 1...25 {
                let rock = SKSpriteNode(imageNamed: "Rock")
                rock.name = "obstacle"
                rock.physicsBody = SKPhysicsBody(rectangleOf: rock.size)
                rock.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
                rock.physicsBody?.contactTestBitMask = PhysicsCategory.projectile
                rock.physicsBody?.collisionBitMask = PhysicsCategory.player | PhysicsCategory.pickupTile
                rock.physicsBody?.isDynamic = true
                
                let randX = Int.random(in: 100...Int(size.width-100))
                let randY = Int.random(in: Int(playableMargin)+100...Int(playableMargin)+Int(size.width)-100)
                rock.position = CGPoint(x:CGFloat(randX),y:CGFloat(randY))
                rock.setScale(0.3)
                gameLayer.addChild(rock)
            }
        }
    }

}

