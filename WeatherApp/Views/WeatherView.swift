// WeatherView.swift
// WeatherApp
// Created by Krithik Acharya on 9/10/23.

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody

    var body: some View {
        ZStack {
            ColorBackground()
            
            VStack {
                HeaderSection(weather: weather)
                
                Spacer()
                
                MainClimateInfo(weather: weather)
                
                Spacer()
                
                AdditionalClimateData(weather: weather)
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.bottom)
        .preferredColorScheme(.dark)
    }
}

struct ColorBackground: View {
    var body: some View {
        Color(.black).preferredColorScheme(.dark)
            .ignoresSafeArea()
    }
}

struct HeaderSection: View {
    var weather: ResponseBody
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(weather.name)
                .bold()
                .font(.largeTitle)
                .foregroundColor(.white)
            
            Text("As of \(Date().formatted(.dateTime.month().day().hour().minute()))")
                .foregroundColor(.white)
                .fontWeight(.light)
        }
    }
}

struct MainClimateInfo: View {
    var weather: ResponseBody
    
    var body: some View {
        HStack {
            Image(systemName: "cloud.fill")
                .resizable()
                .frame(width: 75, height: 50)
                .foregroundColor(.white)
            
            Text("\(weather.weather[0].main)")
                .foregroundColor(.white)
                .font(.headline)
            
            Spacer()
            
            Text("\(weather.main.feelsLike.roundDouble())°")
                .font(.system(size: 80))
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}

struct AdditionalClimateData: View {
    var weather: ResponseBody
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Current Weather Details")
                .bold()
                .padding(.bottom)
                .foregroundColor(.white)
            
            InfoRow(icon: "thermometer", label: "Low Temp", value: "\(weather.main.tempMin.roundDouble())°")
            InfoRow(icon: "thermometer", label: "High Temp", value: "\(weather.main.tempMax.roundDouble())°")
            InfoRow(icon: "wind", label: "Wind Speed", value: "\(weather.wind.speed.roundDouble()) m/s")
            InfoRow(icon: "drop.fill", label: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
            InfoRow(icon: "barometer", label: "Pressure", value: "\(weather.main.pressure.roundDouble()) hPa")
            InfoRow(icon: "sun.min.fill", label: "Feels Like", value: "\(weather.main.feelsLike.roundDouble())°")
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
        .foregroundColor(.white)
    }
}

struct InfoRow: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
            
            Text("\(label): \(value)")
                .foregroundColor(.white)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}

