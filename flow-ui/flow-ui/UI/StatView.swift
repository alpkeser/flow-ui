//
//  StatView.swift
//  flow-ui
//
//  Created by Alp Keser on 20.04.2020.
//  Copyright © 2020 Alp Keser. All rights reserved.
//

import SwiftUI

struct StatView: View {
    var title: String
    var value: String
    
    var line: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 150, y: 0))
        }
        .stroke(Color.black, lineWidth: 1)
    }
    
    var titleText: some View {
        Text(title).fontWeight(.medium).foregroundColor(Color("primaryText"))
    }
    
    var valueText: some View {
        Text(value).foregroundColor(Color("primaryText"))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            line.frame(width: 150, height: 1, alignment: .leading)
            titleText
            valueText
                
        })
        
    }
}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        StatView(title: "Today", value: "3 sessions")
    }
}
