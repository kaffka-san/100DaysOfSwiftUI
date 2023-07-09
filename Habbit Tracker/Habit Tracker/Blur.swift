//
//  Blur.swift
//  WeatherApp
//
//  Created by Anastasia Lenina on 07.07.2023.
//

import SwiftUI

class UIBackDropView: UIView {
    override class var layerClass: AnyClass {
        NSClassFromString("CABackdropLayer") ?? CALayer.self
    }
}
struct Backdrop: UIViewRepresentable {
    func makeUIView(context: Context) -> UIBackDropView {
        UIBackDropView()
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {

    }
}
struct Blur: View {
    var radius: CGFloat = 3
    var opaque: Bool = false
    var body: some View {
       Backdrop()
            .blur(radius: radius, opaque: opaque)
    }
}

struct Blur_Previews: PreviewProvider {
    static var previews: some View {
        Blur()
    }
}
extension View {
    func backgroundBlur(radius: CGFloat = 3, opaque: Bool = false) -> some View {
        self
            .background(
                Blur(radius: radius, opaque: opaque)
            )
    }
}
extension Color {
    static let mainColor = Color("mainColor")
}
