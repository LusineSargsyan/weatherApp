//
//  CityListViewModelTests.swift
//  WeatherAppTests
//
//  Created by Lusine Sargsyan on 09.04.23.
//

import XCTest
import Combine
@testable import WeatherApp

final class CityListViewModelTests: XCTestCase {
    private var viewModel: CityListViewModel!
    private var subscriptions: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()

        let inputs = CityListInputs(service: CityListTestService())
        viewModel = CityListViewModel(inputs: inputs)
        subscriptions = []
    }

    override func tearDown() {
        super.tearDown()

        viewModel = nil
        subscriptions = nil
    }

    func testGetCityList() {
        let expectation = XCTestExpectation(description: "CityListTest")

        viewModel.$cityNames
            .dropFirst()
            .sink(receiveValue: { _ in
            expectation.fulfill()
        })
        .store(in: &subscriptions)

        viewModel.getCityList()
        wait(for: [expectation], timeout: 2)

        XCTAssertEqual(viewModel.cityNames.count, 1)
        XCTAssertEqual(viewModel.cityNames.first, "Gyumri")
    }
}
