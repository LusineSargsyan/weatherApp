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
                .padding(.bottom, 10)

            VStack {
                ForEach(viewModel.dataSource, id: \.title) { item in
                    InfoView(viewModel: InfoViewModel(title: item.title, value: item.value))
                }
            }
            .padding(.horizontal, 24)
        }
        .frame(maxWidth: .infinity)
    }
}

struct MoreInfoView_Previews: PreviewProvider {
    static var previews: some View {
//        MoreInfoView(viewModel: MoreInfoViewModel(weather: WeatherResponse())
        Color.cyan
    }
}
