//
//  DoctorPreviewView.swift
//  Doc
//
//  Created by Aleksandr Garipov on 14.03.2024.
//

import SwiftUI

struct DoctorPreviewView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            HStack(alignment: .top) {
                Image("doc") 
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .padding(.trailing, 20)
                VStack(alignment: .leading, spacing: 8) {
                    Text("Осташков \nКирилл Вячеславович")
                        .font(.headline)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    HStack {
                        ForEach(0..<5) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.doct24Pink)
                        }
                        .font(.system(size: 12))
                        .padding(-2.2)
                    }
                    Text("Педиатр • стаж 9 лет")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("от 400 ₽")
                        .font(.title)
                }
                Spacer()
                Button(action: {
                    print("Like")
                }) {
                    Image(systemName: "heart")
                        .foregroundColor(.gray)
                }
                .font(.system(size: 24))
                .buttonStyle(PlainButtonStyle())
            }
            
            Button(action: {
                print("Записаться")
            }) {
                Text("Записаться")
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.doct24Pink)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
        }
        //.padding()
        .background(Color.white)
        //.cornerRadius(15)
    }
}

struct DoctorView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorPreviewView()
    }
}
