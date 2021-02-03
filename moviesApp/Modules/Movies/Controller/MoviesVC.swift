//
//  MoviesVC.swift
//  moviesApp
//
//  Created by Beto Salcido on 01/02/21.
//

import UIKit
import Reachability

class MoviesVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let reachability = try! Reachability()
    private let moviesDataModel = MoviesDataModel()
    private var orderBy: String = OrderOptions.popoular
    private var movies: Movies?
    private var page: Int = 1
    
    var lastContentOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = OrderName.popoular
        configNavBar()
        configModel()
        configCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showLoadingView(transparent: true)
        moviesDataModel.getMovies(orderBy: orderBy)
    }
    
    private func configCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func configModel() {
        moviesDataModel.delegate = self
    }
    
    private func configNavBar() {
        let iconSearchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handlerOrderButton))
        self.navigationItem.rightBarButtonItems = [iconSearchButton]
    }
        
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
         if UIDevice.current.orientation.isLandscape,
             let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
             let width = view.frame.height
             layout.itemSize = CGSize(width: width, height: 280)
             layout.invalidateLayout()
         } else if UIDevice.current.orientation.isPortrait,
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = view.frame.width
            layout.itemSize = CGSize(width: width, height: 280)
            layout.invalidateLayout()
         }
     }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset < scrollView.contentOffset.y) {
            self.navigationController!.navigationBar.isTranslucent = true
            self.navigationController!.navigationBar.isOpaque = true
            
        } else if (self.lastContentOffset > scrollView.contentOffset.y) {
            self.navigationController!.navigationBar.isTranslucent = false
            self.navigationController!.navigationBar.isOpaque = false
        }
    }
    
}

// MARK: - Segues
extension MoviesVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if reachability.connection != .unavailable {
            if segue.identifier == "movieDetail" {
                let vc = segue.destination as! MovieDetailVC
                vc.movieId = UInt(sender as! Int)
            }
        } else {
            AlertManager.showConnectionError(on: self, handlerAction: nil)
        }

    }
}

// MARK: - Buttons and actions methos
extension MoviesVC {
    @objc func handlerOrderButton(sender: UIBarButtonItem) {
        if orderBy == OrderOptions.popoular {
            self.title = OrderName.topRated
            orderBy = OrderOptions.topRated
        } else {
            self.title = OrderName.popoular
            orderBy = OrderOptions.popoular
        }
        showLoadingView(transparent: true)
        moviesDataModel.getMovies(orderBy: orderBy)
    }
}

// MARK: - UICollectionViewDataSource
extension MoviesVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Movies", for: indexPath) as! MoviesCC
        cell.configCell(data:  movies?.results?[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MoviesVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "movieDetail", sender: movies?.results?[indexPath.row].id ?? 0)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MoviesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .phone {
            let lay = collectionViewLayout as! UICollectionViewFlowLayout
            let divider = !UIDevice.current.orientation.isPortrait && !UIDevice.current.orientation.isLandscape ? 2 : UIDevice.current.orientation.isPortrait ? 2 : 3
            let widthPerItem = collectionView.frame.width / CGFloat(divider) - lay.minimumInteritemSpacing
            return CGSize(width: widthPerItem, height: 280)
        }
        
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 3 - lay.minimumInteritemSpacing
        return CGSize(width: widthPerItem, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MoviesVC: MoviesDataModelDelegate {
    func didReceiveData(response: Movies) {
        removeLoadingView()
        movies = response
        collectionView.isHidden = false
        collectionView.reloadData()
    }
    
    func didFail(error: CodeError) {
        removeLoadingView()
        switch error {
        case .connectionError:
            AlertManager.showConnectionError(on: self, handlerAction: nil)
        case .custom:
            AlertManager.showSimpleAlertView(on: self, with: "Aviso", message: error.localizedDescription, handlerAction: nil)
        default:
            AlertManager.showOverallMessage(on: self, handlerAction: nil)
        }
    }
}
