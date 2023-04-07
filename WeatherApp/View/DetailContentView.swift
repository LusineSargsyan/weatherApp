//
//  DetailContentView.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 07.04.23.
//

import SwiftUI

struct DetailContentView: View {
    private var viewModel: DetailContentViewModel

    init(viewModel: DetailContentViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 0) {
            Text("Updated at \(viewModel.currentDate)")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Color.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)

            Spacer()

            Text(viewModel.description)
                .frame(maxWidth: 200)
                .font(.system(size: 28, weight: .heavy))
                .foregroundColor(Color.secondary)
                .padding(.bottom, 8)

            Text(viewModel.temp)
                .font(.system(size: 65, weight: .black))
                .foregroundColor(Color.primary)

            InfoView(viewModel: InfoViewModel(title: "Feels like", desc: viewModel.feelsLike))
                .frame(maxWidth: 150)

            if let image = viewModel.image {
                Image(uiImage: image)
            }

            Spacer()

            MoreInfoView(viewModel: MoreInfoViewModel(minTemp: viewModel.minTemp,
                                                      maxTemp: viewModel.maxTemp,
                                                      humidity: viewModel.humidity,
                                                      windSpeed: viewModel.windSpeed))
            .padding(.top, 20)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .redacted(reason: viewModel.state == .loading ? .placeholder : [])
    }
}
