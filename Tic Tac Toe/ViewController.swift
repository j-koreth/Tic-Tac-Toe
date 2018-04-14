//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Joel Koreth on 3/29/18.
//  Copyright © 2018 Joel Koreth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var one: UILabel!
    @IBOutlet weak var two: UILabel!
    @IBOutlet weak var three: UILabel!
    @IBOutlet weak var four: UILabel!
    @IBOutlet weak var five: UILabel!
    @IBOutlet weak var six: UILabel!
    @IBOutlet weak var seven: UILabel!
    @IBOutlet weak var eight: UILabel!
    @IBOutlet weak var nine: UILabel!
    
    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var playerOneScoreLabel: UILabel!
    @IBOutlet weak var playerTwoScoreLabel: UILabel!
    var playerOneScore = 0
    var playerTwoScore = 0
    
    var labelArray = [UILabel]()
    var labelArrayArray = [[UILabel]]()
    var turn = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelArray = [one,two,three,four,five,six,seven,eight,nine]
        
        for index in 0...labelArray.count-1{
            labelArray[index].tag = index + 1
            labelArray[index].isEnabled = false
        }
        
        labelArrayArray.append([labelArray[0],labelArray[1],labelArray[2]])
        labelArrayArray.append([labelArray[3],labelArray[4],labelArray[5]])
        labelArrayArray.append([labelArray[6],labelArray[7],labelArray[8]])
        labelArrayArray.append([labelArray[0],labelArray[3],labelArray[6]])
        labelArrayArray.append([labelArray[1],labelArray[4],labelArray[7]])
        labelArrayArray.append([labelArray[2],labelArray[5],labelArray[8]])
        labelArrayArray.append([labelArray[0],labelArray[4],labelArray[8]])
        labelArrayArray.append([labelArray[2],labelArray[4],labelArray[6]])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        
        if(labelArray[sender.view!.tag - 1].isEnabled == false){
            if(turn % 2 == 0){
                labelArray[sender.view!.tag - 1].text = "X"
                turnLabel.text = "Player 2's Turn"
                turn+=1
            }
            else{
                labelArray[sender.view!.tag - 1].text = "O"
                turnLabel.text = "Player 1's Turn"
                turn+=1
            }
        }
        labelArray[sender.view!.tag - 1].isEnabled = true
        
        determineWin()
        
        if(tieChecker(test: labelArrayArray)){
            let alert = UIAlertController(title: "Tie", message: "No One Won", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                self.reset(winner: 0)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func determineWin(){
        for index in 0...labelArrayArray.count-1{
            if(enabledChecker(test: labelArrayArray[index])){
                if(winChecker(test: labelArrayArray[index], letter: "X") || winChecker(test: labelArrayArray[index], letter: "O")){
                    determineWinner()
                    break;
                }
            }
        }
    }
    
    func tieChecker(test: [[UILabel]]) -> Bool{
        var enabled = true

        for labelArray in test{
            for label in labelArray{
                if(label.isEnabled == false){
                    enabled = false
                }
            }
        }
        
        return enabled
    }
    
    func enabledChecker(test: [UILabel]) -> Bool{
        var enabled = true
        for label in test{
            if(label.isEnabled == false){
                enabled = false
            }
        }
        return enabled
    }
    
    func winChecker(test: [UILabel], letter: String) -> Bool{
        var win = true
        for label in test{
            if(label.text != letter){
                win = false
            }
        }
        return win
    }
    
    func determineWinner(){
        if(turn % 2 != 0){
            let alert = UIAlertController(title: "Win", message: "Player One Won", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                self.reset(winner: 1)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Win", message: "Player Two Won", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                self.reset(winner: 2)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func reset(winner: Int){
        turn = 0
        
        for index in 0...labelArray.count-1{
            labelArray[index].text = ""
            labelArray[index].isEnabled = false
        }
        
        if(winner == 1){
            playerOneScore+=1
            playerOneScoreLabel.text = String(playerOneScore)
        }
        else if(winner == 2){
            playerTwoScore+=1
            playerTwoScoreLabel.text = String(playerTwoScore)
        }
        turnLabel.text = "Player 1's Turn"
    }
    
}

