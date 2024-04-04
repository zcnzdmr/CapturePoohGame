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
    var score = 0
    var timer = Timer()
    var timer2 = Timer()
    var highScoreNumber = UserDefaults.standard.integer(forKey: "skorSayisi")
    
    var randomX = 136
    var randomY = 320

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //ekran genişliği ve uzunluğu kısmı
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
        scoreLabel.text = "Score :  \(score)"
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont(name: "Bradley Hand", size: 28)
        view.addSubview(scoreLabel)
        
        //highScoreLabel kısmı
        highScoreLabel.frame = CGRect(x: (screenWidth - 250) / 2 , y: 760, width: 250, height: 35)
        highScoreLabel.text = "Highscore :  \(highScoreNumber)"
        highScoreLabel.font = UIFont(name: "Chalkduster", size: 25)
        highScoreLabel.textAlignment = .center
        view.addSubview(highScoreLabel)
        
        //imageView kısmı
        imageView.frame = CGRect(x: randomX , y: randomY , width: 120, height: 160)
        imageView.image = UIImage(named: "images")
        view.addSubview(imageView)
        
        imageView.isUserInteractionEnabled = true
        let gR = UITapGestureRecognizer(target: self, action: #selector(clicked))
        imageView.addGestureRecognizer(gR)

        timerFonk()
        
    }

    @objc func clicked() {
        score += 1
        scoreLabel.text = "Score : \(score)"
        if self.highScoreNumber < score {
            UserDefaults.standard.set(score, forKey: "skorSayisi")
            highScoreLabel.text = "Highscore :  \(score)"
        }
//        let highScoreUser = UserDefaults.standard.integer(forKey: "skorSayisi")
//    
//        print(highScoreUser)
    }
    
    func timerFonk() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        timer2 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(randomSayi), userInfo: nil, repeats: true)
    }
    
    @objc func randomSayi() {
        randomX = Int.random(in: 10...283)
        randomY = Int.random(in: 190...600)
        imageView.frame = CGRect(x: randomX , y: randomY , width: 120, height: 160)
        if counter == 1 {
            timer2.invalidate()
        }
    }
    
    
    @objc func countDown() {
        
            counter -= 1
            timerLabel.text = String(counter)
            control()
    }
    
    func control() {
        
        if counter == 0 {
            timer.invalidate()
            
            let alert = UIAlertController(title: "Time's up", message: "Do you wanna play again", preferredStyle: .alert)
            
            let noAction = UIAlertAction(title: "No", style: .destructive) { x in
                self.scoreLabel.text = "Score : 0" }
            
            alert.addAction(noAction)
            
            let replay = UIAlertAction(title: "Replay", style: .default) { UIAlertAction in
                self.counter = 11
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.timerFonk()
            }
            
            alert.addAction(replay)
            
            self.present(alert, animated: true)
        }
    }
}

