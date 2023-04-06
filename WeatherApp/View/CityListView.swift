//
//  ContentView.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 04.04.23.
//

import SwiftUI
import Combine
import RealmSwift

enum ManagerProvider {
    static func localResourceDataFetcher(localResourceFetcher: LocalResourceFetching = LocalResourceFetcher(),
                                         parser: Parsing = JSONDecoderParser(),
                                         responseValidator: LocalResourceValidating = LocalResourceValidator(),
                                         errorHandler: ErrorHandling = ErrorHandler()) -> LocalResourceDataFetching {
        return LocalResourceDataFetcher(localResourceFetcher: localResourceFetcher,
                                        parser: parser,
                                        responseValidator: responseValidator,
                                        errorHandler: errorHandler)
    }

    static func networkDataFetcher(networkManager: Networking = NetworkManager(),
                                   parser: Parsing = JSONDecoderParser(),
                                   responseValidator: ResponseValidating = URLResponseValidator(),
                                   errorHandler: ErrorHandling = ErrorHandler()) -> NetworkDataFetching {
        return NetworkDataFetcher(networkManager: networkManager,
                           parser: parser,
                           responseValidator: responseValidator,
                           errorHandler: errorHandler)
    }
}

enum ServiceProvider {
    static var cityList: CityListService {
        return CityListService(NetworkDataFetcher: ManagerProvider.localResourceDataFetcher())
    }

    static var weather: WeatherWebService {
        return WeatherWebService(NetworkDataFetcher: ManagerProvider.networkDataFetcher())
    }

    static func download(networking: Networking = NetworkManager()) -> DownloadService {
        return DownloadService(networking: networking)
    }

    static func realmService<T: Object>() -> RealmService<T> {
        return RealmService<T>(dataBase: RealmDataBase<T>())
    }
}

enum ViewModelProvider {
    static func weatherDetail(cityName: String) -> WeatherDetailViewModel {
        let weatherDetailInputs = WeatherDetailInputs(service: ServiceProvider.weather,
                                                      weatherRealmService: ServiceProvider.realmService(),
                                                      downloadService: ServiceProvider.download())

        return WeatherDetailViewModel(cityName: cityName, inputs: weatherDetailInputs)
    }
}

struct CityListView: View {
    @StateObject var viewModel = CityListViewModel(inputs: CityListInputs(service: ServiceProvider.cityList))

    var body: some View {
        NavigationStack {
            List(viewModel.cityNames, id: \.self) { cityName in
                NavigationLink {
                    WeatherDetailView(viewModel: ViewModelProvider.weatherDetail(cityName: cityName))
                } label: {
                    Text(cityName)
                }
            }
        }
        .alert(item: $viewModel.alertItem)
        .onAppear {
            viewModel.getCityList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView()
    }
}
