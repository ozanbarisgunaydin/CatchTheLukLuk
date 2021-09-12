//
//  ViewController.swift
//  catchTheLukluk2
//
//  Created by Ozan Barış Günaydın on 20.08.2021.
//

import UIKit

class ViewController: UIViewController {
//    variables
    var score = 0
    var timer = Timer ()
    var counter = 0
    var luklukArray = [UIImageView]()
    var hideTimer = Timer()
    var highscore = 0

//    views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var lukluk1: UIImageView!
    @IBOutlet weak var lukluk2: UIImageView!
    @IBOutlet weak var lukluk3: UIImageView!
    @IBOutlet weak var lukluk4: UIImageView!
    @IBOutlet weak var lukluk5: UIImageView!
    @IBOutlet weak var lukluk6: UIImageView!
    @IBOutlet weak var lukluk7: UIImageView!
    @IBOutlet weak var lukluk8: UIImageView!
    @IBOutlet weak var lukluk9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scoreLabel.text = "Score: \(score)"
//        Highscore Check
        
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighscore == nil {
            highscore = 0
            highscoreLabel.text = "Highscore: \(highscore)"
        }
        if let newScore = storedHighscore as? Int {
            highscore = newScore
            highscoreLabel.text = "Highscore: \(highscore)"
        }
//        images
        lukluk1.isUserInteractionEnabled = true
        lukluk2.isUserInteractionEnabled = true
        lukluk3.isUserInteractionEnabled = true
        lukluk4.isUserInteractionEnabled = true
        lukluk5.isUserInteractionEnabled = true
        lukluk6.isUserInteractionEnabled = true
        lukluk7.isUserInteractionEnabled = true
        lukluk8.isUserInteractionEnabled = true
        lukluk9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        lukluk1.addGestureRecognizer(recognizer1)
        lukluk2.addGestureRecognizer(recognizer2)
        lukluk3.addGestureRecognizer(recognizer3)
        lukluk4.addGestureRecognizer(recognizer4)
        lukluk5.addGestureRecognizer(recognizer5)
        lukluk6.addGestureRecognizer(recognizer6)
        lukluk7.addGestureRecognizer(recognizer7)
        lukluk8.addGestureRecognizer(recognizer8)
        lukluk9.addGestureRecognizer(recognizer9)
        
        luklukArray = [lukluk1,lukluk2,lukluk3,lukluk4,lukluk5,lukluk6,lukluk7,lukluk8,lukluk9]
        
//        Timers
        
        counter = 10
        timeLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideLukluk), userInfo: nil, repeats: true)
        
        hideLukluk()
        
    }
    @objc func hideLukluk() {
        for lukluk in luklukArray {
            lukluk.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(luklukArray.count - 1)))
        luklukArray[random].isHidden = false
    
    }
    
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"

    }
    @objc func countdown() {
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for lukluk in luklukArray {
                lukluk.isHidden = true
//            Highscore
                
                if self.score > self.highscore {
                    self.highscore = self.score
                    highscoreLabel.text = "Highscore: \(highscore)"
                    UserDefaults.standard.set(self.highscore, forKey : "highscore")
                }
                
                
                
//            Alert
            
            let alert = UIAlertController(title: "Time's Up!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: .default) { UIAlertAction in
                
//                Replay Func.
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideLukluk), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
            
            
        }
        
    }

}

}
