//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Krithik Acharya on 9/9/23.
//

import Foundation
import CoreLocation
import Firebase
import FirebaseDatabase


class WeatherManager {
    
    var ref: DatabaseReference!
    
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\("8437f927f15af6bfbe99eec87023d0c1")&units=imperial") else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
                
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        let jsonData = data
        
        let decoder = JSONDecoder()
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching weather data")
        }
        
        ref = Database.database().reference()
        
        let responseBody = try decoder.decode(ResponseBody.self, from: jsonData)
        
        // Save responseBody to Firebase
        do {
            let weatherData = try JSONEncoder().encode(responseBody)
            if let weatherDataJSON = try? JSONSerialization.jsonObject(with: weatherData, options: []) {
                try await self.ref.child("weather_data").setValueAsync(weatherDataJSON)
                print("Weather data saved successfully!")
            }
        } catch {
            print("Weather data could not be saved: \(error).")
        }
        
        return responseBody
    }
}

// Model of the response body we get from calling the OpenWeather API
struct ResponseBody: Codable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Codable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Codable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Codable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Codable {
        var speed: Double
        var deg: Double
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}

extension DatabaseReference {
    func setValueAsync(_ value: Any) async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            self.setValue(value) { (error, _) in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
}

