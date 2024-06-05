//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Alfredo Perry on 6/5/24.
//

import SwiftUI

let rpsChoices: [String] = ["🪨","📄","✂️"]
let winLose: [String] = ["Win", "Lose"]
var score = 0


struct cpuTitle: View{
    var cpuChoice: String
    var body: some View{
        Text(cpuChoice)
            .font(.custom("Test", size: 80))
    }
}

struct ContentView: View {
    var body: some View {
        //Hardcoding the random values because these inputs should never change
        var rpsChoice = rpsChoices[Int.random(in: 0...2)]
        var winLoseChoice = winLose[Int.random(in: 0...1)]
        VStack {
            Text("Choose the correct option \nthat completes the scenario")
            Spacer()
            VStack{
                cpuTitle(cpuChoice: "\(winLoseChoice)")
                    .foregroundStyle(winLoseChoice == "Win" ? .green : .red)
                cpuTitle(cpuChoice: "\(rpsChoice)")
            }
            Spacer()

            buttonView()
            
            Spacer()
            Text("\(score)")
        }
        .padding()
    }
    
    
    struct buttonView: View {
        var correctAnswer: String
        var body: some View {
            HStack{
                ForEach(rpsChoices, id: \.self){ rpsChoice in
                    Button{
                        buttonPressed(rpsChoice: "hey", playerChoice: "hey")
                    } label: {
                        Text("\(rpsChoice)")
                    }
                }
            }
        }
    }
    
    func buttonPressed(rpsChoice: String, playerChoice: String){
        if(rpsChoice == playerChoice){
            score += 10
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
