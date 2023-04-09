//
//  WeatherDetailTests.swift
//  WeatherAppTests
//
//  Created by Lusine Sargsyan on 10.04.23.
//

import XCTest
import Combine
@testable import WeatherApp

final class WeatherDetailTests: XCTestCase {
    private var viewModel: WeatherDetailViewModel!
    private var subscriptions: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()

        subscriptions = []
    }

    override func tearDown() {
        super.tearDown()

        viewModel = nil
        subscriptions = nil
    }

    func testGetWeatherDetailsIsConnectedTrue() {
        let expectation = XCTestExpectation(description: "testGetWeatherDetailsIsConnectedTrue")

        viewModel = setupViewModel()
        viewModel.$detailModel
            .drop(while: { model in
                return model.image == nil
            })
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &subscriptions)

        viewModel.getWeatherDetails()

        XCTAssertEqual(viewModel.state, .loading)

        wait(for: [expectation], timeout: 5)

        guard let weatherDetail = viewModel.detailModel.weather else {
            XCTFail("weather response should not be nil")

            return
        }

        XCTAssertEqual(weatherDetail.id, 5)
        XCTAssertEqual(weatherDetail.temp, 13)
        XCTAssertEqual(weatherDetail.maxTemp, 15)
        XCTAssertEqual(weatherDetail.minTemp, 11)
        XCTAssertEqual(weatherDetail.humidity, 60)
        XCTAssertEqual(weatherDetail.windSpeed, 10)
        XCTAssertEqual(weatherDetail.name, "Gyumri")
        XCTAssertEqual(weatherDetail.feelsLike, 12.5)
        XCTAssertEqual(weatherDetail.weather?.id, 1)
        XCTAssertEqual(weatherDetail.weather?.desc, "Cloudy")
        XCTAssertEqual(weatherDetail.weather?.icon, "10d")
        XCTAssertEqual(weatherDetail.weather?.main, "main")
        XCTAssertEqual(viewModel.state, .success(weather: weatherDetail))
    }

    func testGetWeatherDetailsIsConnectedFalseNoWritingInDataBase() {
        let expectation = XCTestExpectation(description: "testGetWeatherDetailsIsConnectedFalseNoWritingInDataBase")

        viewModel = setupViewModel(isConnected: false)
        viewModel.$state
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &subscriptions)

        viewModel.getWeatherDetails()

        wait(for: [expectation], timeout: 5)

        XCTAssertNil(viewModel.detailModel.weather)
        XCTAssertEqual(viewModel.state, .empty)
    }

    func testGetWeatherDetailsIsConnectedFalseAfterWritingInDataBase() {
        let expectation = XCTestExpectation(description: "testGetWeatherDetailsIsConnectedFalseAfterWritingInDB")

        viewModel = setupViewModel()
        viewModel.$detailModel
            .drop(while: { model in
                return model.image == nil
            })
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &subscriptions)

        viewModel.getWeatherDetails()

        XCTAssertEqual(viewModel.state, .loading)

        wait(for: [expectation], timeout: 5)

        viewModel = setupViewModel(isConnected: false)

        viewModel.getWeatherDetails()

        guard let weatherDetail = viewModel.detailModel.weather else {
            XCTFail("weather response should not be nil")

            return
        }

        XCTAssertEqual(weatherDetail.id, 5)
        XCTAssertEqual(weatherDetail.temp, 13)
        XCTAssertEqual(weatherDetail.maxTemp, 15)
        XCTAssertEqual(weatherDetail.minTemp, 11)
        XCTAssertEqual(weatherDetail.humidity, 60)
        XCTAssertEqual(weatherDetail.windSpeed, 10)
        XCTAssertEqual(weatherDetail.name, "Gyumri")
        XCTAssertEqual(weatherDetail.feelsLike, 12.5)
        XCTAssertEqual(weatherDetail.weather?.id, 1)
        XCTAssertEqual(weatherDetail.weather?.desc, "Cloudy")
        XCTAssertEqual(weatherDetail.weather?.icon, "10d")
        XCTAssertEqual(weatherDetail.weather?.main, "main")
        XCTAssertEqual(viewModel.state, .success(weather: weatherDetail))
    }

    // MARK: - Private API
    private func setupViewModel(isConnected: Bool = true) -> WeatherDetailViewModel {
        let dataBase = RealmDataBase<WeatherResponse>(configuration: .init(inMemoryIdentifier: "WeatherAppTests"))
        let weatherRealmService = RealmService<WeatherResponse>(dataBase: dataBase)

        let inputs = WeatherDetailInputs(service: WeatherDetailTestService(),
                                         weatherRealmService: weatherRealmService,
                                         downloadService: WeatherIconDownloadTestService(),
                                         reachibility: ReachableTestService(isConnected: isConnected))

        return WeatherDetailViewModel(cityName: "Gyumri",
                                      inputs: inputs)
    }
}
