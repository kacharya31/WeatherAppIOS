//
//  WeatherRow.swift
//  WeatherApp
//
//  Created by Krithik Acharya on 9/10/23.
//

import SwiftUI

struct WeatherRow: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        HStack(spacing: 18) {
            Image(systemName: logo)
                .font(.title3)
                .frame(width: 22, height: 22)
                .padding(.all, 8)
                .background(Color(hue: 0.99, saturation: 0.0, brightness: 0.89))
                .cornerRadius(45)

            VStack(alignment: .leading, spacing: 10) {
                Text(name)
                    .font(.callout)
                
                Text(value)
                    .fontWeight(.semibold)
                    .font(.title2)
            }
        }
    }

}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(logo: "thermometer", name: "Feels like", value: "8°")
    }
}
