import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack(spacing: 10) {
            
            if let userLocation = locationManager.location {
                if let currentWeather = weather {
                    WeatherView(weather: currentWeather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: userLocation.latitude, longitude: userLocation.longitude)
                            } catch {
                                print("Failed to fetch weather: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.gettingLocation {
                    ProgressView("Fetching location...")
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(.black))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

