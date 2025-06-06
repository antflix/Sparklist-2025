//
//  SwiftUIView.swift
//  SparkList
//
//  Created by Admin on 5/24/25.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)

        VStack {
            AngularGradient(gradient: /*@START_MENU_TOKEN@*/Gradient(colors: [Color.red, Color.blue])/*@END_MENU_TOKEN@*/, center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            HStack {
                Spacer()
                Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label@*/Text("Label")/*@END_MENU_TOKEN@*/
                }
                Spacer()
            }
        }
        ScrollView {
            Form {
                
            }
            Section {
                /*@PLACEHOLDER=Section Content@*/Text("Section Content")
            }
            Canvas { context, size in
                /*@PLACEHOLDER=Drawing Code@*/ 
            }
        }
            
        }
    }


#Preview {
    SwiftUIView()
    
}
