//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
//MARK:- PROPERTIES
    
    /* 1) On cree les trois variables pour passer la declaration avec If Else et Switch
     let softTime = 5
     let mediumTime = 7
     let hardTime = 12
    */
    
    // 2) On peut faire un variable dans le tableau = array pour passer
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]  // => 1ere etape convertir de minute en seconde
    
    var secondsRemaining = 60  // => on cree cette variable pour garder une trace
    
    // 3) On ajoute la variable time
    var timer = Timer()
    
    //Progression
    var totalTime = 0
    var secondPassed = 0
    
    //Alarme => voir le parametre dans func udapteTimer
    var player: AVAudioPlayer!
    
    
// MARK:- OUTLET
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
//MARK:- ACTION
    
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
    //  print(sender.currentTitle)  => 1) creer le print(sender.currenTitle) et 2) on le supprime car on remplace par let hardness = sender.currenTitle
        
        let hardness = sender.currentTitle!  // => hardness: Soft, Medium, Hard et on ajoute optionel "!" pour la 3 Solution
        
        progressBar.progress = 0.0
        secondPassed = 0
        titleLabel.text = hardness
        

        
        /* 1) SOLUTION: on peut déclarer avec IF-ELSE
         
         if hardness == "Soft" {
             print(softTime)
         } else if hardness == "Medium"{
             print(mediumTime)
         } else {
             print(hardTime)
         }
        
        */
        
        /* 2) SOLUTION: on peut déclarer avec Switch
         
         switch hardness {
         case "Soft":
             print(softTime)
         case "Medium":
             print(mediumTime)
         case "Hard":
             print(hardTime)
         default:
             print("ERROR")
         }
         
        */
        
        
        /* 3) SOLUTION: on peut declarer avec Dictionary
         let result = eggTimes[hardness]!
         
         print(result)
        */

        
        
        // 4) SOLUTION: on garde la solution 3. Seulement on supprime le variable et on le mets par instance
        
        totalTime = eggTimes[hardness]!
        
        //Parametre pour la minuterie
        timer = Timer.scheduledTimer(timeInterval: 1.0, target :self, selector : #selector(updateTimer), userInfo :nil, repeats :true)
        
        
    }
    
    //cette fonction permet afficher le minuterie en seconde
    
    @objc func updateTimer(){
        if secondPassed < totalTime {
            secondPassed += 1
            progressBar.progress = Float(secondPassed) / Float(totalTime)
            print(Float(secondPassed)/Float(totalTime))
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}
