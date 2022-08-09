//
//  ContentView.swift
//  Milestone-2-Rock-Paper-Scissors
//
//  Created by Luca Capriati on 2022/08/08.
//

import SwiftUI

struct ContentView: View {
    @State private var appChoice = Int.random(in: 0...2)
    @State private var appWinOrLose = Bool.random()
    @State private var playerScore = 0
    
    let possibleMoves = ["Rock", "Paper", "Scissors"]
    let winningMoves = ["Paper", "Scissors", "Rock"]
    let losingMoves = ["Scissors", "Rock", "Paper"]
    
    var appWinOrLoseText: String {
        var condition: String
        
        if appWinOrLose == true {
                condition = "Win"
        } else {
            condition = "Lose"
        }
        
        return condition
    }
    
    var body: some View {
        VStack {
            Text("Player Score: \(playerScore)")
            Spacer()
            if appWinOrLoseText == "Win" {
                VStack {
                    Text("BEAT")
                        .foregroundColor(.green)
                        .font(.title.bold())
                    Text(possibleMoves[appChoice])
                        .font(.largeTitle.bold())
                }
            } else if appWinOrLoseText == "Lose" {
                VStack {
                    Text("LOSE TO")
                        .foregroundColor(.red)
                        .font(.title2.bold())
                    Text(possibleMoves[appChoice])
                        .font(.title.bold())
                }
            }
            Spacer()
            HStack {
                ForEach(0..<3) {number in
                    Button {
                        playerChoice(number)
                    } label: {
                        Text(possibleMoves[number])
                            .font(.largeTitle.bold())
                            .foregroundColor(appWinOrLoseText == "Win" ? .green : .red)
                    }
                }
            }
        }
    }
    
    func playerChoice(_ number: Int) {
        if appWinOrLoseText == "Win" {
            if possibleMoves[number] == winningMoves[appChoice] {
                correctChoice()
            } else if possibleMoves[number] == possibleMoves[appChoice] {
                draw()
            } else {
                incorrectScore()
            }
        } else if appWinOrLoseText == "Lose" {
            if possibleMoves[number] == losingMoves[appChoice] {
                correctChoice()
            } else if possibleMoves[number] == possibleMoves[appChoice] {
                draw()
            } else {
                incorrectScore()
            }
        }
        
        next()
    }
    
    func correctChoice() {
        playerScore += 1
        print("CORRECT")
    }
    
    func incorrectScore() {
        playerScore -= 1
        print("INCORRECT")
        
        if playerScore < 0 { playerScore = 0 }
    }
    
    // future functionality, if wanted
    func draw() {
        playerScore += 0
        print("DRAW")
    }
    
    func next() {
        appChoice = Int.random(in: 0...2)
        appWinOrLose = Bool.random()
    }
    
    func reset() {
        playerScore = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
