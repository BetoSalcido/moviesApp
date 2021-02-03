//
//  GetDevice.swift
//  Kelder
//
//  Created by Beto Salcido on 01/02/21.
//  Copyright © 2020 BetoSalcido. All rights reserved.
//

import Foundation
import UIKit

enum GetDevice {
    
    static func model() -> Models {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("IPHONE 5,5S,5C")
                return Models.iPhone5
            case 1334:
                print("IPHONE 6,7,8 IPHONE 6S,7S,8S ")
                return Models.iPhone6_7_8
            case 1920, 2208:
                print("IPHONE 6PLUS, 6SPLUS, 7PLUS, 8PLUS")
                return Models.iPhone6_7_8_plus
            case 2436:
                print("IPHONE X, IPHONE XS, IPHONE 11 PRO")
                return Models.iPhoneX_XS_11Pro
            case 2688:
                print("IPHONE XS MAX, IPHONE 11 PRO MAX")
                return Models.iPhoneX_11_Max
            case 1792:
                print("IPHONE XR, IPHONE 11")
                return Models.iPhoneXR_11
            default:
                return Models.iPhoneX_XS_11Pro
            }
        } else if UIDevice().userInterfaceIdiom == .pad {
            return Models.iPad
        }
        return Models.unowned
    }
    
    static func positionY() -> Int {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                return 60
            case 1334:
                return 60
            case 1920, 2208:
                return 60
            case 2436:
                return 88
            case 2688:
                return 88
            case 1792:
                return 88
            case 2778, 2532, 2340:
                return 90
            default:
                return 88
            }
        } else if UIDevice().userInterfaceIdiom == .pad {
            return 60
        }
        return 60
    }
}

enum Models: Int {
    case iPhone5 = 0
    case iPhone6_7_8 = 1
    case iPhone6_7_8_plus = 2
    case iPhoneX_XS_11Pro = 3
    case iPhoneX_11_Max = 4
    case iPhoneXR_11 = 5
    case iPad = 6
    case unowned = 7
}
