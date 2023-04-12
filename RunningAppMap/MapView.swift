//
//  MapView.swift
//  RunningAppMap
//
//  Created by Julian Sandoval on 4/8/23.
//

import SwiftUI
import MapKit

struct MapView: View {
	//Where map is centered
	
	@Binding var presentMapSheet: Bool
	@Binding var currentCity: City
	
	@StateObject private var viewModel = MapViewDetails()
	
    var body: some View {
		//Create the map, with annotations based off annotations array.
		Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: annotations) { annotation in
                    MapAnnotation(coordinate: annotation.coordinate) {
                        annotationContent(for: annotation)
                    }
                }
		.onAppear {
			viewModel.checkIfLocationIsEnabled()
		}

    }
	
		//Add content to annotations
        @ViewBuilder
        private func annotationContent(for city: City) -> some View {
            VStack {
                Image(systemName: "mappin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color.black)
                Button {
					presentMapSheet.toggle()
					currentCity = city
                } label: {
                    Text("Button")
                }
            }
        }
}



struct MapView_Previews: PreviewProvider {
	@State static private var previewCity = annotations[1]

    static var previews: some View {
		MapView(presentMapSheet: .constant(true), currentCity: $previewCity)
    }
}

