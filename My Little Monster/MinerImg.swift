//
//  MonsterImg.swift
//  My Little Monster
//
//  Created by Lyle Christianne Jover on 12/02/2016.
//  Copyright © 2016 Lyle Christianne Jover. All rights reserved.
//

import Foundation
import UIKit

class MinerImg:UIImageView{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation()
    }
    
    func playIdleAnimation () {
        
        self.image = UIImage(named: "miner1.png")
        
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        for var x = 1; x <= 6; x++ {
            
            let img = UIImage(named: "miner\(x).png")
            imgArray.append(img!)
            
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func playDeathAnimation(){
        
        self.image = UIImage(named: "deadminer5.png")
        
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        for var x = 1; x <= 5; x++ {
            
            let img = UIImage(named: "deadminer\(x).png")
            imgArray.append(img!)
            
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
        
    }
}