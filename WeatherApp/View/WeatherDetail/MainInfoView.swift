//
//  MainInfoView.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 08.04.23.
//

import SwiftUI

struct MainInfoView: View {
    private var viewModel: WeatherMainInfoViewModel?

    init(viewModel: WeatherMainInfoViewModel?) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 0) {
            Text(viewModel?.updatedDate ?? "".placeholderIfEmpty())
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Color.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)

            Spacer()

            Text(viewModel?.description ?? "".placeholderIfEmpty(count: 12))
                .font(.system(size: 28, weight: .heavy))
                .foregroundColor(Color.secondary)
                .padding(.bottom, 8)

            Text(viewModel?.tempreture ?? "".placeholderIfEmpty())
                .font(.system(size: 65, weight: .black))
                .foregroundColor(Color.primary)

            InfoView(viewModel: InfoViewModel(title: "Feels like", value: viewModel?.feelsLike ?? "".placeholderIfEmpty()))
                .frame(maxWidth: 150)

            if let image = viewModel?.image {
                Image(uiImage: image)
            }

            Spacer()
        }
    }
}
