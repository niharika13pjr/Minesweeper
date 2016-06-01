//
//  ViewController.swift
//  Minesweeper
//
//  Created by niharika pujari on 11/18/15.
//  Copyright © 2015 niharika pujari. All rights reserved.


import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    let BOARD_SIZE:Int = 10
    var board:Board
    var squareButtons:[SquareButton] = []
    var oneSecondTimer:NSTimer?
    required init?(coder aDecoder: NSCoder)
    {
        self.board = Board(size: BOARD_SIZE)
        super.init(coder: aDecoder)
    }
    var moves:Int = 0 {
        didSet {
            self.movesLabel.text = "Moves: \(moves)"
            self.movesLabel.sizeToFit()
        }
    }
    var timeTaken:Int = 0  {
      
        didSet {
            self.timeLabel.text = "Time: \(timeTaken)"
            self.timeLabel.sizeToFit()
        }
    }
    func initializeBoard() {
        for row in 0 ..< board.size {
            for col in 0 ..< board.size {
            let square = board.squares[row][col]
            let squareSize:CGFloat = self.boardView.frame.width / CGFloat(BOARD_SIZE)
                let squareButton = SquareButton(squareModel:square, squareSize: squareSize,squareMargin :squareSize-4);
        squareButton.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        squareButton.addTarget(self, action: "squareButtonPressed:", forControlEvents: .TouchUpInside)
            self.boardView.addSubview(squareButton)
            self.squareButtons.append(squareButton)
            }
        }
    }
    func oneSecond() {
        self.timeTaken++
    }
    func endCurrentGame() {
        self.oneSecondTimer!.invalidate()
        self.oneSecondTimer = nil
    }

    /*func minePressed() {
        // show an alert when you tap on a mine
        var alertView = UIAlertView()
        alertView.addButtonWithTitle("New Game")
        alertView.title = "BOOM!"
        alertView.message = "You tapped on a mine."
        alertView.show()
        alertView.delegate = self
        self.endCurrentGame()
    }*/
    func squareButtonPressed(sender:SquareButton) {
    if(!sender.square.isRevealed) {
        self.moves++
    sender.square.isRevealed = true
    sender.setTitle("\(sender.getLabelText())", forState: .Normal)
      if sender.square.isMineLocation {
       //     self.minePressed()
        }
    }
    }
    
    func resetBoard() {
        // resets the board with new mine locations & sets isRevealed to false for each square
        self.board.resetBoard()
        // iterates through each button and resets the text to the default value
        for squareButton in self.squareButtons {
            squareButton.setTitle("[x]", forState: .Normal)
        }
    }
    func startNewGame() {
        //start new game
        self.resetBoard()
        self.timeTaken = 0
        self.moves = 0
        self.oneSecondTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("oneSecond"), userInfo: nil, repeats: true)
    }
    func alertView(View: UIAlertControllerStyle!, clickedButtonAtIndex buttonIndex: Int) {
        //start new game when the alert is dismissed
        self.startNewGame()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeBoard()
        self.startNewGame()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func newGamePressed() {
        print("new game")
        self.startNewGame()
        self.endCurrentGame()
    }

}

