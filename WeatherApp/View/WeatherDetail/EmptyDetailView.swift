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

            Text("Weather info not found")
                .font(.system(size: 18))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}

struct EmptyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyDetailView()
    }
}
