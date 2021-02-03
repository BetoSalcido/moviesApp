//
//  UIImageViewExtension.swift
//  moviesApp
//
//  Created by Beto Salcido on 02/02/21.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    @objc func online_setThumbnailImageWithPath(_ path: String) {
        if let url =  URL(string: path) {
            let resource = ImageResource(downloadURL: url, cacheKey: path)
            kf.indicatorType = .activity
            kf.setImage(with: resource)
        } else {
            image = nil
        }
    }
    
}
