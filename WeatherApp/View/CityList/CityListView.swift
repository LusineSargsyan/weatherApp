//
//  ContentView.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 04.04.23.
//

import SwiftUI
import Combine

struct CityListView: View {
    @StateObject private var viewModel = ViewModelProvider.cityList

    var body: some View {
        NavigationView {
            ZStack {
                List(viewModel.cityNames, id: \.self) { cityName in
                    NavigationLink {
                        WeatherDetailView(viewModel: ViewModelProvider.weatherDetail(cityName: cityName))
                    } label: {
                        Text(cityName)
                            .foregroundColor(.primary)
                            .font(.system(size: 20))
                    }
                }
                .background(Color.clear)
                .listStyle(.plain)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 20)
            .navigationTitle("Cities")
        }
        .alert(item: $viewModel.alertItem)
        .onAppear {
            viewModel.getCityList()
        }
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView()
    }
}
