//
//  ContentView.swift
//  DropFatherKick
//
//  Created by Сергей Прокопьев on 23.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State var offset: CGSize = .zero

    var body: some View {
        ZStack {
            Color.blue

            Canvas { ctx, size in
                ctx.addFilter(.alphaThreshold(min: 0.4, color: .white))

                ctx.addFilter(.blur(radius: 35))

                ctx.drawLayer { ctx in
                    for index in [0,1] {
                        if let view = ctx.resolveSymbol(id: index) {
                            ctx.draw(view, at: .init(x: size.width / 2, y: size.height / 2))
                        }
                    }
                }

            } symbols: {
                Circle()
                    .frame(width: 120, height: 120)
                    .tag(0)

                Circle()
                    .tag(1)
                    .frame(width: 120, height: 120)
                    .offset(offset)
            }
            .gesture(
                DragGesture()
                    .onChanged { point in
                        offset = point.translation
                    }
                    .onEnded { _ in
                        withAnimation(.interactiveSpring(
                            response: 0.6,
                            dampingFraction: 0.4,
                            blendDuration: 0.4)
                        ) {
                            offset = .zero
                        }
                    }
            )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
