//
//  SetupAttributesForRegistration.swift
//  Navigation
//
//  Created by Sokolov on 09.01.2023.
//

import UIKit
import SwiftEntryKit

func setupAttributesForRegistration() -> EKAttributes {
    
    var attributes = EKAttributes.centerFloat
    attributes.position = .top
    attributes.displayDuration = .infinity
    attributes.entryBackground =  .color(color: .white)
    attributes.screenBackground = .color(color: .init(light: UIColor(white: 100.0/255.0, alpha: 0.9), dark: UIColor(white: 50.0/255.0, alpha: 0.9)))
    attributes.shadow = .active(
        with: .init(
            color: .black,
            opacity: 0.3,
            radius: 8
        )
    )
    attributes.screenInteraction = .dismiss
    attributes.entryInteraction = .absorbTouches
    
    return attributes
}



