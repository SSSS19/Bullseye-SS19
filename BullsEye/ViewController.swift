//
//  ViewController.swift
//  BullsEye
//
//  Created by Shehab Saqib on 23/08/2015.
//  Copyright (c) 2015 Shehab Saqib. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController
{
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score: Int = 0
    var round: Int = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabels()
        sliderDesign()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert()
    {
       /* var difference: Int
        if currentValue > targetValue{
            difference = currentValue - targetValue
        } else if targetValue > currentValue {
            difference = targetValue - currentValue
        } else {
            difference = 0
        } */
        
        let difference = abs(targetValue - currentValue)
        var points: Int = 100 - difference
        
        var title: String
        if difference == 0{
            title = "Perfect!"
            points += 100
        }else if difference < 5{
            title = "You almost had it!"
            if difference == 1{
                points += 51
            }
        }else if difference < 15{
            title = "Pretty good!"
        }else{
            title = "Meh!"
        }
        
        score += points
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title,
            message: message,
            preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "Ok", style: .Default,
            handler: {
                action in
                self.startNewRound()
                self.updateLabels()
        })
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func sliderMoved(slider: UISlider)
    {
        currentValue = lroundf(slider.value)
    }
    
    func startNewRound()
    {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func updateLabels()
    {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewGame()
    {
        score = 0
        round = 0
        startNewRound()
    }
    
    @IBAction func startOver()
    {
        startNewGame()
        updateLabels()
        animation()
        
        
    }
    
    private func sliderDesign()
    {
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        if let trackLeftImage = UIImage(named: "SliderTrackLeft"){
            let trackLeftResizeable = trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizeable, forState: .Normal)
        }
        
        if let trackRightImage = UIImage(named: "SliderTrackRight"){
            let trackRightResizeable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizeable, forState: .Normal)
        }
    }
    
    private func animation ()
    {
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        view.layer.addAnimation(transition, forKey: nil)
    }

}

