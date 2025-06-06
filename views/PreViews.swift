////
////  PreView.swift
////  project1
////
////  Created by User on 11/24/23.
////
//
//import Foundation
//// import MessageUI
//import SwiftUI
//struct TimeKey: Hashable {
//    let hours: String
//    let minutes: String
//}
//
//@available(iOS 17.0, *)
//struct PreViews: View {
//    @EnvironmentObject var dataManager: DataManager
//    @State private var navigateBack = false
//    @State private var showAlertSuccess = false
//    @State private var showAlert = false
//    @State private var alertMessage = ""
//    @State private var showPicker = false
//    @State private var selectedNumber: Int = 0
//    @State private var selectedUUID: UUID?
//    @State private var noteText: String = ""
//    @State private var showNoteEntry: Bool = false
//	@State private var navigateToStartView: Bool = false
//    private let numbers = Array(0 ... 100) // Example range of numbers
//
//    func groupAndPrepareData() {
//        let projectID = dataManager.selectedJobID
//        let projectName = dataManager.selectedJobName
//        var groupedEmployees = [TimeKey: [String]]()
//
//        for (employeeName, hoursString) in dataManager.employeeData {
//            let components = hoursString.components(separatedBy: " ")
//            let hours = components[0]
//            let minutes = components.count > 2 ? components[2] : "0"
//            let key = TimeKey(hours: hours, minutes: minutes)
//
//            if groupedEmployees[key] != nil {
//                groupedEmployees[key]?.append(employeeName)
//            } else {
//                groupedEmployees[key] = [employeeName]
//            }
//        }
//
//        for (timeKey, employeeNames) in groupedEmployees {
//            let employeeString = employeeNames.joined(separator: "; ")
//            let jsonBody: [String: Any] = [
//                "selectedEmployee": employeeString,
//                "projectName": projectName,
//                "projectID": projectID,
//                "hours": timeKey.hours,
//                "minutes": timeKey.minutes,
//                // "note": note,(place holder for optional "note" String. Will be populated from the "plus" button on each of the items in the list on the view
//            ]
//            dataManager.jsonBodiesLocal.append((id: UUID(), jsonBody: jsonBody))
//        }
//        dataManager.jsonBodies = dataManager.jsonBodiesLocal
//    }
//
//    func submitTime(completion: @escaping (Bool, Error?) -> Void) {
//        let projectID = dataManager.selectedJobID
//        let projectName = dataManager.selectedJobName
//        var groupedEmployees = [TimeKey: [String]]()
//        // Streep 3: Loop through jsonBodies to print details and make API calls
//        for tuple in dataManager.jsonBodiesLocal {
//            //			print("Inside the tuple json Bodies loop")
//            let jsonBody = tuple.jsonBody
//            if let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody, options: []) {
//                // Print each projectID/employee/hours/minutes separately
//                if let projectID = jsonBody["projectID"] as? String,
//                   let projectName = jsonBody["projectName"] as? String,
//                   let employeeString = jsonBody["selectedEmployee"] as? String,
//                   let hours = jsonBody["hours"] as? String,
//                   let minutes = jsonBody["minutes"] as? String {
////                    print("Project ID: \(projectID), Employees: \(employeeString), Hours: \(hours), Minutes: \(minutes)")
//                }
//
//                // Make the API call for each jsonBody
//				makeAPICall(with: jsonData, completion: { success, error in
//					if success {
//						alertMessage = "Time submitted successfully for project: \(jsonBody["projectID"] ?? "")"
//						showAlert = true
//						navigateBack = true // Assuming `navigateBack` controls whether the API call was successful.
//						completion(true, nil)
//					} else if let error = error {
//						alertMessage = "Error submitting time for project: \(jsonBody["projectID"] ?? ""): \(error.localizedDescription)"
//						showAlert = true
//						completion(false, error)
//					}
//				})
//                print("Failed to create JSON data for project: \(jsonBody["projectID"] ?? "")")
//                completion(false, nil)
//            }
//        }
//
//        dataManager.jsonBodies = dataManager.jsonBodiesLocal
//        //
//    }
//
//    func makeAPICall(with jsonData: Data, completion: @escaping (Bool, Error?) -> Void) {
////         Convert jsonData to a String and print it for testing purposes
//        print("makeAPICall(with jsonData: Data, completion: @escaping (Bool, Error?) -> Void) {")
//        if let jsonString = String(data: jsonData, encoding: .utf8) {
//            print("JSON String to be sent to the server for testing:\n")
//            print("\(jsonString)\n")
//        }
//
//        // Create the URL and URLRequest
//        guard let url = URL(string: "https://api.antflix.net/submit_time") else {
//            completion(false, nil)
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = jsonData
//        print(jsonData)
////        	 Perform the API request
//
//			let task = URLSession.shared.dataTask(with: request) { _, response, error in
//				DispatchQueue.main.async {
//					if let error = error {
//						completion(false, error)
//					} else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
//						completion(true, nil)
//					} else {
//						completion(false, nil)
//					}
//				}
//			}
//			
//			task.resume()
//
//    }
//	func deleteItem(with uuid: UUID) {
//		if let index = dataManager.jsonBodiesLocal.firstIndex(where: { $0.id == uuid }) {
//			DispatchQueue.main.async {
//				dataManager.jsonBodiesLocal.remove(at: index)
//			}
//		}
//	}
//    var body: some View {
////        let smsURLString = "sms:/open?addresses=\(retrieveAndFormatContacts())&body=\(dataManager.allSMSs)"
//
//        //      let deviceBg = #colorLiteral(red: 0, green: 0.3725490196, blue: 1, alpha: 1)
//
//        VStack {
//            HStack {
////                Button(action: {
////                    // Call the function here
////                    dataManager.clearSMS()
////
////                    // Navigate to the second view
////                    navigateBack = true
////                }) {
////                    Image(systemName: "arrow.left")
////                        .foregroundColor(.white)
////                        .buttonStyle(PlainButtonStyle())
////                }
////
////                NavigationLink(destination: EmployeesViews(), isActive: $navigateBack) {
////                    EmptyView()
////                }
//
//                Text("Hours Preview").font(Font.custom("Quicksand", size: 30).bold())
//                    .frame(maxWidth: .infinity * 0.90, alignment: .center)
//            }
//            .padding()
//            .background(dataManager.themeColor)
//            .foregroundColor(.white)
//            .font(.headline)
//
//			ScrollView {
//				LazyVStack(alignment: .leading) {
//					ForEach(dataManager.jsonBodiesLocal, id: \.id) { item in
//						Divider().frame(height: 4.0).background(
//							Color("Color 2")
//						).padding(.horizontal, 0)
//                        Section(header:
//									HStack {
//							Text("\(item.jsonBody["projectName"] ?? "")")
//							//                            .backgroundStyle(Color.darkGray)
//								.padding(.leading)
//								.foregroundColor(Color.green)
//								.padding(.bottom, 0)
//							Spacer()
//							Button(action: {
//								self.deleteItem(with: item.id)
//							}) {
//								Image(systemName: "trash")
//									.background(Color.clear)
//									.padding(.trailing)
//									.foregroundColor(.red)
//									.shadow(radius: 3)
//							}.buttonStyle(PlainButtonStyle())
//						}
//                        )
//						{
//                            VStack(alignment: .leading) {
//                                //							.font(.largeTitle)
//                                //							.foregroundColor(Color.green)
//                                //							.lineSpacing(50)
//                                //							.lineLimit(nil)
//                                //							.padding(){
//								Divider().frame(height: 2.0).background(
//									Color("toolbar")
//								).padding(.horizontal, 0)
//                                HStack {
//									Image(systemName: "person.3.fill")
//										.padding(.leading, 4)
//                                    Text("Employees: ")
//                                        .foregroundStyle(Color.blue)
//
//                                    Text("\(item.jsonBody["selectedEmployee"] ?? "")")
//                                }.padding(2)
//                                HStack {
//									Image(systemName: "clock.arrow.2.circlepath")
//										.padding(.leading, 4)
//
//                                    Text("Time: ")
//                                        .foregroundStyle(Color.blue)
//                                    Text("\(item.jsonBody["hours"] ?? "") hours, \(item.jsonBody["minutes"] ?? "") minutes")
//                                }.padding(2)
//                                HStack {
//									Image(systemName: "truck.pickup.side")
//										.padding(.leading, 4)
//
//                                    Text("Drive time: ")
//                                        .foregroundStyle(Color.blue)
//
//                                    if let note = item.jsonBody["note"] as? String, !note.isEmpty {
//                                        Text(note) // Display the note if it exists and is not empty
//                                    } else {
//                                        Button(action: {
//                                            self.selectedUUID = item.id
//                                            self.showNoteEntry = true
//                                        }) {
//                                            Text("Add Note")
//                                                .foregroundColor(.white)
//                                                .padding(2)
//                                                .background(Color.blue)
//                                                .cornerRadius(5)
//                                        }.buttonStyle(PlainButtonStyle())
//                                    }
//                                }.padding(2)
//
//                            }
//
//                            .sheet(isPresented: $showNoteEntry) {
//                                NoteEntryView(noteText: $noteText, onSave: {
//                                    self.addNoteToItem()
//                                })
//                            }
//
//
//                        }
//
//                    }.backgroundStyle(Color.clear)
//                        .onAppear {
//                            print("list:\(dataManager.jsonBodies)")
//                        }
//                        .foregroundColor(.white)
//
//                        .multilineTextAlignment(.leading) // Aligning the text to the right
//                        .font(.system(size: 14.0))
//
//                }.background(Color.clear)
//                Spacer()
//                Divider().frame(height: 1.0).background(
//                    Color("Color 6")
//                )
//            }
//
//			.background(Color("Color 8"))
//            .clipShape(RoundedRectangle(cornerRadius: 5)) // Adding rounded corners
//            .overlay(
//                RoundedRectangle(cornerRadius: 5) // Overlay for border
//                    .stroke(Color("Color 6"), lineWidth: 1)
//            )
//            Spacer()
//            VStack {
//                Button(action: {
//                    submitTime { success, error in
//                        if success {
//                            alertMessage = "Time submitted successfully."
//                            showAlert = true
//                            dataManager.jsonBodiesLocal.removeAll()
//
//                        } else if let error = error {
//                            alertMessage = "Error submitting time: \(error.localizedDescription)"
//                            showAlert = true
//                        }
//                    }
//                }) {
//                    Text("Submit Time")
//                        .font(.title)
//                        .foregroundColor(Color.green)
//                        .background(Color.clear)
//                    Image(systemName: "arrow.up.circle.fill")
//                        .background(Color.clear)
//                        .foregroundStyle(Color.green)
//                        .font(.title)
//                }
//                .alert(isPresented: $showAlert) {
//                    Alert(title: Text("Submission Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//                }
//
//                .buttonStyle(PlainButtonStyle()) //
//                .padding()
//                NavigationLink(destination: JobsView().navigationBarHidden(true)) {
//                    HStack {
//                        Text("Add More Time")
//                            .foregroundColor(Color.orange)
//                            .background(Color.clear)
//
//                        Image(systemName: "hourglass.badge.plus")
//                            .foregroundColor(Color.orange)
//                            .font(.title)
//                            .background(Color.clear)
//                    }
//                }
//                .ignoresSafeArea()
//                .buttonStyle(PlainButtonStyle())
////                .navigationBarBackButtonHidden(true)
////                .navigationBarHidden(true)
//                .onAppear {
//                    groupAndPrepareData()
//                }
//                Divider().frame(height: 2.0).background(
//                    Color("toolbar")
//                ).padding(.horizontal, 0)
//            }
//			NavigationLink(destination: StartView(), isActive: $navigateToStartView) {
//				EmptyView()
//			}
//		}
//		.alert(isPresented: $showAlert) {
//			Alert(
//				title: Text("Submission Status"),
//				message: Text(alertMessage),
//				dismissButton: .default(Text("OK"), action: {
//					if navigateBack {
//						navigateToStartView = true
//					}
//				})
//			)
//		}
//        .toolbar { MyToolbarItems() }
//        .background(Color("Color 7"))
//        .navigationBarBackButtonHidden(true) // Hides the back button
//        .navigationBarHidden(true)
//        .onChange(of: dataManager.isDarkMode) { newValue in
//            UserDefaults.standard.set(newValue, forKey: "isDarkMode")
//            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//               let window = windowScene.windows.first {
//                window.rootViewController?.overrideUserInterfaceStyle = newValue ? .dark : .light
//            }
//        }
//
//        //            .alert(isPresented: $showAlert) {
//        //                Alert(
//        //                    title: Text("Enter Phone Number"),
//        //                    message: Text("Please enter a phone number"),
//        //                    Button: .default(
//        //                        Text("Add Phone Number"),
//        //                        action: {
//        //                            // Toggle popover state
//        //                            settingsPopover.toggle()
//        //                        }),
//        //                    Button: .cancel(Text("Cancel"))
//        //
//        //                )
//
//        //                            dismissButton: .default(Text("OK"))
//    }
//
//    func addNoteToItem() {
//        if let uuid = selectedUUID, let index = dataManager.jsonBodiesLocal.firstIndex(where: { $0.id == uuid }) {
//            var item = dataManager.jsonBodiesLocal[index]
//            item.jsonBody["note"] = noteText
//            DispatchQueue.main.async {
//                dataManager.jsonBodiesLocal[index] = item
//            }
//        }
//        showNoteEntry = false // Dismiss the sheet
//    }
//}
//
//func generateSMSBody() {
//    let sortedOutput = SMSGenerator.sortedFormat(dataManager: dataManager)
//    let smsBodyWithDate = SMSGenerator.generateSMSURL(
//        sortedOutput: sortedOutput)
//    // Append the generated SMS body to the array
//    if dataManager.allSMSBodies.last != smsBodyWithDate {
//        dataManager.allSMSBodies.append(smsBodyWithDate)
//    }
//    //        dataManager.allSMSBodies.append(smsBodyWithDate)
//
//    // Update savedData to show all stored SMS bodies
//    dataManager.allSMSs = dataManager.allSMSBodies.joined(separator: "\n\n")
//}
//
//struct NoteEntryView: View {
//    @Binding var noteText: String
//    var onSave: () -> Void
//    @State private var selectedDriveTimeIndex: Int = 0
//
//    var body: some View {
//        NavigationView {
//            ZStack(alignment: .bottom) {
//                Picker("Drive Time Hours", selection: $selectedDriveTimeIndex) {
//                    ForEach(0 ..< 49, id: \.self) { index in
//                        let hours = index / 2
//                        let minutes = (index % 2) * 30
//                        if minutes == 0 {
//                            Text("\(hours) hours drive time")
//                                .foregroundColor(Color("Color 3"))
//
//                                .tag(index)
//                        } else {
//                            Text("\(hours) hours \(minutes) minutes drive time")
//                                .foregroundColor(Color("Color 3"))
//                                .tag(index)
//                        }
//                    }
//                }
//                .pickerStyle(WheelPickerStyle())
//                .labelsHidden()
//                .navigationBarTitle("Add Note", displayMode: .inline)
//
//                Button("Save") {
//                    // Convert the selected index to a drive time string
//                    let hours = selectedDriveTimeIndex / 2
//                    let minutes = (selectedDriveTimeIndex % 2) * 30
//                    noteText = "\(hours) hours \(minutes != 0 ? "\(minutes) minutes" : "") drive time"
//                    onSave()
//                }
//            }
//        }
//    }
//}
//
//func retrieveAndFormatContacts() -> String {
//    let savedContacts = dataManager.retrieveSelectedContacts()
//
//    // Extract the wewwwwwwwwfd                                               ffgfirst phone number of each contact and join them with a comma
//    let phoneNumbersString = savedContacts.compactMap { contact -> String? in
//        guard let firstPhoneNumber = contact.phoneNumbers.first?.value.stringValue else {
//            return nil // Skip contacts without phone numbers
//        }
//        print("firstphonenumber- \(firstPhoneNumber)")
//        return firstPhoneNumber
//    }.joined(separator: ", ")
//    print("phonenumberString- \(phoneNumbersString)")
//
//    return phoneNumbersString // Return the formatted string
//}
//
//func sendMessage(sms: String) {
//    guard let strURL = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
//          let url = URL(string: strURL)
//    else { return }
//
//    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//    dataManager.stopPersistentAlarm()
//    //		stopPersistentNotifications()
//}
//
////
////
//// struct BubbleShape: Shape {
////    var myMessage: Bool
////    func path(in rect: CGRect) -> Path {
////        let width = rect.width
////        let height = rect.height
////
////        let bezierPath = UIBezierPath()
////        if !myMessage {
////            bezierPath.move(to: CGPoint(x: 20, y: height))
////            bezierPath.addLine(to: CGPoint(x: width - 15, y: height))
////            bezierPath.addCurve(to: CGPoint(x: width, y: height - 15), controlPoint1: CGPoint(x: width - 8, y: height), controlPoint2: CGPoint(x: width, y: height - 8))
////            bezierPath.addLine(to: CGPoint(x: width, y: 15))
////            bezierPath.addCurve(to: CGPoint(x: width - 15, y: 0), controlPoint1: CGPoint(x: width, y: 8), controlPoint2: CGPoint(x: width - 8, y: 0))
////            bezierPath.addLine(to: CGPoint(x: 20, y: 0))
////            bezierPath.addCurve(to: CGPoint(x: 5, y: 15), controlPoint1: CGPoint(x: 12, y: 0), controlPoint2: CGPoint(x: 5, y: 8))
////            bezierPath.addLine(to: CGPoint(x: 5, y: height - 10))
////            bezierPath.addCurve(to: CGPoint(x: 0, y: height), controlPoint1: CGPoint(x: 5, y: height - 1), controlPoint2: CGPoint(x: 0, y: height))
////            bezierPath.addLine(to: CGPoint(x: -1, y: height))
////            bezierPath.addCurve(to: CGPoint(x: 12, y: height - 4), controlPoint1: CGPoint(x: 4, y: height + 1), controlPoint2: CGPoint(x: 8, y: height - 1))
////            bezierPath.addCurve(to: CGPoint(x: 20, y: height), controlPoint1: CGPoint(x: 15, y: height), controlPoint2: CGPoint(x: 20, y: height))
////        } else {
////            bezierPath.move(to: CGPoint(x: width - 20, y: height))
////            bezierPath.addLine(to: CGPoint(x: 15, y: height))
////            bezierPath.addCurve(to: CGPoint(x: 0, y: height - 15), controlPoint1: CGPoint(x: 8, y: height), controlPoint2: CGPoint(x: 0, y: height - 8))
////            bezierPath.addLine(to: CGPoint(x: 0, y: 15))
////            bezierPath.addCurve(to: CGPoint(x: 15, y: 0), controlPoint1: CGPoint(x: 0, y: 8), controlPoint2: CGPoint(x: 8, y: 0))
////            bezierPath.addLine(to: CGPoint(x: width - 20, y: 0))
////            bezierPath.addCurve(to: CGPoint(x: width - 5, y: 15), controlPoint1: CGPoint(x: width - 12, y: 0), controlPoint2: CGPoint(x: width - 5, y: 8))
////            bezierPath.addLine(to: CGPoint(x: width - 5, y: height - 12))
////            bezierPath.addCurve(to: CGPoint(x: width, y: height), controlPoint1: CGPoint(x: width - 5, y: height - 1), controlPoint2: CGPoint(x: width, y: height))
////            bezierPath.addLine(to: CGPoint(x: width + 1, y: height))
////            bezierPath.addCurve(to: CGPoint(x: width - 12, y: height - 4), controlPoint1: CGPoint(x: width - 4, y: height + 1), controlPoint2: CGPoint(x: width - 8, y: height - 1))
////            bezierPath.addCurve(to: CGPoint(x: width - 20, y: height), controlPoint1: CGPoint(x: width - 15, y: height), controlPoint2: CGPoint(x: width - 20, y: height))
////        }
////        return Path(bezierPath.cgPath)
////    }
//// }
