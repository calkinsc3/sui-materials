/// Copyright (c) 2021 Razeware LLC
/// 


import SwiftUI

struct ScoreView: View {
    
    @State private var numberOfAnswered = 0
    let numberOfQuestions: Int
    
    var body: some View {
        
        HStack {
            Text("\(numberOfAnswered)/\(numberOfQuestions)")
                .font(.caption)
                .padding(4)
            Spacer()
        }
        
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(numberOfQuestions: 5)
    }
}
