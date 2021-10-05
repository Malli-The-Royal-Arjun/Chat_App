//
//  ContentView.swift
//  Chat App
//
//  Created by Happy on 19/04/21.
//

import SwiftUI

struct ContentView: View {
   
    @State var messgae = ""
    var body: some View {
        Home()
//
//        TextField("Type Something", text:$messgae)
//        Button(action:{
//
//        }){
//            Text("Send")
//        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



