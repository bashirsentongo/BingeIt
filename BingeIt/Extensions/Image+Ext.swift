//
//  Image+Ext.swift
//  BingeIt
//
//  Created by Bashir Sentongo on 17/11/2024.
//

import Foundation
import SwiftUI

extension Image {
    func imageStyle(width: CGFloat = 320, height: CGFloat = 170, cornerRadius: CGFloat = 12) -> some View {
        self
            .resizable()
            .scaledToFill()
            .background(.white)
            .cornerRadius(cornerRadius)
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}
