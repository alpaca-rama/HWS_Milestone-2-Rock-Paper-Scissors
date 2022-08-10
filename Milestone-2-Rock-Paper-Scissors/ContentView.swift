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
    @State private var question = 1
    @State private var questionsAlert = false
    
    let numberOfQuestions = 10
    
    let possibleMoves = ["Rock", "Paper", "Scissors"]
    let winningMoves = ["Paper", "Scissors", "Rock"]
    let losingMoves = ["Scissors", "Rock", "Paper"]
    let emojiMoves = ["👊🏼", "✋🏼", "✌🏼"]
    
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
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            VStack {
                Text("Question \(question) of \(numberOfQuestions)")
                    .font(.system(size: 25))
//                Text("Player Score: \(playerScore)")
                Spacer()
                if appWinOrLoseText == "Win" {
                    VStack {
                        Text("BEAT")
                            .foregroundColor(.green)
                            .font(.title.bold())
                        Text(emojiMoves[appChoice])
                            .font(.system(size: 80))
                    }
                } else if appWinOrLoseText == "Lose" {
                    VStack {
                        Text("LOSE TO")
                            .foregroundColor(.red)
                            .font(.title2.bold())
                        Text(emojiMoves[appChoice])
                            .font(.system(size: 80))
                    }
                }
                Spacer()
                HStack {
                    ForEach(0..<3) {number in
                        Button {
                            playerChoice(number)
                        } label: {
                            Text(emojiMoves[number])
                                .font(.system(size: 80))
                                .foregroundColor(appWinOrLoseText == "Win" ? .green : .red)
                        }
                    }
                }
                
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
        }
        .alert("You scored: \(playerScore) points", isPresented: $questionsAlert) {
            Button("no") { }
            Button("YES", action: reset)
        } message: {
            Text("Do you want to play again?")
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
        
        nextQuestion()
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
    
    func nextQuestion() {
        if question < numberOfQuestions {
            appChoice = Int.random(in: 0...2)
            appWinOrLose = Bool.random()
            question += 1
        } else {
            questionsAlert = true
        }
    }
    
    func reset() {
        playerScore = 0
        question = 0
        nextQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
