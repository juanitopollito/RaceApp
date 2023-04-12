//
//  NextView.swift
//  RunningAppMap
//
//  Created by Julian Sandoval on 4/8/23.
//

import SwiftUI

struct Sheet: View {
    var body: some View {
        VStack {
            Text("Account page")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 50.0)
            Spacer()
                
        }
    }
}

struct detailSheet: View {
    @Binding var currentCity: City
    
    var body: some View {
        Text(currentCity.name)
    }
}

struct BottomSheet_Previews: PreviewProvider {
    @State static private var previewCity = annotations[1]

    static var previews: some View {
        Sheet()
        detailSheet(currentCity: $previewCity)
    }
}
