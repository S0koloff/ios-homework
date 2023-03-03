//
//  Vebinar.swift
//  VkSwiftUI
//
//  Created by Sokolov on 22.02.2023.
//

import SwiftUI

struct Universe: Identifiable {
    var id: String { name }
    let name: String
}

struct Vebinar: View {
    
    @State private var isPushEnable = false
    @State private var showToogle = true
    
    @State var speed = 50.0
    @State var isEditing = false
    
    @State var universe: Universe?
    
    var body: some View {
        //        NavigationStack {
        //
        //            VStack {
        //                NavigationLink("Show login view") {
        //                    LoginView()
        //                }
        //            }
        
        Form {
            Toggle(isOn: $isPushEnable) {
                Text("PushEnable")
                    .bold()
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                    .background(Color.red)
            }
            Toggle(isOn: $showToogle) {
                Text("Show toogle")
                    .font(.system(.body))
            }
            
            VStack {
                Slider(value: $speed, in: 0...100) {
                    isEditing in
                    self.isEditing = isEditing
                }
                Text("\(speed)")
                    .foregroundColor(speed >= 60 ? . red : .green)
                    .listRowSeparator(.hidden)
            }
            
            VStack(spacing: -10) {
                Button {
                    universe = .init(name: "Marvel")
                } label: {
                    Text("Marvel")
                }
            }
            VStack {
                
                Button {
                    universe = .init(name: "Dc")
                } label: {
                    Text("Dc")
                }
                
                .alert(item: $universe) { universe in
                    Alert(title: Text("\(universe.name)"), dismissButton: .default(Text("ok")))
                }
            }
        }
    }
}

struct Vebinar_Previews: PreviewProvider {
    static var previews: some View {
        Vebinar()
    }
}

