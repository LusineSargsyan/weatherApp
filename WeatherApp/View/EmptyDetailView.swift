//
//  EmptyDetailView.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 06.04.23.
//

import SwiftUI

struct EmptyDetailView: View {
    var body: some View {
        VStack {
            Image("sad_cloud")
            Text("Empty data")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color.gray.opacity(0.3))
    }
}
