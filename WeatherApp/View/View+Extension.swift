//
//  View+Extension.swift
//  WeatherApp
//
//  Created by Lusine Sargsyan on 07.04.23.
//

import SwiftUI

extension View {
    func alert(item: Binding<AlertItem?>) -> some View {
        let isPresented = Binding(
            get: { item.wrappedValue != nil },
            set: { value in
                if !value {
                    item.wrappedValue = nil
                }
            }
        )

        return alert(isPresented: isPresented) {
            Alert(title: Text(item.wrappedValue?.title ?? "Oups"),
                  message: Text(item.wrappedValue?.message ?? ""),
                  dismissButton: .default(Text(item.wrappedValue?.buttonTitle ?? "OK"))
            )
        }
    }
}
