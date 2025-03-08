//
//  CustomButton.swift
//  Data-Structures-and-Algorithms-DSA-problems-in-Swift
//
//  Created by Anushka Samarasinghe on 2025-03-08.
//

import SwiftUI

struct CustomButton: View {
    let buttonName: String
    let buttonColor: Color
    let buttonAction: () -> Void

    var body: some View {
        Button(action: buttonAction) {
            Text(buttonName)
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(buttonColor.opacity(0.3))
        )
    }
}

#Preview {
    CustomButton(buttonName: "Sample", buttonColor: Color.blue, buttonAction: {})
}
