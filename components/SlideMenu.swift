//
//  SlideMenu.swift
//  SparkTime
//
//  Created by Anthony on 1/31/24.
//
import SwiftUI
import Foundation
@available(iOS 17.0, *)
struct SlideMenu: View {
	@EnvironmentObject var dataManager: DataManager // Access DataManager passed via environmentObject
	@Environment(\.colorScheme) var colorScheme

	
//	@Binding var isShowing: Bool
//	Binding var materialRequirements: [String: [String: Int]]
	@State private var showPopover = false
	@State private var isPopupVisible = false
	@State private var symbolAnimation = false
	@Binding var isShowing: Bool

	var body: some View {
		ZStack {

			// Semi-transparent background
			GeometryReader { geometry in
				EmptyView()
			}
			.background(Color.black.opacity(0.55))
			.opacity(self.isShowing ? 1 : 0)
			.animation(.easeIn(duration: 0.25), value: isShowing)
			.onTapGesture {
				self.isShowing.toggle()
			}
			if isShowing {

				// Menu content
				HStack {
					VStack(alignment: .leading, spacing: 20) {

						HStack() {
							NavigationLink(destination: StartView()) {
								HStack {
									Image(systemName: "house")
										.foregroundStyle(dataManager.isDarkMode ? .white: .black)
									Text("Home")
										.foregroundStyle(dataManager.isDarkMode ? .white: .black)
								}
							}

							.buttonStyle(PlainButtonStyle())

						}
//						HStack {
//							Button(action: {
//								showPopover.toggle()
//							})
//							{
//								HStack {
//									Image(systemName: "gear")
//										.foregroundStyle(dataManager.isDarkMode ? .white: .black)
//									Text("Customize \nMaterial Requirements")
//										.foregroundStyle(dataManager.isDarkMode ? .white: .black)
//								}
//							}
//							.buttonStyle(PlainButtonStyle())
//
//							.foregroundColor(.white)
//							.clipShape(Rectangle())
//							.popover(isPresented: $showPopover) {
//								EditMaterialRequirementsView(
//									materialRequirements: $materialRequirements,
//
//									materialKeys: $dataManager.materialKeys)
//							}
//						}
						HStack {
							HStack {
								Image(systemName: dataManager.isDarkMode ? "moon" : "sun.max")
								Text("Darkmode/Lightmode")
									.foregroundStyle(dataManager.isDarkMode ? .white: .black)
							}						.buttonStyle(PlainButtonStyle())
							//							.onAppear {
							//								dataManager.updateDarkMode(colorScheme: colorScheme)
							//							}
								.onTapGesture {
									withAnimation(Animation.easeInOut(duration: 2.0)) {
										dataManager.isDarkMode.toggle()
									}
								}
								.onChange(of: colorScheme) { newColorScheme in
									dataManager.updateDarkMode(colorScheme: newColorScheme)
								}
								.rotationEffect(.degrees(0))
								.foregroundStyle(dataManager.isDarkMode ? .gray: .yellow)

						}
						HStack {
							Button(action: {
								// Toggle the visibility of the pop-up
								isPopupVisible.toggle()
							}) {
								// Use a system icon
								Image("colorWheel")
									.buttonStyle(PlainButtonStyle())
									.symbolRenderingMode(.multicolor)
									.onAppear {
										symbolAnimation.toggle()

									}

									.symbolEffect(.variableColor.reversing.cumulative, options: .repeat(100).speed(1), value: symbolAnimation)

								// Customize your button's appearance
								Text("Color Theme").foregroundStyle(.white)
									.foregroundStyle(dataManager.isDarkMode ? .white: .black)
							}						.buttonStyle(PlainButtonStyle())
								.popover(isPresented: $isPopupVisible, arrowEdge: .top) {
									ThemeView()
								}
						}
						Spacer()
					}
					.padding(.leading, 1)

					.padding(.top, 100)
					.frame(width: UIScreen.main.bounds.width - ( UIScreen.main.bounds.width / 4))
					.background(dataManager.isDarkMode ? .black: .gray).opacity(0.8)
					.offset(x: self.isShowing ? 0 : -UIScreen.main.bounds.width)
					.animation(.default, value: isShowing)

					Spacer()
				}
			}
			// Menu Button
			Button(action: {
				self.isShowing.toggle()
			}) {
				if self.isShowing {
					Image(systemName: "chevron.compact.backward")
						.buttonStyle(PlainButtonStyle())
						.imageScale(.large)
						.foregroundColor(.black)
						.padding(15)
						.background(Color.white.opacity(0.4))
						.clipShape(Circle())
					
				}
				else {
					Image(systemName: "chevron.compact.forward")
						.buttonStyle(PlainButtonStyle())
						.imageScale(.large)
						.foregroundColor(.black)
						.padding(15)
						.background(Color.white.opacity(0.4))
						.clipShape(Circle())
				}
			}
			.position(x: 30, y: UIScreen.main.bounds.height / 2) // Positioned on the left side, vertically centered
			.animation(.easeIn(duration: 0.25), value: isShowing)
			
		}
		.edgesIgnoringSafeArea(.all) // Ensures the view extends to the edges of the screen
	}
}
class MenuViewModel: ObservableObject {
	@Published var isShowing: Bool = false
}

@available(iOS 17.0, *)
struct MainView: View {
	@StateObject private var menuViewModel = MenuViewModel()

	var body: some View {
		ZStack(alignment: .topLeading) {
			// Your main content here

                        // Spring menu button disabled for consistency
//                      Spring(isShowing: $menuViewModel.isShowing)

			if menuViewModel.isShowing {
				SlideMenu(isShowing: $menuViewModel.isShowing)
					.frame(width: 300)
					.transition(.move(edge: .leading))
			}
		}
		.animation(.default, value: menuViewModel.isShowing)
	}
}
