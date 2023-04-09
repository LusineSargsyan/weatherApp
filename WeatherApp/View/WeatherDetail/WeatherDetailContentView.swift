//
//  WeatherDetailContentView.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 07.04.23.
//

import SwiftUI

struct WeatherDetailContentView: View {
    private var viewModel: WeatherDetailContentViewModel

    init(viewModel: WeatherDetailContentViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 0) {
            MainInfoView(viewModel: viewModel.mainInfoViewModel)

            Spacer()

            if let moreInfoViewModel = viewModel.moreInfoViewModel {
                MoreInfoView(viewModel: moreInfoViewModel)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .redacted(reason: viewModel.state == .loading ? .placeholder : [])
    }
}
