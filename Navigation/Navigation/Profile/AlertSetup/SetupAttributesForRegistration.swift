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
    attributes.displayDuration = .infinity
    attributes.entryBackground =  .color(color: .init(light: .white, dark: UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)))
    attributes.screenBackground = .color(color: .init(light: UIColor(white: 100.0/255.0, alpha: 0.9), dark: UIColor(white: 50.0/255.0, alpha: 0.9)))
    attributes.shadow = .active(
        with: .init(
            color: .black,
            opacity: 0.3,
            radius: 8
        )
    )
    
    let offset = EKAttributes.PositionConstraints.KeyboardRelation.Offset(bottom: 10, screenEdgeResistance: 20)
    let keyboardRelation = EKAttributes.PositionConstraints.KeyboardRelation.bind(offset: offset)
    attributes.positionConstraints.keyboardRelation = keyboardRelation
    
    attributes.screenInteraction = .dismiss
    attributes.entryInteraction = .absorbTouches
    
    return attributes
}



