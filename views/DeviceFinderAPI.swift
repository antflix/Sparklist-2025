//
//  DeviceFinderAPI.swift
//  SparkList
//
//  Created by Anthony on 4/16/24.
//
// Structures and Views
//
// CategoryDetail
//
// Purpose: Represents a category with a name, count, and color.
// Properties: name (String), count (Int), color (UIColor).
// BlurView
//
// Purpose: SwiftUI view for displaying a blur effect.
//							Properties: style (UIBlurEffect.Style).
//							Functions:
//								makeUIView(context:): Creates a UIVisualEffectView with the specified blur style.
//							updateUIView(_:context:): Updates the blur effect of the UIVisualEffectView.
//							DeviceFinderAPI
//
//							Purpose: Main view for the device finder feature.
//							Properties: Includes various @State properties for managing UI state such as address, predictions, displayImage, classCounts, and more.
//							Functions:
//								body: Composes the view hierarchy including image display, slider controls, action buttons, and category counts.
//							cameraButton, checkButton, materialListButton: Define buttons for taking/uploading photos, checking the results, and navigating to a material list view, respectively.
//							controllsView: A view for displaying category counts and names.
//							loadMaterials: Processes the detected classes and updates data manager properties accordingly.
//							uploadImage: Handles image uploading and prediction requests.
//							drawBoundingBoxes(on:predictions:), redrawBoundingBoxes(for:), drawFilteredBoundingBoxes(on:filteredPredictions:): Functions for drawing bounding boxes around detected objects.
//							Utility functions like getColor(forCategory:), generateRandomColor(), drawText(categoryName:count:at:in:), parseBoundingBox(_:), findNearestNeighbor(for:in:), determineLabelPosition(for:considering:), disableInteractivePopGesture(), enableInteractivePopGesture(), showAlert(message:) for various tasks including color management, text drawing, bounding box parsing, and gesture control.
import SwiftUI
import SwiftyJSON

import ZoomImageViewer

struct CategoryDetail {
    let name: String
    var count: Int
    let color: UIColor
}

// class DetectionData: ObservableObject {
//	var predictions: [ObjectP@corediction] = []
//	@Published var selectedCategories: Set<Int> = []
//	@Published var scoreThreshold: Double = 0.5 // Default threshold
// }
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

@available(iOS 17.0, *)
/// //
//  DeviceFinderAPI.swift
//  SparkList
//
//  Created by Anthony on 4/16/24.
//
// Structures and Views
//
// CategoryDetail
//
// Purpose: Represents a category with a name, count, and color.
// Properties: name (String), count (Int), color (UIColor).
// BlurView
//
// Purpose: SwiftUI view for displaying a blur effect.
//							Properties: style (UIBlurEffect.Style).
//							Functions:
//								makeUIView(context:): Creates a UIVisualEffectView with the specified blur style.
//							updateUIView(_:context:): Updates the blur effect of the UIVisualEffectView.
//							DeviceFinderAPI
//
//							Purpose: Main view for the device finder feature.
//							Properties: Includes various @State properties for managing UI state such as address, predictions, displayImage, classCounts, and more.
//							Functions:
//								body: Composes the view hierarchy including image display, slider controls, action buttons, and category counts.
//							cameraButton, checkButton, materialListButton: Define buttons for taking/uploading photos, checking the results, and navigating to a material list view, respectively.
//							controllsView: A view for displaying category counts and names.
//							loadMaterials: Processes the detected classes and updates data manager properties accordingly.
//							uploadImage: Handles image uploading and prediction requests.
//							drawBoundingBoxes(on:predictions:), redrawBoundingBoxes(for:), drawFilteredBoundingBoxes(on:filteredPredictions:): Functions for drawing bounding boxes around detected objects.
//							Utility functions like getColor(forCategory:), generateRandomColor(), drawText(categoryName:count:at:in:), parseBoundingBox(_:), findNearestNeighbor(for:in:), determineLabelPosition(for:considering:), disableInteractivePopGesture(), enableInteractivePopGesture(), showAlert(message:) for various tasks including color management, text drawing, bounding box parsing, and gesture control.
struct DeviceFinderAPI: View {
    //	@State private var image: UIImage? = UIImage(named: "123.png")
    @State private var address: String = "https://ml.antflix.net/predict"
    @State private var predictions: [ObjectPrediction] = []
    @State private var displayImage: UIImage?
    @State private var classCounts: [String: Int] = [:]
    @State private var scale: CGFloat = 1.0
    @State private var lastScaleValue: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @State private var categoryColors: [String: UIColor] = [:]
    @State private var usedColors: [UIColor] = []
    @State private var isShowingFullScreen = false
    @State private var uiImage: UIImage? = nil
    @State private var inputImage: UIImage? = nil
    @State private var scoreThreshold: Double = 0.5 // Default threshold
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var showingImagePicker2 = false

    @State private var fullImage: UIImage?
    @State private var showCategoryNames: Bool = true
    @State private var selectedImage: UIImage?
    @State private var selectedClass: String? = nil
    @State private var hiddenClasses: Set<String> = []
    @State private var categoryNameVisibility: Set<String> = []
    @State private var isLoading = false
    @State private var navigateToMaterialView = false
    @State private var showingSheet = false
    @State private var isAnimating: Bool = true
    @State private var isAddingCeilingsPrint: Bool = false

    let mainColors: [UIColor] = [
        .red, .blue, .green, .purple, .orange, .yellow, .magenta, .cyan,
    ]
    init(classCounts: [String: Int] = [:]) {
        _classCounts = State(initialValue: classCounts)
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
//				ChainedSpring4(exitTriggered: isLoading)

//				ChainedSpring3()
//				ChainedSpring2(moving: true, color2: .blue, color3: .pink)
//                ScrollView([.horizontal, .vertical], showsIndicators: false) {
                ZStack { // Overlay content on the image
                    if let displayImage = displayImage {
                        Image(uiImage: displayImage)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(scale)
                            .onTapGesture {
                                fullImage = displayImage
                            }
                            .offset(x: offset.width, y: offset.height)
                            .gesture(
                                MagnificationGesture().onChanged { value in
                                    let delta = value / self.lastScaleValue
                                    self.lastScaleValue = value
                                    self.scale *= delta
                                }
                                .onEnded { _ in
                                    self.lastScaleValue = 1.0
                                }
                            )
                            .simultaneousGesture(
                                DragGesture().onChanged { value in
                                    let delta = CGSize(
                                        width: value.translation.width + self.lastOffset.width,
                                        height: value.translation.height + self.lastOffset.height)
                                    self.offset = delta
                                }
                                .onEnded { _ in
                                    self.lastOffset = self.offset
                                }
                            )
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    } else {


                    }
                }
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/ .all/*@END_MENU_TOKEN@*/)

                ///////     SLIDER     ///////
                Group {
                    if classCounts != [:] {
                        VStack {
                            Slider(value: $scoreThreshold, in: 0 ... 1, step: 0.01)
                                .padding(0)
                                .onChange(of: scoreThreshold) { _ in
                                    // Call function to re-draw bounding boxes with the new threshold
                                    if let baseImage = self.uiImage { // Assuming `uiImage` holds the base image without bounding boxes
                                        if selectedClass != nil {
                                            self.displayImage = drawBoundingBoxes(on: baseImage, predictions: self.predictions)
                                        } else {
                                            self.redrawBoundingBoxes(for: selectedClass)
                                        }
                                    }
                                }
                            Spacer()
                        }
                    }
                }
                Group {
                    if classCounts != [:] {
                        VStack {
                            HStack {
                                if isAddingCeilingsPrint == false {
                                    materialListButton
                                        .padding()
                                    Spacer()
                                    cameraButton

                                    NavigationLink(destination: MaterialListView(), isActive: $navigateToMaterialView) {
                                        EmptyView()
                                    }
                                }

                            }.padding(.top, 17)
                            Spacer()
                            Group {
                                if isAddingCeilingsPrint == true {
                                    HStack {
                                        Spacer()
                                        checkButton
                                            .padding(.bottom, 50)
                                    }
                                }
                            }
                        }
                    } else {
                        VStack {



                            HStack {
Spacer()

                                cameraButton
								Spacer()

                            }
                        }
                    }
                }

                VStack {
                    Spacer()
                    controllsView
                        .frame(height: 60)
                        .background(BlurView(style: .systemMaterialDark).edgesIgnoringSafeArea(.bottom))
                        .frame(width: geometry.size.width)
                        .position(x: geometry.size.width / 2, y: geometry.size.height - 30)
                }
//                if classCounts != [:] {
//                    VStack {
//
//                    }
//                }
                ////////   IF BOUNDING BOXES ARE AVAILABLE   ////////////

                // List to show class counts, overlaid on the bottom right of the ZStack
//                }

                .sheet(isPresented: $showingImagePicker, onDismiss: {
                    print("Selected image: \(String(describing: self.uiImage))")
					self.uploadImage { _ in
						// No action needed after completion
					}
                }) {
                    ImagePicker(isPresented: $showingImagePicker, selectedImage: $uiImage)
                }
            }
            .overlay(
                /// Auto rotating modifier is from FrameUp and is optional

                ZoomImageViewer(uiImage: $fullImage)
            )
            .onAppear {
				 // Start the ChainedSpring animation when the view appears

				// Disable the interactive pop gesture in the navigation controller
                self.disableInteractivePopGesture()
            }
            .onChange(of: scale) { newScale in
                if newScale > 1 {
                    // Disable the interactive pop gesture
                    self.disableInteractivePopGesture()
                } else {
                    // Enable the interactive pop gesture
                    self.enableInteractivePopGesture()
                }
            }
            // dadax
        }
    }

    var cameraButton: some View {
        Button(action: {
			self.isLoading = true // Start the ChainedSpring animation
			self.showingActionSheet = true
			self.uploadImage { success in
				self.isLoading = false // Stop the ChainedSpring animation when the upload is complete
			}
		}) {
			if isLoading {
//				ChainedSpring4(exitTriggered: isLoading)

				 // Pass the binding to ChainedSpring
			} else {
				VStack {

					Image(systemName: "camera")
						.padding()
						.background(Color.blue)
						.foregroundColor(.white)
						.clipShape(Circle())
						.shadow(radius: 3)
				}
			}
		}

        .buttonStyle(PlainButtonStyle())
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(
                title: Text("Select Action"),
                buttons: [
                    .default(Text("Upload Image")) {
                        showingImagePicker = true
                    },
                    .cancel(),
                ])
        }
        .padding()
    }

    var checkButton: some View {
        Button(action: {
            self.loadMaterials()
            self.showingSheet = true
        }) {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            } else {
                Image(systemName: "checkmark")
                    .font(.headline)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 3)
            }
        }.onAppear {
            withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                self.isAnimating.toggle()
            }
        }

        .buttonStyle(PlainButtonStyle())
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(
                title: Text("Select Action"),
                buttons: [
                    .default(Text("Take Photo")) {
                        if let inputImage = self.uiImage { // Assuming `uiImage` is your input image
							self.uploadImage { _ in
								// No action needed after completion
							}
                            displayImage = inputImage
                        }
                    },
                    .default(Text("Upload Image")) {
                        showingImagePicker = true
                    },
                    .cancel(),
                ])
        }
        .padding()
    }

    var materialListButton: some View {
        Group {
            if classCounts != [:] {
                Button(action: {
                    self.showingActionSheet = true
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                }
                .buttonStyle(PlainButtonStyle())
                .actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(
                        title: Text("Select Action"),
                        buttons: [
                            .default(Text("Save highlighted print")) {
                                showingImagePicker = true
                            },
                            .default(Text("Generate material list")) {
                                // Set the global or state variables here
                                // For example, setting a global variable
                                self.loadMaterials()
                                self.showingSheet = true
                                // Trigger navigation
                            },
                            .cancel(),
                        ])
                }
                .sheet(isPresented: $showingSheet) {
                    VStack {
                        //						List {
                        //							ForEach(self.classCounts.sorted(by: { $0.key < $1.key }), id: \.key) { device, count in
                        //								Text("\(device): \(count)")
                        //							}
                        //						}
						//	12: 'Line Voltage Switch- lineVoltageSwitch',
						//	14: 'Low Voltage Controlls Switch- lvCat5Switch',
						//	15: 'Occupancy Dimmer Switch- lineVoltageSwitch',
                        VStack {
                            Text("Import Into Device List:")
                                .font(/*@START_MENU_TOKEN@*/ .title/*@END_MENU_TOKEN@*/)
							if Int(dataManager.lineVoltageSwitch) ?? 0 > 0 {
								HStack {
									Text("Line Voltage Switch(Single Gang/Bracket Box)- ")
									Spacer()
									Text(dataManager.lineVoltageSwitch)
								}
							}
							if Int(dataManager.lvCat5Switch) ?? 0 > 0 {
								HStack {
									Text("Low Voltage Switch(Single Gang/Bracket Box)- ")
									Spacer()
									Text(dataManager.lvCat5Switch)
								}
							}
                            if Int(dataManager.bracketBoxDuplex) ?? 0 > 0 {
                                HStack {
                                    Text("Single-gang non-controlled outlet- ")
                                    Spacer()
                                    Text(dataManager.bracketBoxDuplex)
                                }
                            }
                            if Int(dataManager.quadBracketBox) ?? 0 > 0 {
                                HStack {
                                    Text("Two-Cang Non-Controlled Outlet- ")
                                    Spacer()
                                    Text(dataManager.quadBracketBox)
                                }
                            }
                            if Int(dataManager.gfci) ?? 0 > 0 {
                                HStack {
                                    Text("Single-Gang GFCI- ")
                                    Spacer()
                                    Text(dataManager.gfci)
                                }
                            }
                if Int(dataManager.wire3FurnitureFeed) ?? 0 > 0 {
                    HStack {
                        Text("3 Wire Furniture Feed- ")
                        Spacer()
                        Text(dataManager.wire3FurnitureFeed)
                    }
                }
                if Int(dataManager.bracketBoxData) ?? 0 > 0 {
                    HStack {
                        Text("Data(Bracket Box)- ")
                        Spacer()
                        Text(dataManager.bracketBoxData)
                    }
                }
                if Int(dataManager.twoXtwo) ?? 0 > 0 {
                    HStack {
                        Text("2x2, 2x4, Linear- ")
                        Spacer()
                        Text(dataManager.twoXtwo)
                    }
                }
                if Int(dataManager.EMG2x2) ?? 0 > 0 {
                    HStack {
                        Text("EMG 2x2/2x4/Canlight- ")
                        Spacer()
                        Text(dataManager.EMG2x2)
                    }
                }
                if Int(dataManager.ceilingMotionSensor) ?? 0 > 0 {
                    HStack {
                        Text("Ceiling Motion Sensor- ")
                        Spacer()
                        Text(dataManager.ceilingMotionSensor)
                    }
                }
                if Int(dataManager.exitSign) ?? 0 > 0 {
                    HStack {
                        Text("Exit Sign Surface- ")
                        Spacer()
                        Text(dataManager.exitSign)
                    }
                }
                if Int(dataManager.exitSignBox) ?? 0 > 0 {
                    HStack {
                        Text("Exit Sign Box Mount- ")
                        Spacer()
                        Text(dataManager.exitSignBox)
                    }
                }
                if Int(dataManager.pendantLight) ?? 0 > 0 {
                    HStack {
                        Text("Pendant Light- ")
                        Spacer()
                        Text(dataManager.pendantLight)
                    }
                }
            }
            Button(action: {
                self.showingSheet = false
                navigateToMaterialView = true

                        }) {
                            Text("Import")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(10)
                                .foregroundStyle(Color.white)
                        }
                        Button(action: {
							self.predictions = []
							self.uiImage = nil
							self.selectedImage = nil
							self.displayImage = nil
							self.showingSheet = false
							self.classCounts = [:]
//							self.showingActionSheet = true
//							if let drawnImage = uiImage {
//								self.isLoading = true // Start loading
//								self.displayImage = drawBoundingBoxes(on: drawnImage, predictions: predictions)
//								self.isLoading = false // End loading
//							} else {
//								print("drawnImage is nil")
//							}

//							loadMaterials()
                            //							uploadImage()
//                            self.isAddingCeilingsPrint = true // If you need to distinguish this action from other image picking actions, keep this line.

						}) {
							Text("Add Ceilings Print")
								.padding()
								.frame(maxWidth: .infinity)
								.background(Color.blue)
								.cornerRadius(10)
								.foregroundStyle(Color.white)
						}
//						}.actionSheet(isPresented: $showingActionSheet) {
//							ActionSheet(
//								title: Text("Select Action"),
//								buttons: [
//									.default(Text("Take Photo")) {
//										if let inputImage = self.uiImage { // Assuming `uiImage` is your input image
//											uploadImage()
//											displayImage = inputImage
//										}
//									},
//									.default(Text("Upload Image")) {
//										self.showingSheet = false
//
//										showingImagePicker = true
//										redrawBoundingBoxes(for: nil)
//										if let inputImage = self.uiImage { // Assuming `uiImage` is your input image
//											uploadImage()
//											displayImage = inputImage
//										}
//										redrawBoundingBoxes(for: nil)
//									},
//									.cancel(),
//								])
//						}
//						.sheet(isPresented: $showingImagePicker, onDismiss: {
//							print("Selected image: \(String(describing: self.uiImage))")
//							self.uploadImage()
//						}) {
//							ImagePicker(isPresented: $showingImagePicker, selectedImage: $uiImage)
//						}.id(UUID())

                        Button(action: {
                            self.showingSheet = false
                        }) {
                            Text("Cancel")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(10)
                                .foregroundStyle(Color.white)
                        }
                    }
				}
                // The NavigationLink should be part of the view hierarchy
                // For example, it could be placed in the body of the DeviceFinderAPI view
            }
		}
    }

    // ...
    // Inside the body of the DeviceFinderAPI view

    var controllsView: some View {
        Group {
            if classCounts != [:] {
                /////////////  CLASS NAMES/COUNTS  ////////////
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 10) {
                            ForEach(classCounts.keys.sorted(), id: \.self) { key in
                                HStack {
                                    HStack {
                                        Rectangle()
                                            .fill(Color(getColor(forCategory: key)))
                                            .frame(width: 20, height: 20)
                                            .cornerRadius(5)
                                        Text("\(key): \(classCounts[key] ?? 0)")
                                            .foregroundColor(.white)
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 13)
                                    .background(Color.black.opacity(0.5))
                                    .cornerRadius(10)

                                    .onTapGesture {
                                        if hiddenClasses.contains(key) {
                                            hiddenClasses.remove(key)
                                        } else {
                                            hiddenClasses.insert(key)
                                        }
                                        redrawBoundingBoxes(for: nil)
                                        // No need to call redrawBoundingBoxes here directly, it will be handled in the drawing logic
                                    }
                                    Button(action: {
                                        if self.categoryNameVisibility.contains(key) {
                                            self.categoryNameVisibility.remove(key)
                                        } else {
                                            self.categoryNameVisibility.insert(key)
                                        }
                                        // Trigger a redraw of bounding boxes to reflect the change.
                                        redrawBoundingBoxes(for: nil)
                                    }) {
                                        Image(systemName: "character.textbox")

                                            .padding(.vertical, 4)
                                            .foregroundColor(categoryNameVisibility.contains(key) ? .blue : .gray)
                                            .imageScale(categoryNameVisibility.contains(key) ? .large : .large) // Larger and bolder when activated
                                            .opacity(categoryNameVisibility.contains(key) ? 1 : 0.5) // Full opacity when activated, more opaque when not
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .buttonStyle(BorderlessButtonStyle()) // Use a borderless button style for better UI integration
                                    Divider().frame(width: 2.0).background(
                                        Color(.green)
                                    )
                                }
                                //												.padding(.vertical, 10)
                                .onTapGesture {
                                    // Handle tap gesture, e.g., hiding or showing categories
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }

    // if device in classCounts = {
    // 'Data Box- dataManager.bracketBoxData',
    // 1: 'Dedicated Outlet- dataManager.gfci',
    // 2: 'Duplex Outlet- dataManager.bracketBoxDuplex',
    // 3: 'Floor Box- dataManager.in6FloorDevice',
    // 4: 'Furniture Feed'- dataManager.wire3FurnitureFeed ,
    // 5: 'Quad Outlet- dataManager.quadBracketBox ',
    // 6: 'TV Box'}

    //
//	{{0: '2x2', 1: '2x4', 2: '3-way Switch', 3: 'Canlight', 4: 'Ceiling Mounted Motion Sensor', 5: 'Demo 2x2', 6: 'Demo 2x4', 7: 'Demo Canlight', 8: 'EMG 2x2', 9: 'EMG 2x4', 10: 'EMG Canlight', 11: 'Exit Sign',
//	12: 'Line Voltage Switch- lineVoltageSwitch',
//	14: 'Low Voltage Controlls Switch- lvCat5Switch',
//	15: 'Occupancy Dimmer Switch- lineVoltageSwitch',
    func loadMaterials() {
        print("METHOD loadMaterials")
        var lineVoltageSwitchTotal = 0  // Temporary variable to accumulate counts
        var standardLightTotal = 0       // 2x2, 2x4, Linear
        var emgLightTotal = 0            // EMG 2x2, EMG 2x4, EMG Canlight
        var exitSignSurfaceTotal = 0
        var exitSignBoxTotal = 0
        var pendantLightTotal = 0
        var threeWaySwitchTotal = 0
        var ceilingMotionSensorTotal = 0

        for (device, count) in classCounts {
            if count != 0 {
                switch device {
                case "Line Voltage Switch":
                    lineVoltageSwitchTotal += count
                    print("Line Voltage Switch count: \(count)")
                case "Low Voltage Controlls Switch":
                    dataManager.lvCat5Switch = String(count)
                    print("Low Voltage Controlls Switch count: \(dataManager.lvCat5Switch)")
                case "Occupency Dimmer Switch":
                    lineVoltageSwitchTotal += count
                    print("Occupency Dimmer Switch count: \(count)")
                case "3-way Switch":
                    threeWaySwitchTotal += count
                case "Ceiling Mounted Motion Sensor", "Occupancy Sensor":
                    ceilingMotionSensorTotal += count
                case "2x2", "2x4", "Linear", "Canlight", "Demo 2x2", "Demo 2x4", "Demo Canlight":
                    standardLightTotal += count
                case "EMG 2x2", "EMG 2x4", "EMG Canlight":
                    emgLightTotal += count
                case "Exit Sign":
                    exitSignSurfaceTotal += count
                case "Exit Sign- Box Mount":
                    exitSignBoxTotal += count
                case "Pendant Light":
                    pendantLightTotal += count
                case "Data Box":
                    dataManager.bracketBoxData = String(count)
                    print(dataManager.bracketBoxData)
                case "Dedicated Outlet":
                    dataManager.gfci = String(count)
                    print(dataManager.gfci)
                case "Duplex Outlet":
                    dataManager.bracketBoxDuplex = String(count)
                    print(dataManager.bracketBoxDuplex)
                case "Floor Box":
                    dataManager.in6FloorDevice = String(count)
                    print(dataManager.in6FloorDevice)
                case "Furniture Feed":
                    dataManager.wire3FurnitureFeed = String(count)
                    print(dataManager.wire3FurnitureFeed)
                case "Quad Outlet":
                    dataManager.quadBracketBox = String(count)
                    print(dataManager.quadBracketBox)
                default:
                    print("Unknown device type: \(device)")
                }
            }
        }

        // Set totals for aggregated categories
        dataManager.lineVoltageSwitch = String(lineVoltageSwitchTotal)
        dataManager.twoXtwo = String(standardLightTotal)
        dataManager.EMG2x2 = String(emgLightTotal)
        dataManager.exitSign = String(exitSignSurfaceTotal)
        dataManager.exitSignBox = String(exitSignBoxTotal)
        dataManager.pendantLight = String(pendantLightTotal)
        dataManager.threeWaySwitch = String(threeWaySwitchTotal)
        dataManager.ceilingMotionSensor = String(ceilingMotionSensorTotal)

        print("Total Line Voltage Switch count: \(dataManager.lineVoltageSwitch)")
    }

	func uploadImage(completion: @escaping (Bool) -> Void) {
        print("Uploading image: \(String(describing: uiImage))")
        if let selectedImage = uiImage {
            displayImage = selectedImage
        }
        guard let url = URL(string: address), let imageData = uiImage?.jpegData(compressionQuality: 0.9) else {
            showAlert(message: "Invalid setup")
            return
        }
        guard let imageToUpload = uiImage else {
            showAlert(message: "Image not found")
            return
        }
        guard let imageData = imageToUpload.jpegData(compressionQuality: 0.9) else {
            showAlert(message: "Failed to process image")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue(
            "multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append(
            "Content-Disposition: form-data; name=\"image\"; filename=\"img2.jpg\"\r\n".data(
                using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        //		let task = URLSession.shared.uploadTask(with: request, from: body) { data, _, error in
        //			guard let data = data else {
        //				print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
        //				return
        //			}
        //
        //			do {
        //				// First, decode the data into a string
        //				let jsonResponseString = try JSONDecoder().decode(String.self, from: data)
        //				// Convert the string back into Data
        //				guard let jsonData = jsonResponseString.data(using: .utf8) else {
        //					DispatchQueue.main.async {
        //						print("Failed to convert JSON string back to Data")
        //					}
        //					return
        //				}
        //				// Now, decode your actual structure
        //				let decodedResponse = try JSONDecoder().decode(
        //					[ObjectPredictionContainer].self, from: jsonData)
        //				DispatchQueue.main.async {
        //					// Update UI or state with the decoded response
        //					self.predictions = decodedResponse.map { $0.ObjectPrediction }
        //				}
        //				//				print("Decoded response: \(decodedResponse)")
        //			} catch {
        //				print("Failed to decode response: \(error)")
        //			}
        //		}
        isLoading = true // Start loading
        let task = URLSession.shared.uploadTask(with: request, from: body) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            // Check server response code
            if let httpResponse = response as? HTTPURLResponse,
               !(200 ... 299).contains(httpResponse.statusCode) {
                print("Server returned status code: \(httpResponse.statusCode)")
                return
            }

            // Attempt to decode the data into a string
            guard let jsonResponseString = String(data: data, encoding: .utf8) else {
                print("Failed to convert Data to String")
                return
            }

            // Convert the string back into Data
            guard let jsonData = jsonResponseString.data(using: .utf8) else {
                DispatchQueue.main.async {
                    print("Failed to convert JSON string back to Data")
                }
                return
            }

            //			// Temporary debugging using JSONSerialization
            //			if let jsonDebug = try? JSONSerialization.jsonObject(with: jsonData, options: []) {
            //				print("Parsed with JSONSerialization: \(jsonDebug)")
            //			} else {
            //				print("Failed to parse with JSONSerialization")
            //			}
            //			print(jsonResponseString)
            // Parse JSON data using SwiftyJSON
            let json = JSON(jsonData)
            //			print(json)
            let objectPredictions = json.arrayValue.map { item -> ObjectPrediction in
                ObjectPrediction(
                    id: item["ObjectPrediction"]["category"]["Category"]["id"].intValue,
                    bbox: item["ObjectPrediction"]["bbox"]["BoundingBox"].stringValue,
                    w: item["ObjectPrediction"]["bbox"]["w"].doubleValue,
                    h: item["ObjectPrediction"]["bbox"]["h"].doubleValue,
                    score: item["ObjectPrediction"]["score"]["PredictionScore"].doubleValue,
                    categoryID: item["ObjectPrediction"]["category"]["Category"]["id"].intValue,
                    categoryName: item["ObjectPrediction"]["category"]["Category"]["name"].stringValue
                )
            }

            DispatchQueue.main.async {
                self.isLoading = false
                self.predictions = objectPredictions
				completion(true)

                // Print the entire array of predictions
                //				print("All predictions:", self.predictions)
                //				var counts: [String: Int] = [:]
                //				objectPredictions.forEach { prediction in
                //					counts[prediction.categoryName, default: 0] += 1
                //				}
                //				classCounts = counts
                // Check if the array is not empty and print the first element
                if let drawnImage = self.uiImage {
                    self.displayImage = self.drawBoundingBoxes(on: drawnImage, predictions: self.predictions)
                }
                if let firstPrediction = self.predictions.first {
                    print("First prediction category name:", firstPrediction.categoryName)
                    print("First prediction bounding box:", firstPrediction.bbox)
                } else {
                    print("No predictions found")
                }
            }
        }
        task.resume()
    }

    func getCategoryCounts(categoryName: String) -> Int {
        if let count = classCounts[categoryName] {
            classCounts[categoryName] = count + 1
            return count + 1 // Return the incremented count
        } else {
            classCounts[categoryName] = 1
            return 1 // Return the initialized count
        }
    }

    func drawBoundingBoxes(on image: UIImage, predictions: [ObjectPrediction]) -> UIImage? {
        print(
            "METHOD: drawBoundingBoxes(on image: UIImage, predictions: [PredictionDetails]) -> UIImage?")
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        image.draw(at: .zero) // Draw the base image
        var count = 0
        classCounts = [:]
        for prediction in predictions where prediction.score >= scoreThreshold {
            let count = getCategoryCounts(categoryName: prediction.categoryName)
        }

        for prediction in predictions where prediction.score >= scoreThreshold {
            if !hiddenClasses.contains(prediction.categoryName) {
                let categoryName = prediction.categoryName
                let bbox = parseBoundingBox(prediction.bbox)
                let rect = CGRect(x: bbox.x, y: bbox.y, width: bbox.width, height: bbox.height)

                // Increment category count or initialize it

                // Get the current count for this category
//                let count = getCategoryCounts(categoryName: categoryName)
                let categoryColor = getColor(forCategory: categoryName)
                context.setStrokeColor(categoryColor.cgColor)
                context.setLineWidth(2)
                context.addRect(rect)
                context.strokePath()

                // Draw the count number and category name near the bounding box
                if showCategoryNames && !categoryNameVisibility.contains(categoryName) {
                    drawText(
                        categoryName: categoryName, count: classCounts[categoryName] ?? 0,
                        at: CGPoint(x: bbox.x, y: bbox.y), in: context)
                }
            }
        }
        // Debugging output
        print("Category counts:", classCounts)
        // Retrieve the edited image
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        // Update classCounts on the main thread
        DispatchQueue.main.async {
            self.classCounts = classCounts
            print("!!!!!!\(self.classCounts)")
        }
        return newImage
    }

    func redrawBoundingBoxes(for selectedClass: String?) {
        // Filter predictions for the selected class
        let filteredPredictions =
            (selectedClass == nil)
                ? predictions
                : predictions.filter { prediction in
                    prediction.categoryName == selectedClass
                }

        // Redraw the image with the filtered bounding boxes
        if let uiImage = uiImage {
            displayImage =
                selectedClass == nil
                    ? drawBoundingBoxes(on: uiImage, predictions: filteredPredictions)
                    : drawFilteredBoundingBoxes(on: uiImage, filteredPredictions: filteredPredictions)
        }
    }

    func drawFilteredBoundingBoxes(on image: UIImage, filteredPredictions: [ObjectPrediction])
        -> UIImage? {
        print(
            "METHOD: drawBoundingBoxes(on image: UIImage, predictions: [PredictionDetails]) -> UIImage?")
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        image.draw(at: .zero) // Draw the base image

        // Draw each bounding box
        for prediction in filteredPredictions where prediction.score >= scoreThreshold {
            let categoryName = prediction.categoryName
            let count = getCategoryCounts(categoryName: categoryName)
            let bbox = parseBoundingBox(prediction.bbox)
            let rect = CGRect(x: bbox.x, y: bbox.y, width: bbox.width, height: bbox.height)

            let categoryColor = getColor(forCategory: categoryName)
            context.setStrokeColor(categoryColor.cgColor)
            context.setLineWidth(2)
            context.addRect(rect)
            context.strokePath()

            let neighbor = findNearestNeighbor(for: rect, in: predictions)
            let textLocation = determineLabelPosition(for: rect, considering: neighbor)
            // Draw the count number and category name near the bounding box
            drawText(
                categoryName: categoryName, count: count, at: textLocation, in: context)
        }

        // Debugging output
        print("Category counts:", classCounts)
        // Retrieve the edited image
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        // Update classCounts on the main thread
        DispatchQueue.main.async {
            self.classCounts = classCounts
            print("!!!!!!\(self.classCounts)")
        }
        return newImage
    }

    func getColor(forCategory category: String) -> UIColor {
        print("METHOD: getColor(forCategory category: String) -> UIColor ")
        if let color = categoryColors[category] {
            return color
        } else {
            // Assign a color from mainColors if available
            let availableColors = mainColors.filter { !usedColors.contains($0) }
            if let newColor = availableColors.first {
                usedColors.append(newColor)
                categoryColors[category] = newColor
                return newColor
            }
            print("drawBB")
            // If all main colors are used, generate a random color
            let randomColor = generateRandomColor()
            categoryColors[category] = randomColor
            return randomColor
        }
    }

    func generateRandomColor() -> UIColor {
        print("METHOD: generateRandomColor() -> UIColor")
        let red = CGFloat.random(in: 0 ... 1)
        let green = CGFloat.random(in: 0 ... 1)
        let blue = CGFloat.random(in: 0 ... 1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

    //	{{0: '2x2', 1: '2x4', 2: '3-way Switch', 3: 'Canlight', 4: 'Ceiling Mounted Motion Sensor', 5: 'Demo 2x2', 6: 'Demo 2x4', 7: 'Demo Canlight', 8: 'EMG 2x2', 9: 'EMG 2x4', 10: 'EMG Canlight', 11: 'Exit Sign', 12: 'Line Voltage Switch- lineVoltageSwitch', 13: 'Linear', 14: 'Low Voltage Controlls Switch- lvCat5Switch', 15: 'Occupancy Dimmer Switch- lineVoltageSwitch', 16: 'Occupancy Sensor', 17: 'Pendant Light'}}
    //	{0: 'Data Box- bracketBoxData', 1: 'Dedicated Outlet- gfci', 2: 'Duplex Outlet- bracketBoxDuplex', 3: 'Floor Box- in6FloorDevice', 4: 'Furniture Feed'- wire3FurnitureFeed , 5: 'Quad Outlet- quadBracketBox ', 6: 'TV Box'}

    func drawText(categoryName: String, count: Int, at point: CGPoint, in context: CGContext) {
        print(
            "METHOD: drawText(categoryName: String, count: Int, at point: CGPoint, in context: CGContext)"
        )
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        let color = getColor(forCategory: categoryName)

        // Attributes for count
        let countAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 8),
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.black,
            .backgroundColor: UIColor.white.withAlphaComponent(0.85), // Set background color with 50% opacity
        ]
        let countString = NSAttributedString(string: "\(count)", attributes: countAttributes)
        // Calculate positions
        let countStringSize = countString.size()
        // Drawing count above the bounding box
        countString.draw(at: CGPoint(x: point.x + 1, y: point.y + 1))

        // Attributes for categoryName
        let categoryAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 8),
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.black,
            .backgroundColor: UIColor.white.withAlphaComponent(0.85), // Set background color with 50% opacity
        ]
        let formattedCategoryName = categoryName.split(separator: " ").joined(separator: "\n")
        let categoryNameString = NSAttributedString(string: formattedCategoryName, attributes: categoryAttributes)
        // Calculate positions
        let categoryNameStringSize = categoryNameString.size()
        // Drawing categoryName below the bounding box
        categoryNameString.draw(at: CGPoint(x: point.x, y: point.y + countStringSize.height + 5)) // 5 is a buffer space below the bounding box
    }

    func parseBoundingBox(_ boundingBox: String) -> (
        x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat
    ) {
        print(
            "METHOD: parseBoundingBox(_ boundingBox: String) -> (x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)"
        )
        let components = boundingBox.trimmingCharacters(in: CharacterSet(charactersIn: " ()"))
            .split(separator: ",")
            .map { substring -> CGFloat in
                let number = Double(substring.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
                return CGFloat(number)
            }
        if components.count == 4 {
            let x = components[0]
            let y = components[1]
            let x2 = components[2]
            let y2 = components[3]
            //			print("Before: x: \(x) y: \(y) y2: \(x2) x2: \(y2)")
            //			print("Width before: \(max(x2 - x, 0)) Height before: \(max(y2 - y, 0))")
            return (x: x, y: y, width: max(x2 - x, 0), height: max(y2 - y, 0))
        } else {
            // Return zeros if the components aren't as expected to avoid crashing
            return (x: 0, y: 0, width: 0, height: 0)
        }
    }

    func findNearestNeighbor(for bbox: CGRect, in predictions: [ObjectPrediction]) -> ObjectPrediction? {
        let bboxCenter = CGPoint(x: bbox.midX, y: bbox.midY)
        var nearestNeighbor: ObjectPrediction?
        var shortestDistance: CGFloat = .greatestFiniteMagnitude

        for prediction in predictions {
            let predictionBBox = parseBoundingBox(prediction.bbox)
            // Manually calculate the center of the bounding box
            let predictionCenter = CGPoint(x: predictionBBox.x + predictionBBox.width / 2, y: predictionBBox.y + predictionBBox.height / 2)
            let distance = hypot(bboxCenter.x - predictionCenter.x, bboxCenter.y - predictionCenter.y)

            if distance < shortestDistance && distance != 0 { // distance != 0 to exclude the box itself
                shortestDistance = distance
                nearestNeighbor = prediction
            }
        }

        return nearestNeighbor
    }

    func determineLabelPosition(for bbox: CGRect, considering nearestNeighbor: ObjectPrediction?) -> CGPoint {
        guard let nearestNeighbor = nearestNeighbor else {
            // If there's no neighbor, return the top-right corner as default
            return CGPoint(x: bbox.maxX, y: bbox.minY)
        }

        let neighborBBoxTuple = parseBoundingBox(nearestNeighbor.bbox)
        let neighborBBoxRect = CGRect(x: neighborBBoxTuple.x, y: neighborBBoxTuple.y, width: neighborBBoxTuple.width, height: neighborBBoxTuple.height)
        let neighborCenter = CGPoint(x: neighborBBoxRect.midX, y: neighborBBoxRect.midY)
        let bboxCenter = CGPoint(x: bbox.midX, y: bbox.midY)

        // Example strategy: if neighbor is to the right, place label to the left, and vice versa
        let labelX: CGFloat = neighborCenter.x > bboxCenter.x ? bbox.minX : bbox.maxX
        let labelY: CGFloat = bbox.minY // Adjust based on your needs

        return CGPoint(x: labelX, y: labelY)
    }

    private func disableInteractivePopGesture() {
        // Access the UINavigationController and disable the interactivePopGestureRecognizer
        if let windowScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
            let window = windowScene.windows.first,
            let navigationController = window.rootViewController as? UINavigationController {
            navigationController.interactivePopGestureRecognizer?.isEnabled = false
        }
    }

    private func enableInteractivePopGesture() {
        // Access the UINavigationController and enable the interactivePopGestureRecognizer
        if let windowScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
            let window = windowScene.windows.first,
            let navigationController = window.rootViewController as? UINavigationController {
            navigationController.interactivePopGestureRecognizer?.isEnabled = true
        }
    }

    func showAlert(message: String) {
        // Method to show an alert or handle the error visually in your app
        print(message)
    }

    //	func handleAPIResponse(data: Data) {
    //		print("METHOD: handleAPIResponse(data: Data)")
    //		do {
    //			let decodedResponse = try JSONDecoder().decode([ObjectPredictionContainer].self, from: data)
    //			DispatchQueue.main.async {
    //				for prediction in decodedResponse.map({ $0.ObjectPrediction }) {
    //					let categoryName = prediction.category.Category.name
    //					if self.predictionsByCategory[categoryName] == nil {
    //						self.predictionsByCategory[categoryName] = []
    //					}
    //					self.predictionsByCategory[categoryName]?.append(prediction)
    //				}
    //			}
    //			print("Predictions by category: \(predictionsByCategory)")
    //		} catch {
    //			print("Failed to decode response: \(error)")
    //		}
    //	}
    //
}

//
//
// "ObjectPrediction": {
//	"bbox": {
//		"BoundingBox": str((bbox.minx, bbox.miny, bbox.maxx, bbox.maxy)),
//		"w": bbox.maxx - bbox.minx,
//		"h": bbox.maxy - bbox.miny
//	},
//	"mask": obj_pred.mask,
//	"score": {
//		"PredictionScore": obj_pred.score.value
//	},
//	"category": {
//		"Category": {
//			"id": obj_pred.category.id,
//			"name": obj_pred.category.name
//		}
//	}
// }

//	func overlayView(uiImage: UIImage, geometry: GeometryProxy) -> some View {
//		print("overlayView(uiImage: UIImage, geometry: GeometryProxy) -> some View")
//		let imageScale = min(geometry.size.width / uiImage.size.width, geometry.size.height / uiImage.size.height)
//		let offsetX = (geometry.size.width - (uiImage.size.width * imageScale)) / 2
//		let offsetY = (geometry.size.height - (uiImage.size.height * imageScale)) / 2
//
//		return ForEach(predictionsByCategory.keys.sorted(), id: \.self) { category in
//			ForEach(predictionsByCategory[category]!, id: \.self) { prediction in
//				let bbox = parseBoundingBox(prediction.bbox.BoundingBox)
//				if bbox.width > 0 && bbox.height > 0 {
//					Rectangle()
//						.stroke(getColor(forCategory: category), lineWidth: 2)
//						.frame(width: bbox.width * imageScale, height: bbox.height * imageScale)
//						.offset(x: (bbox.x * imageScale) + offsetX, y: (bbox.y * imageScale) + offsetY)
//				}
//			}
//		}
//	}
struct ObjectPrediction: Identifiable, Codable {
    let id: Int
    var bbox: String
    var w: Double
    var h: Double
    var score: Double
    var categoryID: Int
    var categoryName: String
}

// Encapsulate each prediction
struct ObjectPredictionContainer: Codable, Hashable {
    let ObjectPrediction: PredictionDetails
}

// Details of each prediction
struct PredictionDetails: Codable, Hashable {
    let bbox: BoundingBox
//    let mask: String?
    let score: PredictionScore
    let category: CategoryDetails

    static func == (lhs: PredictionDetails, rhs: PredictionDetails) -> Bool {
        return lhs.category.Category.name == rhs.category.Category.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(category.Category.name)
    }
}

// Bounding box information
struct BoundingBox: Codable, Hashable {
    let BoundingBox: String
    let w: Double
    let h: Double
}

// Score of the prediction(
struct PredictionScore: Codable, Hashable {
    let PredictionScore: Double
}

// Category information nested within another "Category" key
struct CategoryDetails: Codable, Hashable {
    let Category: Category
}

// Actual category data
struct Category: Codable, Hashable {
    let id: Int
    let name: String
}

@available(iOS 17.0, *)
struct DeviceFinderAPI_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of the view with mock classCounts data
       /* DeviceFinderAPI(classCounts: mockClassCou*//*nts)*/
		DeviceFinderAPI()			.environmentObject(dataManager)



    }

    // Define your mock data for classCounts
    static let mockClassCounts: [String: Int] = [
        "Data Box": 3,
        "Dedicated Outlet": 2,
        "Duplex Outlet": 5,
        // Add more mock class counts as needed
    ]
}
