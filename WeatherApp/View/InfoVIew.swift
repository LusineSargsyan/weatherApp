//
//  InfoVIew.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 07.04.23.
//

import SwiftUI

struct InfoView: View {
    private let viewModel: InfoViewModel

    init(viewModel: InfoViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack {
            Text(viewModel.title)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Color.secondary)

            Spacer()

            Text(viewModel.desc)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color.primary)
        }
    }
}
