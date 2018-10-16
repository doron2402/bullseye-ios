//
//  ViewController.swift
//  BullsEye
//
//  Created by Doron Segal on 10/9/18.
//  Copyright © 2018 Doron Segal. All rights reserved.
//

import UIKit

extension CountableRange where Bound == Int {
    var random: Int {
        return lowerBound + numericCast(arc4random_uniform(numericCast(count)))
    }
    func random(_ n: Int) -> [Int] {
        return (0..<n).map { _ in random }
    }
}
extension CountableClosedRange where Bound == Int {
    var random: Int {
        return lowerBound + numericCast(arc4random_uniform(numericCast(count)))
    }
    func random(_ n: Int) -> [Int] {
        return (0..<n).map { _ in random }
    }
}

class ViewController: UIViewController {

    var _currentSliderValue: Int = 0
    var _targetValue: Int = 0
    var _number_of_try: Int = 0
    var _userScore: Int = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var numberOfTryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set a new round
        setNewRound()
        
        //set user score
        updateUserScore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert() {
        var alertMessage = "The slider value is: \(_currentSliderValue)"
        var alertTitle = "try again..."
        if (_currentSliderValue == _targetValue) {
            alertTitle = "you're a natural!"
            alertMessage = "Good Job!!!"
            setNewRound()
            _userScore += 100
            _number_of_try = 0
        } else {
            if (abs(_currentSliderValue - _targetValue) <= 5) {
                alertTitle = "Wow that was close!"
            } else if (abs(_currentSliderValue - _targetValue) > 5 && abs(_currentSliderValue - _targetValue) < 10) {
                alertTitle = "That was pretty good"
            } else {
                alertTitle = "You're off dude!"
            }
            _number_of_try += 1
            _userScore -= abs(_currentSliderValue - _targetValue)
        }
        
        // set a new round after 3 tries
        if (_number_of_try >= 3) {
            setNewRound()
        }
        
        updateUserScore()
        
        numberOfTryLabel.text = "\(String(_number_of_try))/3"
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert )
        let action = UIAlertAction(title: "close", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

    
    func updateUserScore() {
        scoreLabel.text = String(_userScore)
    }
    
    func setNewRound() {
        // set random value
        _targetValue = (1...99).random
        print("Target Value: \(_targetValue)")
        // set slider
        _currentSliderValue = 50
        slider.value = Float(_currentSliderValue)
        updateTargetLabel()
        _number_of_try = 0
        numberOfTryLabel.text = "\(String(_number_of_try))/3"
    }
    
    /**
     Slider move event
     **/
    @IBAction func sliderMoved(_ slider: UISlider) {
        // update current slider value when slider change
        _currentSliderValue = Int(slider.value.rounded()) as Int
        print("Slider value: \(_currentSliderValue)")
        
    }
    
    func updateTargetLabel() {
        targetLabel.text = String(_targetValue)
    }
    
}

