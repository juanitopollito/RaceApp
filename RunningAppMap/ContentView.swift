//
//  ContentView.swift
//  RunningAppMap
//
//  Created by Julian Sandoval on 4/7/23.
//

import SwiftUI

//might be useful, variable views?
//struct Whatever {
//     var view: AnyView
//}
//let myWhatever = Whatever(view: AnyView(CustomView))
struct ContentView: View {
    @State var presentSheet = true
    @State var presentMapSheet = false
    // Have to set a value for preview to work
    @State private var currentCity: City = annotations[0]

    //TODO prevent resizing of map when too big
    var body: some View {
        ZStack {
            //Map, 
            MapView(presentMapSheet: $presentMapSheet, currentCity: $currentCity)
                .ignoresSafeArea(.all, edges: .all)
            //view presents something
                .sheet(isPresented: $presentSheet) {
                    Sheet()
                        .presentationDetents([.height(100),.medium,.large])
                        .presentationBackgroundInteraction(.enabled(upThrough:.medium))
                    .interactiveDismissDisabled()
                    //requires ios 16.4
                    //.presentationContentInteraction(.scrolls)
                    // Inside other sheet to preserve display
                    .sheet(isPresented: $presentMapSheet) {
                        detailSheet(currentCity: $currentCity)
                        .presentationDetents([.medium,.large])
                        .presentationBackgroundInteraction(.enabled(upThrough:.medium))
                    }
                }

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
