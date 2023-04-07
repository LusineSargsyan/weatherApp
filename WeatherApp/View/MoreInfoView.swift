//
//  MoreInfoView.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 07.04.23.
//

import SwiftUI

struct MoreInfoView: View {
    private let viewModel: MoreInfoViewModel

    init(viewModel: MoreInfoViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            Divider()

            Text("More info")
                .font(.system(size: 18, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 24)

            VStack {
                InfoView(viewModel: InfoViewModel(title: "Min temp", desc: viewModel.minTemp))
                InfoView(viewModel: InfoViewModel(title: "Max temp", desc: viewModel.maxTemp))
                InfoView(viewModel: InfoViewModel(title: "Humidity", desc: viewModel.humidity))
                InfoView(viewModel: InfoViewModel(title: "Wind Speed", desc: viewModel.windSpeed))
            }
            .padding(.horizontal, 24)
        }
        .frame(maxWidth: .infinity)
    }
}
