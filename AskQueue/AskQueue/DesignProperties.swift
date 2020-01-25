//
//  DesignProperties.swift
//  AskQueue
//
//  Created by Rafael Galdino on 18/01/20.
//  Copyright © 2020 Rafael Galdino. All rights reserved.
//

import Foundation
import UIKit

// MARK: COLOR PALLETE
public enum AskQueueColors {
    static var white: UIColor {
        return UIColor(red: 240/255,
                       green: 240/255,
                       blue: 240/255,
                       alpha: 1)
    }
    static var lightGreen: UIColor {
        return UIColor(red: 44/255,
                       green: 185/255,
                       blue: 147/255,
                       alpha: 1)
    }
    static var darkGreen: UIColor {
        return UIColor(red: 28/255,
                       green: 130/255,
                       blue: 103/255,
                       alpha: 1)
    }
    static var black: UIColor {
        return UIColor(red: 43/255,
                       green: 43/255,
                       blue: 43/255,
                       alpha: 1)
    }
    static var red: UIColor {
        return UIColor(red: 208/255,
                       green: 43/255,
                       blue: 77/255,
                       alpha: 1)
    }
}

// MARK: FONTS
extension UIFont {
    class func roundedFont(ofSize style: UIFont.TextStyle, weight: UIFont.Weight) -> UIFont {
        // Will be SF Compact or standard SF in case of failure.
        let fontSize = UIFont.preferredFont(forTextStyle: style).pointSize
        if let descriptor = UIFont.systemFont(ofSize: fontSize, weight: weight).fontDescriptor.withDesign(.rounded) {
            return UIFont(descriptor: descriptor, size: fontSize)
        } else {
            return UIFont.preferredFont(forTextStyle: style)
        }
    }

    class var default64RegularItalic: UIFont {
        var font = UIFont.systemFont(ofSize: 64.0, weight: .regular)
        if let desc = font.fontDescriptor.withSymbolicTraits(.traitItalic) {
            font = UIFont(descriptor: desc, size: 64.0)
        } else {
            font = UIFont.preferredFont(forTextStyle: .largeTitle)
        }
        return font
    }
    
    class var rounded17Regular: UIFont {
        return UIFont.roundedFont(ofSize: .headline, weight: .regular)
    }

    class var rounded17Bold: UIFont {
        return UIFont.roundedFont(ofSize: .headline, weight: .bold)
    }

    class var rounded20Medium: UIFont {
        return UIFont.roundedFont(ofSize: .title3, weight: .medium)
    }

    class var rounded22Regular: UIFont {
        return UIFont.roundedFont(ofSize: .title2, weight: .regular)
    }

    class var rounded22Bold: UIFont {
        return UIFont.roundedFont(ofSize: .title2, weight: .bold)
    }

    class var rounded34Regular: UIFont {
        return UIFont.roundedFont(ofSize: .largeTitle, weight: .regular)
    }

    class var rounded34Bold: UIFont {
        return UIFont.roundedFont(ofSize: .largeTitle, weight: .bold)
    }

}
