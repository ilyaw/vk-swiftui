//
//  NeutralButtonStyle.swift
//  VKClient
//
//  Created by Ilya on 06.11.2021.
//

import SwiftUI

struct NeutralButtonStyle: ButtonStyle
{
    func makeBody(configuration: Configuration) -> some View
    {
        configuration.label
    }
}
