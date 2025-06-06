//
//  MaterialListView.swift
//  SparkTime
//
//  Created by User on 12/30/23.
//
import Foundation
import SwiftUI
import SwiftUIVisualEffects

// Add other properties as needed
struct Material: Identifiable, Decodable {
    var id: Optional<Int>
    var name: String
    var quantity: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case quantity
        case projectId = "project_id"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        quantity = try container.decode(Int.self, forKey: .quantity)
      
    }
}

@available(iOS 17.0, *)
struct MaterialFormView: View {
	@EnvironmentObject var dataManager: DataManager
    @State private var isSaved: Bool = false
    @State private var isFetched: Bool = false

    @State private var bracketBoxDuplex = ""
    @State private var gfci = ""
    @State private var cutin = ""
    @State private var surfaceMounted = ""
    @State private var controlled = ""

    @State private var quadBracketBox = ""
    @State private var quadGFCI = ""
    @State private var quadCutIn = ""
    @State private var quadSurfaceMounted = ""

    @State private var wire3FurnitureFeed = ""
    @State private var wire2FurnitureFeed = ""

    @State private var bracketBoxData = ""
    @State private var cutInData = ""

    @State private var lineVoltageDimmingSwitch = ""
    @State private var lineVoltageDimmingCutin = ""

    @State private var lvCat5Switch = ""
    @State private var lvCat5Cutin = ""

    @State private var lineVoltageSwitch = ""
    @State private var lineVoltageCutIn = ""

    @State private var inFloorDevice = ""
    @State private var in6FloorDevice = ""
    @State private var singlePole277V40AInstahot = ""
    @State private var pole208V40AInstahot = ""
    @State private var singlePole277V30AInstahot = ""

    @State private var materials: [Material] = []

	var body: some View {
		ZStack {
			
			VStack {
				Form {
					Section(header: Text("Single Gang Devices").foregroundStyle(dataManager.isDarkMode ? Color.black : Color.white))  {
						HStack {
							TextField("Enter Quantity", text: $bracketBoxDuplex)
								.foregroundColor(Color("Color 6"))
						}
						TextField("GFCI", text: $gfci).foregroundColor(Color("Color 6"))
						TextField("Cut-in", text: $cutin).foregroundColor(Color("Color 6"))
						TextField("Surface Mounted", text: $surfaceMounted).foregroundColor(Color("Color 6"))
						TextField("Controlled", text: $controlled).foregroundColor(Color("Color 6")).background(Color.white.opacity(0.0001))
						
					}
//					.padding(.vertical, 8) // Vertical padding
//					.foregroundColor(.green.opacity(0.9)) // Text color
//					.overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue)) // Underline
//					.padding(.trailing).scrollContentBackground(.hidden)
//					
//					.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
					
					Section(header: Text("Single Gang Devices").foregroundStyle(dataManager.isDarkMode ? Color.white : Color.black).id(UUID()))  {
						TextField("Standard Bracket Box", text: $dataManager.bracketBoxDuplex).foregroundColor(Color("Color 6"))
						TextField("GFCI", text: $gfci).foregroundColor(Color("Color 6"))
						TextField("Cut-in", text: $cutin).foregroundColor(Color("Color 6"))
						TextField("Surface Mounted", text: $surfaceMounted).foregroundColor(Color("Color 6"))
						TextField("Controlled", text: $controlled).foregroundColor(Color("Color 6")).background(Color.white.opacity(0.0001))
					}/*.background(Color.white.opacity(0.0001))*/
//					.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
//					.blurEffect()
//					// Style the blur effect.
//					.blurEffectStyle(.systemChromeMaterial)

					Section(header: Text("Two-Gang Devices").foregroundStyle(Color("BWText")).font(.title2)) {
						TextField("Quad Bracket Box", text: $quadBracketBox).foregroundColor(Color("BWText"))
						
						TextField("Quad GFCI", text: $quadGFCI).foregroundColor(Color("Color 6"))
						TextField("Quad Cut-in", text: $quadCutIn).foregroundColor(Color("Color 6"))
						TextField("Quad Surface Mounted", text: $quadSurfaceMounted).foregroundColor(Color("Color 6"))
					}.underline()
						.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
					
					Section(header: Text("Furniture Feeds").foregroundStyle(Color("Color 1")).font(.title2)) {
						TextField("3wire Furniture Feed", text: $wire3FurnitureFeed).foregroundColor(Color("Color 6"))
						TextField("4wire Furniture Feed", text: $wire2FurnitureFeed).foregroundColor(Color("Color 6"))
					}.underline()
						.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
					
					Section(header: Text("Data Devices").foregroundStyle(Color("Color 1")).font(.title2)) {
						TextField("Bracket Box Data", text: $bracketBoxData).foregroundColor(Color("Color 6"))
						TextField("Cut-in Data", text: $cutInData).foregroundColor(Color("Color 6"))
					}.underline()
						.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
					
					Section(header: Text("Line-Voltage Dimming").foregroundStyle(Color("Color 6")).font(.title2)) {
						TextField("Line-Voltage Dimming Switch", text: $lineVoltageDimmingSwitch).foregroundColor(Color("Color 6"))
						TextField("Line-Voltage Dimming Cutin", text: $lineVoltageDimmingCutin).foregroundColor(Color("Color 6"))
					}.underline()
						.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
					
					Section(header: Text("LV/Cat5").foregroundStyle(Color("Color 1")).font(.title2)) {
						TextField("LV/Cat5 Switch", text: $lvCat5Switch).foregroundColor(Color("Color 6"))
						TextField("LV/Cat5 Cut-in", text: $lvCat5Cutin).foregroundColor(Color("Color 6"))
					}.underline()
						.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
					
					Section(header: Text("Line-Voltage Switch").foregroundStyle(Color("Color 1")).font(.title2)) {
						TextField("Line-Voltage Switch", text: $lineVoltageSwitch).foregroundColor(Color("Color 6"))
						TextField("Line-Voltage Cut-in", text: $lineVoltageCutIn).foregroundColor(Color("Color 6"))
					}.underline()
						.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
					
					Section(header: Text("Floor Devices").foregroundStyle(Color("Color 1")).font(.title2)) {
						TextField("6in Floor Device", text: $inFloorDevice).foregroundColor(Color("Color 6"))
						TextField("4in Floor Device", text: $in6FloorDevice).foregroundColor(Color("Color 6"))
					}.underline()
						.frame(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
					
					Section(header: Text("Instahot").foregroundStyle(Color("Color 1")).font(.title2)) {
						TextField("Single-Pole 277V 40A Instahot", text: $singlePole277V40AInstahot).foregroundColor(Color("Color 6"))
						TextField("2-Pole 208V 40A Instahot", text: $pole208V40AInstahot).foregroundColor(Color("Color 6"))
						TextField("Single-Pole 277V 30A Instahot", text: $singlePole277V30AInstahot).foregroundColor(Color("Color 6"))
					}.underline()
						.frame(alignment: .center)
					
//					Button(isSaved ? "Calculated" : "Calculate Material") {
//						Task {
//							await submitForm()
//							fetchMaterials(projectName: dataManager.projectName) { result in
//								switch result {
//									case let .success(fetchedMaterials):
//										self.materials = fetchedMaterials
//										isFetched = true
//									case let .failure(error):
//										// Handle the error, maybe show an alert or a placeholder text
//										print("Error fetching materials: \(error)")
//										isError = true
//								}
//							}
//						}
//					}.padding()
						.frame(maxWidth: .infinity)
					//					.background(isError ? .red : .green)
						.foregroundColor(.white)
						.cornerRadius(10)
						.foregroundStyle(isSaved ? .green : .blue)
				}.scrollContentBackground(.hidden)
					.padding(.top, 50)//
				ScrollView {
					VStack(alignment: .leading) {
						ForEach(materials) { material in
							VStack(alignment: .leading) {
								Text("\(material.name)- ").foregroundStyle(Color.black)
								+
								Text("\(material.quantity)").foregroundStyle(Color.yellow.opacity(0.7))
							}
						}
					}
					
				}.frame(maxHeight: isFetched ? 300 : 0)
			}.padding(.top, 70)
			
			
		}
    }


    // Function to create a new project



}


@available(iOS 17.0, *)
struct MaterialListView: View {
//	@State private var gradientA: [Color = [.black, .blue]
//	@State private var gradientB: [Color] = [.red, .purple]
	    @State private var materialRequirements: [String: [String: Int]] = [:]  // Initialize appropriately
	@EnvironmentObject var dataManager: DataManager


	@State private var showMenu = true

	@State private var selected = 4
	func loadFromUserDefaults() {
		if let savedData = UserDefaults.standard.data(forKey: "MaterialRequirements"),
		   let decodedData = try? JSONDecoder().decode([String: [String: Int]].self, from: savedData)
		{
			self.materialRequirements = decodedData
		} else {
			self.materialRequirements = DataManager.defaultMaterialRequirements
		}
	}
	var body: some View {
		
		ZStack {
			if dataManager.isDarkMode {
				blueGradient()
			} else {
				lightblueGradient()
			}
			TabView(selection: $selected) {
				VStack {
					SingleGangView()
					
				}.tag(0)
				VStack {
					BoxTypeView()
					
				}.tag(1)
				
				VStack {
					SwitchesView()
					
				}.tag(2)
				VStack {
					
					MiscView()
				}.tag(3)
				VStack {

					LightsView()
				}.tag(4)
				VStack {
					
					OutletCalculatorView()
				}.tag(5)

			}
			.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
			.tabViewStyle(PageTabViewStyle())
//			.onChange(of: selected, perform: { value in
//				withAnimation(.spring()) {
//					self.setGradient(gradient: [Color.black, Color.blue])
//				}
//			})
			.navigationBarHidden(true)
			.modifier(DarkModeLightModeBackground())
//			SlideMenu( isShowing: $showMenu, materialRequirements: $materialRequirements)
			SlideMenu( isShowing: $showMenu)

		}
		.id(dataManager.isDarkMode) 
		.edgesIgnoringSafeArea(.all)
		.onAppear { loadFromUserDefaults() }
	
		// Sliding Menu
	}

}


@available(iOS 17.0, *)
struct MaterialListView_Previews: PreviewProvider {
	static var previews: some View {
		MaterialListView()
			.environmentObject(dataManager)
	}
}


@available(iOS 17.0, *)
struct LightsView: View {

	@State private var isDimmingSwitchActive: Bool = false
	@EnvironmentObject var dataManager: DataManager
	@State private var selectedOption = "None"

	var body: some View {
		ZStack {
			ScrollView {
				VStack {


					Text("Lights") .fontWeight(.black)
						.font(.largeTitle)
						.multilineTextAlignment(.center)
						.foregroundStyle(Color.white)
						.frame(maxWidth: .infinity * 0.90, alignment: .center)
					Text("Light Fixture Details").padding()

						.foregroundStyle(Color.white)
						.multilineTextAlignment(.center)
						.font(.title2)
					Spacer()
					VStack {
						Text("2x2, 2x4, Linear").padding(.top).font(.title2).foregroundStyle(.white)
						Divider().frame(height: 1).background(dataManager.isDarkMode ? .green: .white).padding(.horizontal)

						VStack {
							HStack {
							Text("Total Quantity of Lights").font(.subheadline).foregroundStyle(Color.white)

								TextField("Quantity", text: $dataManager.singlePole277V30AInstahot)							.keyboardType(.decimalPad)// Vertical padding

									.padding()  // Vertical padding
									.foregroundColor(.green.opacity(0.9))  // Text color
									.overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
								Text("").hidden() // Empty cell
								VStack {
									Text("0-10V").font(.caption2)
									Toggle("", isOn: $isDimmingSwitchActive)
										.toggleStyle(CheckboxToggleStyle())
										.font(.subheadline)
										.padding(.bottom, 30)
								}.padding(.horizontal, 2)
							}
							HStack {
								Text("Distance Apart: ").font(.subheadline).foregroundStyle(Color.white)
								Text("X-axis: ").font(.subheadline).foregroundStyle(Color.white)

								TextField("ft.", text: $dataManager.singlePole277V40AInstahot)
									.keyboardType(.decimalPad)// Vertical padding
									.padding()  // Vertical padding
									.foregroundColor(.green.opacity(0.9))  // Text color
									.overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline

								Text("Y-axis: ").font(.subheadline).foregroundStyle(Color.white)

								TextField("ft.", text: $dataManager.singlePole277V40AInstahot)
									.keyboardType(.decimalPad)// Vertical padding
									.padding()  // Vertical padding
									.foregroundColor(.green.opacity(0.9))  // Text color
									.overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
							}

						}.padding(.top, 0).padding(.horizontal)
					} .background(
						.ultraThinMaterial,
						in: RoundedRectangle(cornerRadius: 15, style: .continuous)

					).padding(.horizontal)
					//        }.background(
					//          ZStack {
					//            RoundedRectangle(cornerRadius: 0, style: .circular)
					//              .fill(Color.gray.opacity(0.01))
					//            Blur(style: .dark)
					//          }
					//        )
					//        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous)).padding(.horizontal)
					VStack {
						Text("Exit Signs").padding(.top).font(.title2).foregroundStyle(.white)
						Divider().frame(height: 1).background(dataManager.isDarkMode ? .green: .white).padding(.horizontal)

						HStack {
							HStack {
								Text("Surface Mount").font(.subheadline).foregroundStyle(Color.white)

								TextField("Quantity", text: $dataManager.wire3FurnitureFeed).padding()  // Vertical padding
									.keyboardType(.decimalPad)// Vertical padding

									.foregroundColor(.green.opacity(0.9))  // Text color
									.overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
							}
							HStack {
								Text("Box Mount").font(.subheadline).foregroundStyle(Color.white)

								TextField("Quantity", text: $dataManager.wire2FurnitureFeed).padding()  // Vertical padding
									.keyboardType(.decimalPad)// Vertical padding

									.foregroundColor(.green.opacity(0.9))  // Text color
									.overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
							}
						}.padding()
					} .background(
						.ultraThinMaterial,
						in: RoundedRectangle(cornerRadius: 15, style: .continuous)

					).padding(.horizontal)

					//        }.background(
					//          ZStack {
					//            RoundedRectangle(cornerRadius: 0, style: .circular)
					//              .fill(Color.gray.opacity(0.01))
					//            Blur(style: .dark)
					//          }
					//        )
					//        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous)).padding(.horizontal)
					VStack {
						VStack {
							Text("Misc.").padding(.top).font(.title2).foregroundStyle(.white)
							Divider().frame(height: 1).background(dataManager.isDarkMode ? .green: .white).padding(.horizontal)

						}

						HStack {
							HStack {
								VStack {
									Text("Bracket").font(.subheadline).foregroundStyle(Color.white)
									Text("Data").font(.subheadline).foregroundStyle(Color.white)

								}
								TextField("Quantity", text: $dataManager.bracketBoxData).padding()  // Vertical padding
									.keyboardType(.decimalPad)// Vertical padding

									.foregroundColor(.green.opacity(0.9))  // Text color
									.overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
							}
							VStack {
								Text("Cut-in").font(.subheadline).foregroundStyle(Color.white)
								Text("Data").font(.subheadline).foregroundStyle(Color.white)

							}
							TextField("Quantity", text: $dataManager.cutInData).padding()  // Vertical padding
								.keyboardType(.decimalPad)// Vertical padding

								.foregroundColor(.green.opacity(0.9))  // Text color
								.overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
						}.padding(.top, 0).padding(.horizontal)
						HStack {
							VStack {
								Text("Homerun").font(.subheadline).foregroundStyle(Color.white)
								Text("Quantity").font(.subheadline).foregroundStyle(Color.white)

							}
							TextField("Quantity", text: $dataManager.homerunQuantity).padding()  // Vertical padding
								.keyboardType(.decimalPad)// Vertical padding

								.foregroundColor(.green.opacity(0.9))  // Text color
								.overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline

							VStack {
								Text("Longest").font(.subheadline).foregroundStyle(Color.white)
								Text("HR length").font(.subheadline).foregroundStyle(Color.white)
							}
							TextField("Quantity", text: $dataManager.homerunLength).padding()  // Vertical padding
								.keyboardType(.decimalPad)// Vertical padding

								.foregroundColor(.green.opacity(0.9))
								.overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))  // Underline
						}
						HStack {
							let options = [
								"None", "WIREMOLD- 4FFATC15", "WIREMOLD- #RC4ATC", "WIREMOLD- #RC3ATC",
								"WIREMOLD- #RC9A15TC", "WIREMOLD- #RC7ATC", "WIREMOLD- #WIREMOLD- 6ATC2P",
								"WIREMOLD- #152CHA",
							]
							Text("Floor Devices").foregroundStyle(.white)

							Picker("Options", selection: $selectedOption) {
								ForEach(options, id: \.self) { option in
									Text(option).foregroundColor(.white)
								}
							}.pickerStyle(.automatic)
								.foregroundColor(Color.white)
								.background(Color.clear)

							// Display the selected option
							TextField("Quantity", text: $dataManager.in6FloorDevice).padding()  // Vertical padding
								.keyboardType(.decimalPad)// Vertical padding

								.foregroundColor(.green.opacity(0.9))  // Text color
								.overlay(Rectangle().frame(height: 1).padding(.top, 30).foregroundColor(.blue))
						}.padding(.top, 0).padding(.bottom).padding(.horizontal)
					} .background(
						.ultraThinMaterial,
						in: RoundedRectangle(cornerRadius: 15, style: .continuous)

					).padding(.horizontal)
					//
					//		}.background(
					//          ZStack {
					//            RoundedRectangle(cornerRadius: 0, style: .circular)
					//              .fill(Color.gray.opacity(0.01))
					//            Blur(style: .dark)
					//          }
					//        )
					//        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous)).padding(.horizontal)

					Spacer()

					//                TextField("Quad GFCI", text: $dataManager.quadGFCI).foregroundColor(Color("Color 6"))
					//                TextField("Quad Cut-in", text: $dataManager.quadCutIn).foregroundColor(Color("Color 6"))
					//                TextField("Quad Surface Mounted", text: $dataManager.quadSurfaceMounted).foregroundColor(Color("Color 6"))
				}
			}.scrollDismissesKeyboard(.immediately)
			sunview()
		}.onAppear {
			dataManager.calculateTotal()

		}.navigationBarHidden(true)


	}
}
