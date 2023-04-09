//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 06.04.23.
//

import SwiftUI

struct WeatherDetailView: View {
    @ObservedObject private var viewModel: WeatherDetailViewModel

    init(viewModel: WeatherDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .some(.empty):
                EmptyDetailView()
            case .some(.success), .some(.loading):
                WeatherDetailContentView(viewModel: viewModel.detailModel)
            default:
                EmptyView()
            }
        }
        .navigationTitle(viewModel.cityName)
        .alert(item: $viewModel.alertItem)
        .onAppear {
            viewModel.getWeatherDetails()
        }
    }
}
