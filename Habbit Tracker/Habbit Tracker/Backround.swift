//
//  Backround.swift
//  Habbit Tracker
//
//  Created by Anastasia Lenina on 09.07.2023.
//

import SwiftUI
import Liquid
struct BackroundAnimation: View {
    var body: some View {

        ZStack {
            Rectangle()
                .fill(.black)
                .ignoresSafeArea()
            Liquid(samples: 3, period: 10.0)
                .frame(width: 500, height: 600)
                .foregroundColor(.blue)
                .opacity(0.5)
                .blur(radius: 10)
                .blendMode(.screen)
            Liquid(samples: 4, period: 8.0)
                .frame(width: 450, height: 240)
                .foregroundColor(.pink)
                .opacity(0.7)
                .blur(radius: 10)
                .blendMode(.screen)
            Liquid(samples: 12, period: 43.0)
                .frame(width: 300, height: 550, alignment: .topTrailing)
                .foregroundColor(.purple)
                .opacity(0.5)
                .blur(radius: 15)
                .blendMode(.screen)
                .shadow(radius: 6)
        }
    }
}

struct Backround_Previews: PreviewProvider {
    static var previews: some View {
        BackroundAnimation()
    }
}
extension View {
    func backgroundAnimation() -> some View {
        self
            .background(
                BackroundAnimation()
            )
    }
}
