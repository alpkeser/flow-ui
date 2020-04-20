//
//  MainView.swift
//  flow-ui
//
//  Created by Alp Keser on 17.04.2020.
//  Copyright © 2020 Alp Keser. All rights reserved.
//

import SwiftUI
import Combine



struct MainView: View {
    @ObservedObject var counter: Counter
    var hideOtherViews: Bool {
        return counter.state == .running || counter.state == .paused
    }
    
    var helloText: some View {
        Text("Welcome back!")
            .font(Font.system(size: 32.0, weight: .semibold, design: .default))
            .foregroundColor(Color("primaryText"))
            .minimumScaleFactor(0.8)
    }
    var statsView: StatsView
    
    init (counter: Counter) {
        self.counter = counter
        statsView = StatsView(hideOtherViews: false)
        self.counter.stateChangePublisher.subscribe(statsView.listener)
    }
    
    var body: some View {
        VStack {
            helloText
                .opacity(hideOtherViews ? 0 : 1)
                .animation(.easeInOut(duration: 1))
            CounterView(counter: counter)
            statsView
                .opacity(hideOtherViews ? 0 : 1)
                .animation(.easeInOut(duration: 1))
            Spacer()
        }.padding().background(Color("mainBackground").edgesIgnoringSafeArea(.all))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        return MainView(counter: Counter(sessionTime: 5))
    }
}
