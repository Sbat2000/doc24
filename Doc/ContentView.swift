//
//  ContentView.swift
//  Doc
//
//  Created by Aleksandr Garipov on 14.03.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List() {
            ForEach(0..<5) { _ in
                DoctorPreviewView()
                    .onTapGesture {
                        // Здесь ваш код для обработки касания по ячейке
                        print("Ячейка была нажата")
                    }
            }
            //.listRowInsets(EdgeInsets())
        }
        .listStyle(.automatic)
        .listRowSpacing(16)
    }
}

#Preview {
    ContentView()
}
