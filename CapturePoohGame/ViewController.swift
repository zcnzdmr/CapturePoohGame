//
//  ViewController.swift
//  CapturePoohGame
//
//  Created by Özcan Özdemir on 3.04.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var timerLabel = UILabel()
    var scoreLabel = UILabel()
    var highScoreLabel = UILabel()
    var imageView = UIImageView()
    var counter = 11
    var timeUp = false
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenWidth = UIScreen.main.bounds.width
        print(screenWidth)
        let screenHeight = UIScreen.main.bounds.height
        print(screenHeight)
        
        
        //timerLabel kısmı
        timerLabel.frame = CGRect(x: (screenWidth - 250) / 2 , y: 80, width: 250, height: 40)
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.systemFont(ofSize: 30)
        timerLabel.text = "0"
        view.addSubview(timerLabel)
        
        //ScoreLabel kısmı
        scoreLabel.frame = CGRect(x: (screenWidth - 250) / 2, y: 140, width: 250, height: 35)
        scoreLabel.text = "Score :  1"
        scoreLabel.textAlignment = .center
        view.addSubview(scoreLabel)
        
        //highScoreLabel kısmı
        highScoreLabel.frame = CGRect(x: (screenWidth - 250) / 2 , y: 750, width: 250, height: 35)
        highScoreLabel.text = "Highscore :  4"
        highScoreLabel.textAlignment = .center
        view.addSubview(highScoreLabel)
        
        //imageView kısmı
        imageView.frame = CGRect(x: (screenWidth - 120) / 2 , y: 200, width: 120, height: 160)
        imageView.image = UIImage(named: "images")
        view.addSubview(imageView)
        
        timerFonk()
    }
    
    func timerFonk() {
        //timer kısmı
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }
    
    @objc func countDown() {
        
        if timeUp == false {
            counter -= 1
            timerLabel.text = String(counter)
            control()
        }
    }
    
    func control() {
        
        if counter == 0 {
            timer.invalidate()
            timeUp = true
            
            let alert = UIAlertController(title: "Time's up", message: "Do you wanna play again", preferredStyle: .alert)
            
            let noAction = UIAlertAction(title: "No", style: .destructive)
            
            alert.addAction(noAction)
            
            let replay = UIAlertAction(title: "Replay", style: .default) { UIAlertAction in
                self.timeUp = false
                self.counter = 11
                self.timerFonk()
            }
            
            alert.addAction(replay)
            
            self.present(alert, animated: true)
        }
    }
}

