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
//    var subscriber: Any? //to what?
    var hideOtherViews: Bool {
        return counter.state == .running || counter.state == .paused
    }
    var helloText: some View {
        Text("Welcome back!").font(Font.system(size: 32.0, weight: .semibold, design: .default)).foregroundColor(Color("primaryText")).minimumScaleFactor(0.8)
    }
    
    init () {
        self.counter = Counter(sessionTime: 25*60)
//        self.counter.stateChangePublisher.subscribe(statsView)
    }
    
    var body: some View {
            VStack {
                        helloText
                CounterView(counter: counter)
                    
            //            StatsView(hideOtherViews: hideOtherViews)
                Spacer()
            }.padding().background(Color("mainBackground").edgesIgnoringSafeArea(.all))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        return MainView()
    }
}
