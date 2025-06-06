//
//  StartView.swift
//  SparkTime
//
//  Created by User on 12/31/23.
//

//
//  userInput.swift
//  Material
//
//  Created by User on 12/29/23.


import SwiftUI
import SwiftUI
import SwiftUI
@available(iOS 17.0, *)
struct StartView: View {
	@State private var isPopupVisible = false
	@State private var symbolAnimation = false

	var body: some View {
		VStack {
			VStack {
				// Header
				Text("Sparklists")
					.padding(.horizontal)
					.foregroundStyle(Color.white)
					.font(Font.custom("Quicksand", size: 60))
					.frame(maxWidth: .infinity * 0.90, alignment: .center)

				Text("The best apprentace you'll ever hire.")
					.foregroundStyle(Color.white)
					.font(Font.custom("Quicksand", size: 10).bold())
					.frame(maxWidth: .infinity * 0.90, alignment: .center)


				//				AnimatedGradientDivider()
			}.padding(.vertical, 30)
			Divider().frame(height: 1.0).background(
				Color(dataManager.themeColor)
			).padding(.vertical, 1)
			// Buttons for different options
			Spacer()
			VStack {

				NavigationLink(destination: MaterialListView()) {
					Text("Generate Material List")
						.foregroundStyle(Color.white)
						.padding(.top, 20)
						.padding(.bottom, 20)
						.frame(maxWidth: .infinity, alignment: .center)
						.background(Color("button1"))
						.cornerRadius(5)
						.shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
					
				}
				.buttonStyle(PlainButtonStyle())

				.padding(.horizontal, 0)
				.padding(.top, 0)
				.padding(.bottom, 5)
				.frame(maxWidth: .infinity, alignment: .topLeading)

//
//				NavigationLink(destination: SwipingTimeView()) {
//					Text("Swiping Time View")
//						.foregroundStyle(Color.white)
//						.padding(.top, 20)
//						.padding(.bottom, 20)
//						.frame(maxWidth: .infinity, alignment: .center)
//						.background(Color("button1"))
//						.cornerRadius(5)
//						.shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
//
//				}
//				.buttonStyle(PlainButtonStyle())
//
//				.padding(.horizontal, 0)
//				.padding(.top, 0)
//				.padding(.bottom, 5)
//				.frame(maxWidth: .infinity, alignment: .topLeading)
//
//
//				NavigationLink(destination: JobsView()) {
//					Text("Time Turner-Inner")
//						.foregroundStyle(Color.white)
//						.padding(.top, 20)
//						.padding(.bottom, 20)
//						.frame(maxWidth: .infinity, alignment: .center)
//						.background(Color("button2"))
//						.cornerRadius(5)
//						.shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
//					
//				}
//				.buttonStyle(PlainButtonStyle())
//
//				.padding(.horizontal, 0)
//				.padding(.top, 0)
//				.padding(.bottom, 5)
//				.frame(maxWidth: .infinity, alignment: .topLeading)
//				
//				
				

				NavigationLink(destination: LightCounter()) {
					Text("Device Counter")
						.foregroundStyle(Color.white)
						.padding(.top, 20)
						.padding(.bottom, 20)
						.frame(maxWidth: .infinity, alignment: .center)
						.background(Color("button3"))
						.cornerRadius(5)
						.shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
					
				}
				.buttonStyle(PlainButtonStyle())
				
				.padding(.horizontal, 0)
				.padding(.top, 0)
				.padding(.bottom, 5)
				.frame(maxWidth: .infinity, alignment: .topLeading)
				
				
				NavigationLink(destination: DeviceFinderAPI()) {
					Text("Online Device Counter")
						.foregroundStyle(Color.white)
						.padding(.top, 20)
						.padding(.bottom, 20)
						.frame(maxWidth: .infinity, alignment: .center)
						.background(Color("button3"))
						.cornerRadius(5)
						.shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
					
				}
				.buttonStyle(PlainButtonStyle())
				
				.padding(.horizontal, 0)
				.padding(.top, 0)
				.padding(.bottom, 5)
				.frame(maxWidth: .infinity, alignment: .topLeading)
				
			}
			
			
			
			Spacer()
			Button(action: {
				// Toggle the visibility of the pop-up
				isPopupVisible.toggle()
			}) {
				// Use a system icon
				Image("colorWheel")
					.symbolRenderingMode(.multicolor)
					.onAppear {
						symbolAnimation.toggle()
					}
					.buttonStyle(PlainButtonStyle())
					.symbolEffect(.variableColor.reversing.cumulative, options: .repeat(100).speed(1), value: symbolAnimation)
					.font(.largeTitle)
				// Customize your button's appearance
				
			}.buttonStyle(PlainButtonStyle())

			.popover(isPresented: $isPopupVisible, arrowEdge: .top) {
				ThemeView()
			}
//			NavigationLink(destination: SettingsView()) {
//				Text("Time Turner-Inner")
//					.foregroundStyle(Color.white)
//					.padding(.top, 20)
//					.padding(.bottom, 20)
//					.frame(maxWidth: .infinity, alignment: .center)
//					.background(Color("button2"))
//					.cornerRadius(5)
//					.shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
//				
//			}
//			.buttonStyle(PlainButtonStyle())
//			
//			.padding(.horizontal, 0)
//			.padding(.top, 0)
//			.padding(.bottom, 5)
//			.frame(maxWidth: .infinity, alignment: .topLeading)
			
		}
		
		.padding()
			.background(Color("Color 8"))
		

	}
	
}

//
//struct AnimatedGradientView: View {
//	var colors: [Color] = [.red, .orange, .yellow, .green, .blue, .indigo, .purple]
//	var body: some View {
//		GeometryReader { geometry in
//			AnimatedGradientModifier(colors: colors, width: geometry.size.width)
//				.frame(height: 4) // Set the height of the divider line
//				.mask(Rectangle())
//		}
//	}
//
//	struct AnimatedGradientModifier: View, AnimatableModifier {
//		var colors: [Color]
//		let width: CGFloat
//		var percent: CGFloat = 0
//
//		var animatableData: CGFloat {
//			get { percent }
//			set { percent = newValue }
//		}
//
//		func body(content: Content) -> some View {
//			content.overlay(
//				LinearGradient(gradient: Gradient(colors: colors), startPoint: UnitPoint(x: percent - 1, y: 0), endPoint: UnitPoint(x: percent, y: 0))
//					.frame(width: width)
//					.offset(x: (percent - 1) * width)
//			)
//			.onAppear {
//				withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
//					self.percent = 1
//				}
//			}
//		}
//	}
//}








import SwiftUI

@available(iOS 17.0, *)
struct LandingPageView: View {
	// Define the columns for the grid layout
	let columns = [
		GridItem(.flexible(), spacing: 8), // Add spacing for the gap between tiles
		GridItem(.flexible())
	]
	let horizontalPadding: CGFloat = 16 // Adjust the padding as needed

	var body: some View {
		ZStack {
			if dataManager.isDarkMode {
				blueGradient()
			} else {
				lightblueGradient()
			}
			VStack {
				// Header section
				VStack {
					// Header
					Text("Sparklists")
						.padding(.horizontal)
						.padding(.top, 30)
						.foregroundStyle(Color.white)
						.font(Font.custom("Quicksand", size: 60))
						.frame(maxWidth: .infinity * 0.90, alignment: .center)

					Text("The best apprentace you'll ever hire.")
						.foregroundStyle(Color.white)
						.font(Font.custom("Quicksand", size: 10).bold())
						.frame(maxWidth: .infinity * 0.90, alignment: .center)


					//				AnimatedGradientDivider()
				}.padding(.vertical, 30)
				Divider().frame(height: 1.0).background(
					Color(dataManager.themeColor)
				)
Spacer()

				// Grid of function tiles

				ZStack {
					VStack { // Add spacing for the gap between rows
						HStack {
							FunctionTile(title: "Material List Generator", iconName: "list.bullet.rectangle")

								.frame(width: .infinity)
								.background(
									.ultraThinMaterial,
									in: RoundedRectangle(cornerRadius: 15, style: .continuous)
								)
							FunctionTile(title: "Online Device Count", iconName: "network")
								.frame(width: .infinity)
								.background(
									.ultraThinMaterial,
									in: RoundedRectangle(cornerRadius: 15, style: .continuous)
								)

						}.frame(width: .infinity)
							.padding(.horizontal, horizontalPadding)


						HStack {
							FunctionTile(title: "Time Turner-Inner\n", iconName: "clock.arrow.circlepath")
								
								.frame(width: .infinity)
								.background(
									.ultraThinMaterial,
									in: RoundedRectangle(cornerRadius: 15, style: .continuous)
								)

							FunctionTile(title: "Offline Device Count", iconName: "desktopcomputer")
//										.frame(width: 150)
								
								.frame(width: .infinity)
								.background(
									.ultraThinMaterial,
									in: RoundedRectangle(cornerRadius: 15, style: .continuous)
								)
						}.frame(width: .infinity, height: 200)
						.padding(.horizontal, horizontalPadding) // Add padding to the sides of the HStack


					}
					.frame(width: .infinity, height: .infinity)


				}
				Spacer()
				Spacer()
				HStack {
					Button(action: {}) {
						Label("Settings", systemImage: "gear")
					}
					Spacer()
					Button(action: {}) {
						Label("Support", systemImage: "lifepreserver")
					}
					
				}

				.padding()
			}
			.modifier(DarkModeLightModeBackground())

		}
		.modifier(DarkModeLightModeBackground())

	}
}

// Define a reusable view for the function tiles
@available(iOS 17.0, *)
struct FunctionTile: View {
	var title: String
	var iconName: String

	var body: some View {



			VStack {
				Image(systemName: iconName)
					.font(.largeTitle)
					.foregroundColor(.blue)
				Text(title)
					.fontWeight(.semibold)
			}
			.padding(20)
			.frame(maxWidth: .infinity)
			.background(Color.gray.opacity(0.2))
			.cornerRadius(10)
		
		}


}
@available(iOS 17.0, *)
struct LandingPageView_Previews: PreviewProvider {
	static var previews: some View {
		LandingPageView()
			.environmentObject(DataManager())
	}
}


struct PressableButtonStyle: ButtonStyle {
	@State private var floating = false
	@State private var offsetX: CGFloat = 0
	@State private var offsetY: CGFloat = 0
	// Define the makeBody method required by the ButtonStyle protocol
//	func makeBody(configuration: Configuration) -> some View {
//		configuration.label
//
//			.padding(49)
//			.frame(width: 185, height: 190)
//			.background(BlurView(style: .systemThinMaterialDark))
//
//			.cornerRadius(15)
//			.shadow(radius: 10)
////
////			.scaleEffect(floating ? 0.9 : 1)
////			.animation(floating ? Animation.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0) : nil, value: floating)
////			.offset(x: floating ? -3 : 3, y: floating ? -2 : 3)
//			.offset(x: floating ? -1 : 6, y: floating ? -2 : 9)
//
//			.onAppear() {
//				withAnimation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
//					floating.toggle()
//				}
//			}

		func makeBody(configuration: Configuration) -> some View {
			configuration.label
			// Apply the random offsets to the button
				.padding(49)
				.frame(width: 185, height: 190)
				.background(BlurView(style: .systemThinMaterialDark))
				.cornerRadius(15)
				.shadow(radius: 10)
				.offset(x: offsetX, y: offsetY)
			// Use an onAppear to start the random movement when the view appears
				.onAppear {
					// Create a timer that fires every 0.5 seconds (or any other interval you like)
					Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
						// Generate random offsets within a specified range
						withAnimation(Animation.easeInOut(duration: 5)) {
							offsetX = CGFloat.random(in: -10...10)
							offsetY = CGFloat.random(in: -10...10)
						}
					}
				}
		}

	}

import SwiftUI

@available(iOS 17.0, *)
struct GlassyNavigationView: View {
	// Define grid layout
	@EnvironmentObject var dataManager: DataManager
	let gradient = LinearGradient(
		gradient: Gradient(colors: [.red, .blue]),
		startPoint: .leading,
		endPoint: .center
	)
	private var gridItems = [GridItem(.flexible()), GridItem(.flexible())]
	let colors: [Color] = [.red, .yellow, .green, .blue, .purple, .red]  // Cycled back to red for smooth looping
	@State private var xOffset = 0.0  // Initial offset state

	var body: some View {
		GeometryReader { geometry in

			NavigationView {
				ZStack {
					// Background gradient
					if dataManager.isDarkMode {
						blueGradient().edgesIgnoringSafeArea(.all)
					} else {
						lightblueGradient().edgesIgnoringSafeArea(.all)
					}

					// Rest of the content
					VStack {
						// Header
						VStack {
							Text("Sparklists")
								.padding(.horizontal)
								.foregroundStyle(Color.white)
								.font(Font.custom("Quicksand", size: 60))
								.frame(maxWidth: .infinity * 0.90, alignment: .center)


							Text("The best apprentice you'll ever hire.")
								.foregroundStyle(Color.white)
								.font(Font.custom("Quicksand", size: 10).bold())
								.frame(maxWidth: .infinity * 0.90, alignment: .center)
//							Rectangle()
//								.fill(
//									LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing)
//								)
//								.mask(Rectangle())  // Masking with a rectangle to get a straight line
//								.offset(x: geometry.size.width * xOffset)  // Offset by a fraction of the width
//								.animation(
//									.linear(duration: 2.5).repeatForever(autoreverses: false), value: xOffset
//								)
//								.onAppear {
//									xOffset = -1.0  // Move the gradient to the left initially
//								}
						}.padding(.top, 40)
						Spacer()
						// Using LazyVGrid to create a 2x2 grid layout
						LazyVGrid(columns: gridItems, spacing: 20) {

							NavigationLink(destination: MaterialListView()) {
								VStack {
									Image(systemName: "list.bullet.rectangle") // A relevant icon
										.resizable()

										.aspectRatio(contentMode: .fit)
										.frame(width: 170, height: 50)

										.foregroundStyle(dataManager.isDarkMode ? Color.white: Color(#colorLiteral(red: 0.3906102777, green: 0.7125323415, blue: 0.4830898643, alpha: 1)), Color(#colorLiteral(red: 0.3601351678, green: 0.6613553166, blue: 0.8676148057, alpha: 1)))
									Spacer()

									Divider()
										.frame(height: 2)
										.padding(.horizontal, 19)
										.background(dataManager.isDarkMode ? Color(#colorLiteral(red: 0.3906102777, green: 0.7125323415, blue: 0.4830898643, alpha: 1)) : Color.white)


									Text("Generate")
										.font(Font.custom("Quicksand", size: 19))
										.frame(maxWidth: .infinity * 0.90, alignment: .center)
									Text("Material")
										.font(Font.custom("Quicksand", size: 19))
										.frame(maxWidth: .infinity * 0.90, alignment: .center)
									Text("List")
										.font(Font.custom("Quicksand", size: 19))
										.frame(maxWidth: .infinity * 0.90, alignment: .center)
								}
								.frame(maxWidth: .infinity)
							}
							.buttonStyle(PressableButtonStyle())


							.buttonStyle(PlainButtonStyle())
							NavigationLink(destination: Text("test")) {
								VStack {
									Image("duplex.fill")// Example icon using system names
										.resizable()
										.aspectRatio(contentMode: .fit)
										.frame(width: 50, height: 50)
										.foregroundColor(.white)

									Text("Link")
										.foregroundColor(.white)
								}
								.padding(49)
								.frame(width: 185, height: 190)
								.background(BlurView(style: .systemThinMaterialDark))
								.cornerRadius(15)
								.shadow(radius: 10)
							}
							NavigationLink(destination: Text("test")) {
								VStack {
									Image("duplex.fill") // Example icon using system names
										.resizable()
										.aspectRatio(contentMode: .fit)
										.frame(width: 50, height: 50)
										.foregroundColor(.white)

									Text("Link ")
										.foregroundColor(.white)
								}
								.padding(49)
								.frame(width: 185, height: 190)
								.background(BlurView(style: .systemThinMaterialDark))
								.cornerRadius(15)
								.shadow(radius: 10)
							}
							NavigationLink(destination: Text("Destination")) {
								VStack {
									Image("duplex.fill") // Example icon using system names
										.resizable()
										.aspectRatio(contentMode: .fit)
										.frame(width: 50, height: 50)
										.foregroundColor(.white)

									Text("Link ")
										.foregroundColor(.white)
								}
								.padding(49)
								.frame(width: 185, height: 190)
								.background(BlurView(style: .systemThinMaterialDark))
								.cornerRadius(15)
								.shadow(radius: 10)
							}

						}

						Spacer()
						Spacer()
					}
					sunview()
				}

			}
		}

	}
}

// Custom Blur View to achieve the glass effect
struct BlursView: UIViewRepresentable {
	var style: UIBlurEffect.Style

	func makeUIView(context: Context) -> UIVisualEffectView {
		return UIVisualEffectView(effect: UIBlurEffect(style: style))
	}

	func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
		uiView.effect = UIBlurEffect(style: style)
	}

}

@available(iOS 17.0, *)
struct GlassyNavigationView_Previews: PreviewProvider {
	static var previews: some View {
		GlassyNavigationView()
			.environmentObject(dataManager)

	}
}
