//
//  ContentView.swift
//  Phyllotaxis
//
//  Created by Cédric Bahirwe on 25/08/2022.
//

import SwiftUI

// In botany, phyllotaxis (from Ancient Greek φύλλον (phúllon) 'leaf', and τάξις (táxis) 'arrangement')
// or phyllotaxy is the arrangement of leaves on a plant stem.
// Phyllotactic spirals form a distinctive class of patterns in nature.
struct Point: Hashable {
    let x: CGFloat
    let y: CGFloat
    let color: Color
}
struct ContentView: View  {
    @State var n: Int = 0
    @State var c: CGFloat = 4

    @State var width: CGFloat = 400
    @State var height: CGFloat = 400

    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State private var points: [Point] = []
    var myGradient = Gradient(
        colors: [
            Color.black,
            .pink,
            .purple
        ]
    )
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ZStack {
                ForEach(points, id:\.self) { pt in
                    Circle()
                        .fill(pt.color)
                        .frame(width: 4, height: 4)
                        .position(x: pt.x, y: pt.y)
                }
            }
            .frame(width: 400, height: 400)
            .background(Color.black)
            .onReceive(timer, perform: { _ in
                draw()
            })
        }
    }

    func draw() {
        let a = CGFloat(n) * 137.5
        let r = c * sqrt(CGFloat(n))

        let x = r * cos(a) + width/2;
        let y = r * sin(a) + height/2;

        let remainder = CGFloat(a - r).truncatingRemainder(dividingBy: 256) / 255

        let ptColor = Color(hue: Double(remainder),
                            saturation: 1,
                            brightness: 1)
        let newPoint = Point(x: x, y: y, color: ptColor)
        points.append(newPoint)

        n += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
