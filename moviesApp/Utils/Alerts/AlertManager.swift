//
//  AlertManager.swift
//  calzzapato
//
//  Created by Beto Salcido on 01/02/21.
//  Copyright © 2020 BetoSalcido. All rights reserved.
//

import Foundation
import UIKit

enum AlertManager {
    
    static func showSimpleAlertView(on vc: UIViewController, with title: String, message:String,  handlerAction: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: handlerAction))
        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
    }
    
    static func showOverallMessage(on vc: UIViewController, handlerAction: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: "Lo sentimos", message: "Ocurrió un problema inesperado. Por favor, intenta de nuevo.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: handlerAction))
        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
    }
    
    static func showConnectionError(on vc: UIViewController, handlerAction: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: "Lo sentimos", message: "Parece que no hay conexión a Internet. Por favor, vuelva a intentarlo más tarde.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: handlerAction))
        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
    }
}
