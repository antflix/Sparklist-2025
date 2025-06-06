//import SwiftUI
//@available(iOS 17.0, *)
//struct SwipingTimeView: View {
//		@EnvironmentObject var dataManager: DataManager
//
//	@State private var selectedScreen = 0
//
//	var body: some View {
//		TabView(selection: $dataManager.timeSelector) {
//			VStack {
//					JobsView()
//
//				}.tag(0)
//				VStack {
//					EmployeeView()
//
//				}.tag(1)
//
//				VStack {
//					EmployeesViews()
//
//				}.tag(2)
//				VStack {
//
//					PreViews()
//				}.tag(3)
//		}
//		.onChange(of: dataManager.timeSelector) { _ in
//			withAnimation(.easeInOut(duration: 2.0)) { // Use your preferred animation and duration
//													   // This block can be empty since the animation is applied to the binding change.
//			}
//		}
//		.tabViewStyle(.page(indexDisplayMode: .never))
//		.toolbar {
//			ToolbarItem(placement: .bottomBar) {
//				HStack {
//					Button(action: { withAnimation { dataManager.timeSelector = 0 } }) {
//						VStack {
//							Image(systemName: "house")
//							Text("Home").font(.caption2)
//						}
//					}
//					.foregroundColor(dataManager.timeSelector == 0 ? .accentColor : .primary)
//					.frame(maxWidth: .infinity)
//
//					Button(action: { withAnimation { dataManager.timeSelector = 1 } }) {
//						VStack {
//							Image(systemName: "calendar")
//							Text("Calendar").font(.caption2)
//						}
//					}
//					.foregroundColor(dataManager.timeSelector == 1 ? .accentColor : .primary)
//					.frame(maxWidth: .infinity)
//
//					Button(action: { withAnimation { dataManager.timeSelector = 2 } }) {
//						VStack {
//							Image(systemName: "gear")
//							Text("Settings").font(.caption2)
//						}
//					}
//					.foregroundColor(dataManager.timeSelector == 2 ? .accentColor : .primary)
//					.frame(maxWidth: .infinity)
//				}
//				.buttonStyle(.plain)
//				.labelStyle(.titleAndIcon)
//			}
//		}
//	}
//}
