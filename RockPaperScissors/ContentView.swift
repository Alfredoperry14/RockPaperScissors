//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Alfredo Perry on 6/5/24.
//

import SwiftUI

let rpsChoices: [String] = ["🪨","📄","✂️"]
let winLose: [String] = ["Win", "Lose"]


struct cpuChoiceView: View{
    var cpuChoice: String
    var body: some View{
        Text(cpuChoice)
            .font(.custom("cpuChoice", size: 80))
    }
}

struct playerChoiceView: View {
    var rps: String
    var body: some View {
        Text(rps)
            .frame(maxWidth: .infinity)
            .font(.custom("playerChoice", size: 70))
            .background(
                Circle()
                    .padding(-10)
            )
    }
}

struct ContentView: View {
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var reset = false
    
    @State var prevRPS = "none"
    @State var rpsChoice = rpsChoices[Int.random(in: 0...2)]
    @State var winLoseChoice = winLose[Int.random(in: 0...1)]
    @State var questions = 0
    
    
    
    var body: some View {
        
        //Hardcoding the random values because these inputs should never change
        VStack {
            Text("Choose the correct option that completes the scenario")
                .font(.title)
                .multilineTextAlignment(.center)
            Spacer()
            
            VStack{
                cpuChoiceView(cpuChoice: "\(winLoseChoice)")
                    .foregroundStyle(winLoseChoice == "Win" ? .green : .red)
                cpuChoiceView(cpuChoice: "\(rpsChoice)")
            }
            Spacer()
            
            HStack{
                ForEach(rpsChoices, id: \.self){ rps in
                    Button{
                        buttonPressed(playerChoice: "\(rps)")
                    } label: {
                        playerChoiceView(rps: "\(rps)")
                    }
                    .foregroundStyle(winLoseChoice == "Win" ? .green : .red)
                }
                
            }
            
            Spacer()
            Text("Score: \(score)")
                .font(.title2)
                .bold()
            
        }
        
        .alert(scoreTitle, isPresented: $reset){
            Button("Reset", action: resetGame)
        } message: {
            Text("You got \(score) out of 100")
        }
        
    }
    
    func resetGame(){
        score = 0
        questions = 0
        randomizeRPS()
    }
    
    func buttonPressed(playerChoice: String){
        let correctChoice = correctAnswer(rpsChoice, scenario: winLoseChoice)
        if(correctChoice == playerChoice){
            score += 10
        }
        
        if(questions == 9){
            reset = true
        }
        questions += 1
        
        randomizeRPS()
    }
    
    //Randomizes the rock paper scissors scenario
    func randomizeRPS(){
        prevRPS = rpsChoice
        while(prevRPS == rpsChoice){
            rpsChoice = rpsChoices[Int.random(in: 0...2)]
            winLoseChoice = winLose[Int.random(in: 0...1)]
        }
    }
    
    func correctAnswer(_ rpsChoice:String, scenario winLose: String ) -> String{
        switch winLose {
        case "Win":
            switch rpsChoice{
            case "🪨": return "📄"
            case "📄": return "✂️"
            case "✂️": return "🪨"
            default: return "Error"
            }
        case "Lose":
            switch rpsChoice{
            case "🪨": return "✂️"
            case "📄": return "🪨"
            case "✂️": return "📄"
            default: return "Error"
            }
        default:
            return "Error"
        }
    }
}


#Preview {
    ContentView()
}
