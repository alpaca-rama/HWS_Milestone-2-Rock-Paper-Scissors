//
//  ContentView.swift
//  Milestone-2-Rock-Paper-Scissors
//
//  Created by Luca Capriati on 2022/08/08.
//

import SwiftUI

struct ContentView: View {
    @State private var computerChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var quesetionCount = 1
    @State private var showingResults = false
    
    let moves = ["👊🏼", "✋🏼", "✌🏼"]
    
    var body: some View {
        VStack {
            Spacer()
            Text("Computer has played...")
                .font(.headline)
            Text(moves[computerChoice])
                .font(.system(size: 200))
            
            if shouldWin {
                Text("Which one wins?")
                    .foregroundColor(.green)
                    .font(.title)
            } else {
                Text("Which one loses?")
                    .foregroundColor(.red)
                    .font(.title)
            }
            
            HStack {
                ForEach(0..<3) { number in
                    Button(moves[number]) {
                        play(choice: number)
                    }
                    .font(.system(size: 80))
                }
            }
            
            Spacer()
            
            Text("Score: \(score)")
                .font(.subheadline)
            
            Spacer()
        }
        .alert("Game over", isPresented: $showingResults) {
            Button("Play Again", action: reset)
        } message: {
            Text("Your score was \(score).")
        }
    }
    
    func play(choice: Int) {
        let winningMoves = [1, 2, 0]
        let didWin: Bool
        
        if shouldWin {
            didWin = choice == winningMoves[computerChoice]
        } else {
            didWin = winningMoves[choice] == computerChoice
        }
        
        if didWin {
            score += 1
        } else {
            score -= 1
        }
        
        if quesetionCount == 3 {
            showingResults = true
        } else {
            computerChoice = Int.random(in: 0..<3)
            shouldWin.toggle()
            quesetionCount += 1
        }
    }
    
    func reset() {
        computerChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
        quesetionCount = 0
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
