//
//  ViewController.swift
//  My Little Monster
//
//  Created by Lyle Christianne Jover on 12/02/2016.
//  Copyright © 2016 Lyle Christianne Jover. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    @IBOutlet weak var penalty1Img: UIImageView!
    @IBOutlet weak var penalty2Img: UIImageView!
    @IBOutlet weak var penalty3Img: UIImageView!
    @IBOutlet weak var restartBtn: UIButton!
    @IBOutlet weak var golemBtn: UIButton!
    @IBOutlet weak var humanBtn: UIButton!
    @IBOutlet weak var minerImg: MinerImg!
    @IBOutlet weak var panelImg: UIImageView!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: NSTimer!
    var monsterHappy = false
    var currentItem: UInt32 = 0
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    var chosenCharacter: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restartBtn.hidden = true
        monsterImg.hidden = true
        minerImg.hidden  = true
  
        
        humanBtn.hidden = false
        golemBtn.hidden = false
        
        panelImg.hidden = true
        penalty1Img.hidden = true
        penalty2Img.hidden = true
        penalty3Img.hidden   = true
        heartImg.hidden = true
        foodImg.hidden = true
    
        
        
    }
    
    func playGolem(){
        golemBtn.hidden = true
        humanBtn.hidden = true
        monsterImg.hidden = false
        minerImg.hidden = true
        monsterImg.playIdleAnimation()
        penalties = 0
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        do{
            
            let resourcePath = NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!
            let url = NSURL(fileURLWithPath: resourcePath)
            
            try musicPlayer = AVAudioPlayer(contentsOfURL: url)
            
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxSkull.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        startTimer()
    }
    
    func playHuman(){
        golemBtn.hidden = true
        humanBtn.hidden = true
        minerImg.hidden = false
        monsterImg.hidden = true
        minerImg.playIdleAnimation()
        penalties = 0
        foodImg.dropTarget = minerImg
        heartImg.dropTarget = minerImg
        
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        do{
            
            let resourcePath = NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!
            let url = NSURL(fileURLWithPath: resourcePath)
            
            try musicPlayer = AVAudioPlayer(contentsOfURL: url)
            
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxSkull.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        startTimer()
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        
        monsterHappy = true
        startTimer()
     
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        
        if currentItem == 0 {
            sfxHeart.play()
        } else {
            sfxBite.play()
        }
        
    }
    
    func startTimer() {
        
        if timer != nil{
            
            timer.invalidate()
            
        }
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
        
    }
    
    func changeGameState(){
        
    if !monsterHappy {
        penalties++
        sfxSkull.play()
        
        if penalties == 1 {
            
            penalty1Img.alpha = OPAQUE
            penalty2Img.alpha = DIM_ALPHA
            
        } else if penalties == 2 {
            penalty2Img.alpha = OPAQUE
            penalty3Img.alpha = DIM_ALPHA
        } else if penalties >= 3 {
            penalty3Img.alpha = OPAQUE
            
        } else {
            penalty1Img.alpha = DIM_ALPHA
            penalty2Img.alpha = DIM_ALPHA
            penalty3Img.alpha = DIM_ALPHA
        }
        
        if penalties >= MAX_PENALTIES {
            gameOver()
        }
    }
        let rand = arc4random_uniform(2)    //0 or 1
        
        if rand == 0 {
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            
            heartImg.alpha  = OPAQUE
            heartImg.userInteractionEnabled = true
            
        } else {
            
            foodImg.alpha = OPAQUE
            foodImg.userInteractionEnabled = true
            
            heartImg.alpha  = DIM_ALPHA
            heartImg.userInteractionEnabled = false
            
            
        }
        currentItem = rand
        monsterHappy = false
    }
    
    func gameOver() {
        sfxDeath.play()
        timer.invalidate()
        
        if chosenCharacter == true {
            monsterImg.playDeathAnimation()
        } else{
            minerImg.playDeathAnimation()
        }

        restartBtn.hidden = false

    }

    @IBAction func restartBtnPressed(sender: AnyObject) {
        
        viewDidLoad()
        restartBtn.hidden = true
        panelImg.hidden = false
        penalty1Img.hidden = false
        penalty2Img.hidden = false
        penalty3Img.hidden   = false
        heartImg.hidden = false
        foodImg.hidden = false
        if chosenCharacter == true {
            playGolem()
        } else {
            playHuman()
        }
        
    }

    @IBAction func golemBtnPressed(sender: AnyObject) {
        
        chosenCharacter = true
        panelImg.hidden = false
        penalty1Img.hidden = false
        penalty2Img.hidden = false
        penalty3Img.hidden   = false
        heartImg.hidden = false
        foodImg.hidden = false
        playGolem()
    }

    @IBAction func humanBtnPressed(sender: AnyObject) {
        

        chosenCharacter = false
        panelImg.hidden = false
        penalty1Img.hidden = false
        penalty2Img.hidden = false
        penalty3Img.hidden   = false
        heartImg.hidden = false
        foodImg.hidden = false
        playHuman()
    }


}

