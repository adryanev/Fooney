//
//  PopUpView.swift
//  Fooney
//
//  Created by Whitney Prajna Pundarika on 23/03/23.
//

import SwiftUI

struct PopUpView: View {
    @EnvironmentObject var recogd: ModelObserable

    var body: some View {
        ZStack {
            VStack(spacing: 4) {
                Text(recogd.recognizedExpression)
                    .font(
                        .system(size: 30, weight: .bold)
                    )
                    .foregroundColor(.black)
                    .padding()
                Text(recogd.showedQuote)
                    .font(.system(size: 14))
                    .foregroundColor(.black.opacity(0.8))
            }

            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
            .fixedSize()
            .frame(width: 350, height: 140)

            .multilineTextAlignment(.center)
            .background(
                RoundedRectangle(
                    cornerRadius: 20,
                    style: .circular
                )
                .stroke(Color("AccentOrange"), lineWidth: 10)
                .background(.white)
                .cornerRadius(20)
            )
            Circle()
                .foregroundColor(Color("AccentOrange"))
                .frame(width: 350, height: 70)
                .overlay(alignment: .top) {
                    Text(recogd.showedEmoji)
                        .font(.system(size: 40))
                        .padding(.top, 12)
                }
                .padding(.bottom, 140)
        }
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView().environmentObject(ModelObserable.shared)
    }
}
