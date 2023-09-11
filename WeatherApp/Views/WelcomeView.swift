//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Krithik Acharya on 9/9/23.
//

import CoreLocationUI
import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        mainContent
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var mainContent: some View {
        VStack {
            greetingSection
            locationButton
        }
    }
    
    private var greetingSection: some View {
        VStack(spacing: 40) {
            welcomeText
            instructionText
        }
        .multilineTextAlignment(.center)
        .padding()
    }
    
    private var welcomeText: some View {
        Text("Your favorite Weather App!")
            .font(.title)
            .fontWeight(.bold)
    }
    
    private var instructionText: some View {
        Text("Kindly share your current location to get the weather in your area")
            .padding()
    }
    
    private var locationButton: some View {
        LocationButton(.shareCurrentLocation) {
            locationManager.requestLocation()
        }
        .applyLocationButtonStyle()
    }
}

extension View {
    func applyLocationButtonStyle() -> some View {
        self.cornerRadius(40)
            .symbolVariant(.fill)
            .foregroundColor(.white)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
