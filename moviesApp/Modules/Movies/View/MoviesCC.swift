//
//  MoviesCC.swift
//  moviesApp
//
//  Created by Beto Salcido on 01/02/21.
//

import UIKit
import Kingfisher

class MoviesCC: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(data: Result?) {
        if let settings = GetAppSettings.getValusFromAppConfig() {
            let baseUrl = settings.imageUrl
            if let backdropPath = data?.backdropPath, backdropPath.count > 0, let url = URL(string: "\(baseUrl)\(backdropPath)") {
                let resource = ImageResource(downloadURL: url, cacheKey: backdropPath)
                movieImage.kf.indicatorType = .activity
                movieImage.kf.setImage(with: resource)
            }
        }
    }
}
