//
// Copyright © 2024 Anthony. All rights reserved.
// 

//
//  ChainedSpring.swift

//  Learning SwiftUI Spring Animations: The Basics and Beyond
//  Hint: Apply a different delay to each oval the achieve this spring effect.
//
//  Created by Amos from getstream.io
//

import SwiftUI

struct ChainedSpring: View {
	@State var moving: Bool

	@State var color2: Color  // Changed to Color directly instead of String
	@State var color3: Color  // Changed to Color directly instead of String



	var body: some View {
		let gradient = LinearGradient(
			gradient: Gradient(colors: [color2, color3]),
			startPoint: .leading,
			endPoint: .center
		)
		ZStack{
			Circle() // One
			
				.stroke(gradient, lineWidth: 5)
				.frame(width: 20, height: 20)
				.rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
				.offset(y: moving ? 75 : -90)
				.animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true), value: moving)
			Circle()  // Two
				.stroke(gradient, lineWidth: 5)
				.frame(width: 50, height: 50)
				.rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
				.offset(y: moving ? 75 : -90)
				.animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.1), value: moving)

			Circle()  // Three
				.stroke(gradient, lineWidth: 5)
				.frame(width: 80, height: 80)
				.rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
				.offset(y: moving ? 75 : -90)
				.animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.2), value: moving)

			Circle()  // Four
				.stroke(gradient, lineWidth: 5)
				.frame(width: 140, height: 140)				.frame(width: 110, height: 110)
				.rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
				.offset(y: moving ? 75 : -90)
				.animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.3), value: moving)

			Circle()  // Five
				.stroke(gradient, lineWidth: 5)
				.frame(width: 140, height: 140)
				.rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
				.offset(y: moving ? 75 : -90)
				.animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.4), value: moving)

			Circle()  // Six
				.stroke(gradient, lineWidth: 5)
				.frame(width: 170, height: 170)
				.rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
				.offset(y: moving ? 75 : -90)
				.animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.5), value: moving)

			Circle()  // Seven
				.stroke(gradient, lineWidth: 5)
				.frame(width: 200, height: 200)
				.rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
				.offset(y: moving ? 75 : -90)
				.animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.6), value: moving)

			Circle()  // Eight
				.stroke(gradient, lineWidth: 5)
				.frame(width: 230, height: 230)
				.rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
				.offset(y: moving ? 75 : -90)
				.animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.7), value: moving)
			ChainedSpring2(moving: true, color2: .red, color3: .blue)
			ChainedSpring3()
		}
		.onAppear{
			moving.toggle()
		}
	}

}

struct ChainedSpring_Previews: PreviewProvider {
	static var previews: some View {
		ChainedSpring(moving: true, color2: .pink, color3: .blue )
			.preferredColorScheme(.dark)
	}
}


struct ChainedSpring2: View {
	@State var moving: Bool

	@State var color2: Color  // Changed to Color directly instead of String
	@State var color3: Color  // Changed to Color directly instead of String



	var body: some View {
		let gradient = LinearGradient(
			gradient: Gradient(colors: [color2, color3]),
			startPoint: .leading,
			endPoint: .center
		)
		ZStack{
			Circle() // One

				.stroke(gradient, lineWidth: 5)
				.frame(width: 20, height: 20)
				.rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
				.offset(y: moving ? -75 : 90)
				.animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true), value: moving)
			Circle()  // Two
				.stroke(gradient, lineWidth: 5)
				.frame(width: 50, height: 50)
				.rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
				.offset(y: moving ? -75 : 90)
				.animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.1), value: moving)

			Circle()  // Three
				.stroke(gradient, lineWidth: 5)
				.frame(width: 80, height: 80)
				.rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
				.offset(y: moving ? -75 : 90)
				.animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.2), value: moving)

			Circle()  // Four
				.stroke(gradient, lineWidth: 5)
				.frame(width: 140, height: 140)				.frame(width: 110, height: 110)
				.rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
				.offset(y: moving ? -75 : 90)
				.animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.3), value: moving)

			Circle()  // Five
				.stroke(gradient, lineWidth: 5)
				.frame(width: 140, height: 140)
				.rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
				.offset(y: moving ? -75 : 90)
				.animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.4), value: moving)

			Circle()  // Six
				.stroke(gradient, lineWidth: 5)
				.frame(width: 170, height: 170)
				.rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
				.offset(y: moving ? -75 : 90)
				.animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.5), value: moving)

			Circle()  // Seven
				.stroke(gradient, lineWidth: 5)
				.frame(width: 200, height: 200)
				.rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
				.offset(y: moving ? -75 : 90)
				.animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.6), value: moving)

			Circle()  // Eight
				.stroke(gradient, lineWidth: 5)
				.frame(width: 230, height: 230)
				.rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
				.offset(y: moving ? -75 : 90)
				.animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.7), value: moving)
		}
		.onAppear{
			moving.toggle()
		}
	}

}

struct ChainedSpring3: View {
	@State private var moving = false
	@State private var color1 = Color.red
	@State private var color2 = Color.blue

	var body: some View {
		let gradient = LinearGradient(
			gradient: Gradient(colors: [color1, color2]),
			startPoint: .leading,
			endPoint: .trailing
		)

		ZStack {
			ForEach(0..<8) { index in
				Circle()
					.stroke(gradient, lineWidth: 5)
					.frame(width: CGFloat(10 + index * 15), height: CGFloat(10 + index * 15))
					.rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
					.offset(y: moving ? 75 : -90)
					.animation(
						.interpolatingSpring(stiffness: 100, damping: 5)
						.repeatForever(autoreverses: true)
						.delay(Double(index) * 0.05),
						value: moving
					)
			}
		}
		.onAppear {
			moving.toggle()
			// Start the color animation
			withAnimation(.easeInOut(duration: 10).repeatForever(autoreverses: true)) {
				color1 = .green
				color2 = .orange
				
			}
		}
	}
}

struct ChainedSpring4: View {
	@State private var moving = false
	@State private var color1 = Color.red
	@State private var color2 = Color.blue
	@State var exitTriggered = false

	var body: some View {
		let gradient = LinearGradient(
			gradient: Gradient(colors: [color1, color2]),
			startPoint: .leading,
			endPoint: .trailing
		)
		VStack {
			Button("Trigger Exit") {
				exitTriggered = true
			}.foregroundColor(.white)
				.background(Color.green)
			ZStack {
				ForEach(0..<8) { index in
					Circle()
						.stroke(gradient, lineWidth: 5)
						.frame(width: CGFloat(5 + index * 15), height: CGFloat(15 + index * 15))
						.rotation3DEffect(.degrees(75), axis: (x: 5, y: 0, z: 0))
						.offset(y: calculateOffset(index: index * 100))
						.animation(
							getAnimation(for: index),
							value: moving
						)
				}
			}
			.onAppear {
				moving.toggle()
				withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
					color1 = .green
					color2 = .orange
				}
			}
		}
	}

	private func calculateOffset(index: Int) -> CGFloat {
		if exitTriggered {
			return -200 // Move all circles upwards out of the view
		} else {
			return moving ? 75 : -90
		}
	}

	private func getAnimation(for index: Int) -> Animation {
		if exitTriggered {
			// Linear movement out of the view, with increasing delay
			return Animation.linear(duration: 0.5).delay(0.05 * Double(index))
		} else {
			// Original spring animation
			return Animation.interpolatingSpring(stiffness: 100, damping: 5)
				.repeatForever(autoreverses: true)
				.delay(0.05 * Double(index))
		}
	}
}

struct ChainedSpring_Previews4: PreviewProvider {
	static var previews: some View {
		ChainedSpring4(exitTriggered: false)
	}
}

struct Spring: View {
	@Binding var isShowing: Bool

	@State private var isRotating = false
	@State private var isHidden = false

	var body: some View {
		VStack(spacing: 14){

			Rectangle() // top
				.frame(width: 64, height: 10)
				.cornerRadius(4)
				.rotationEffect(.degrees(isRotating ? 48 : 0), anchor: .leading)

			Rectangle() // middle
				.frame(width: 64, height: 10)
				.cornerRadius(4)
				.scaleEffect(isHidden ? 0 : 1, anchor: isHidden ? .trailing: .leading)
				.opacity(isHidden ? 0 : 1)

			Rectangle() // bottom
				.frame(width: 64, height: 10)
				.cornerRadius(4)
				.rotationEffect(.degrees(isRotating ? -48 : 0), anchor: .leading)
		}
		.animation(.spring(), value: isShowing)
		.onTapGesture {
			withAnimation {
				isShowing.toggle()
			}
		}
		.onTapGesture {
			withAnimation(.spring()){
				isRotating.toggle()
				isHidden.toggle()
				
			}
		}

	}
}

//struct Spring_Previews: PreviewProvider {
//	@StateObject private var menuViewModel = MenuViewModel()
//	@State private var isloading = true
//	static var previews: some View {
//		Spring(isShowing: $isloading)
//			.preferredColorScheme(.dark)
//	}
//}
