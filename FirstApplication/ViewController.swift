//
//  ViewController.swift
//  FirstApplication
//
//  Created by Panindra Tumkur Seetharamu on 5/23/15.
//  Copyright (c) 2015 Panindra Tumkur Seetharamu. All rights reserved.
//

import UIKit
import CleanroomLogger
import SQLite

class ViewController: UIViewController {

    @IBOutlet weak var firstCardImageType: UIImageView!
    @IBOutlet weak var secondImageType: UIImageView!
    @IBOutlet weak var playRoundButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var playerScore: UILabel!
    @IBOutlet weak var Scores: UILabel!

    @IBOutlet weak var enemyScore: UILabel!
    let playerOne = "PlayerOne"
    let playerTwo = "PlayerTwo"
<<<<<<< HEAD
    let db = Database("/Users/ptumkurseetharamu/Desktop/projects/FirstApplication/sample")
=======
    let db = Database("/Users/ptumkurseetharamu/Desktop/FirstApplication/sample")
>>>>>>> 911368c3341688209230b0ee90302b8acec95dbb
    let name = Expression<String?>("name")
    let numberOfWins = Expression<String?>("numberOfWins")

    let maximumRound = 5
    var playerScoreTotal = 0
    var enemyScoreTotal = 0

    var cardNamesArray:[String] = ["ace", "card2", "card3", "card4", "card5", "card6", "card7", "card8", "card9", "card10", "jack", "queen", "king",]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.playRoundButton.setTitle("Play", forState: UIControlState.Normal)
        let players = db["players"]
        var tableExits = true

        //players.insert(name <- playerOne, numberOfWins <- "0")
        //players.insert(name <- playerTwo, numberOfWins <- "0")

        updateScores()
        /*db.create(table: users, ifNotExists: true) { t in    // CREATE TABLE "users" (
            t.column(name)                 //     "name" TEXT
            t.column(numberOfWins)
            tableExits = false
        }*/

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        Log.info?.message("Using Info Logchannel")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func playRoundTapped(sender: UIButton) {
        if self.playerScoreTotal == maximumRound {
            self.showAlert(playerOne)
            return
        }else if self.enemyScoreTotal == maximumRound {
            self.showAlert(playerTwo)
            return
        }

        var randomNum1 = arc4random_uniform(13)
        var randomNum2 = arc4random_uniform(13)

        Log.verbose?.value(randomNum2)
      
        self.firstCardImageType.image = UIImage(named: cardNamesArray[Int(randomNum1)])
        self.secondImageType.image = UIImage(named: cardNamesArray[Int(randomNum2)])


        //Determine the higher card
        if randomNum1 > randomNum2  {
            self.playerScoreTotal+=1
            self.playerScore.text = String(playerScoreTotal)

        } else if randomNum1 == randomNum2 {
            //It is a Tie
        } else {
            self.enemyScoreTotal+=1
            self.enemyScore.text = String(enemyScoreTotal)
        }
    }

    func showAlert(playerName: String) {
        let players = db["players"]
        println(playerName)
        var numberOfGamesWonByPlayer: Int = 0

        for player in players.select(name, numberOfWins).filter(name == playerName) {
            println("Name: \(player[name]), numberOfWins: \(player[numberOfWins])")
            numberOfGamesWonByPlayer = player[numberOfWins]!.toInt()!
        }

        Log.info?.message("Number of games won is : \(numberOfGamesWonByPlayer)")
        let player = players.filter(name == playerName)
        player.update(numberOfWins <- "\(numberOfGamesWonByPlayer + 1)")

        //Update UI
<<<<<<< HEAD
        resetScores()
=======
        self.playerScore.text = String(0)
        self.enemyScore.text = String(0)

        self.playerScoreTotal = 0
        self.enemyScoreTotal = 0

>>>>>>> 911368c3341688209230b0ee90302b8acec95dbb
        updateScores()
        //users.insert(name <- "\(player)",  numberOfWins <- )
        let alertController = UIAlertController(title: "End of WarGame", message:
        "Game Over! \(playerName) won!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    func updateScores() {
        Log.debug?.trace()
        let players = db["players"]
        var player_scores = [Int]()
        var payer_score = "Score :"
        for player in players.select(numberOfWins) {
            payer_score += "\(player[numberOfWins]!.toInt()!)  "
        }

        self.Scores.text = payer_score
    }
<<<<<<< HEAD

    @IBAction func resetScores(sender: AnyObject) {
        let players = db["players"]
        let player = players.filter(name == playerOne)
        player.update(numberOfWins <- "\(0)")
        let secondPlayer = players.filter(name == playerTwo)
        secondPlayer.update(numberOfWins <- "\(0)")
        resetScores()
        updateScores()

    }

    func resetScores() {
        self.playerScore.text = String(0)
        self.enemyScore.text = String(0)

        self.playerScoreTotal = 0
        self.enemyScoreTotal = 0

    }

=======
>>>>>>> 911368c3341688209230b0ee90302b8acec95dbb
}

