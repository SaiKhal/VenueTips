//
//  SearchVC.swift
//  VenueTips
//
//  Created by Masai Young on 1/16/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import MapKit
import Kingfisher

struct VenueWithImages {
    let venue: Venue
    let imageURL: String
}

class SearchVC: UIViewController {
    
    var venuesWithImages = [VenueWithImages]()
    let searchView = SearchView()
    var currentSelectedVenue: VenueSearchResults!
    private var annotations = [MKAnnotation]()
    
    var searchResults: VenueSearchResults?
    
    
    func createAnnotations() {
        //TODO: - create annotations
        if let venues = searchResults?.response.venues{
            for venue in venues {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2DMake(venue.location.lat, venue.location.lng)
                annotation.title = venue.name
                annotations.append(annotation)
            }
            
            //TODO: - add annotations to the mapView
            DispatchQueue.main.async {
                self.searchView.mapView.addAnnotations(self.annotations)
                self.searchView.mapView.showAnnotations(self.annotations, animated: true)
                print("annotations added")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setContentView()
        setNavBar()
        askForUserPermission()
    }
    
    private func askForUserPermission() {
        let _ = LocationHelper.manager.checkForLocationServices()
    }
    
    lazy var completion: (VenueSearchResults) -> Void = { (result) in
        switch result.meta.code {
        // SUCCESS
        case 200:
//            self.searchResults?.response.venues?.removeAll()
            self.searchView.mapView.removeAnnotations(self.annotations)
            self.annotations.removeAll()
            self.searchResults = result
            self.createAnnotations()
            self.searchView.collectionView.reloadData()
            print("App should be running successfully.")
        //FAILURE - Handles errors returned from Foursquare API
        case 400:
            self.searchView.mapView.dodo.error("\(result.meta.errorDetail ?? "No given error.")")
            self.searchView.mapView.dodo.style.bar.hideAfterDelaySeconds = 3
        case 500:
            self.searchView.mapView.dodo.error("\(result.meta.errorDetail ?? "No given error.")")
            self.searchView.mapView.dodo.style.bar.hideAfterDelaySeconds = 3
        default:
            self.searchView.mapView.dodo.error("Random Error 😒")
            self.searchView.mapView.dodo.style.bar.hideAfterDelaySeconds = 3
        }
    }
    
    lazy var handle: (Error) -> Void = { [unowned self] (error) in
        //Handles errors NOT from Foursquare API. Mainly IOS errors.
        if let urlError = error as? URLError, urlError.code == URLError.Code.notConnectedToInternet{
            self.searchView.mapView.dodo.error("No internet connection!")
            self.searchView.mapView.dodo.style.bar.hideAfterDelaySeconds = 3
        }
    }
    
    private func setContentView() {
        view.addSubview(searchView)
        searchView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        searchView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true
        searchView.venueSearchBar.delegate = self
        searchView.locationSearchBar.delegate = self
        searchView.locationSearchBar.backgroundColor = .white
        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
        searchView.mapView.delegate = self
    }
    
    private func setNavBar() {
        //        Add search bar
        navigationItem.titleView = searchView.venueSearchBar
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        
        //        Add right bar button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "listIcon"), style: .plain, target: self, action: #selector(showResultsVC))
    }
    
    @objc func showResultsVC() {
        let newVC = ResultsVC(results: searchResults)
        navigationController?.pushViewController(newVC, animated: true)
    }
    
}

//MARK: Map View: Map View Delegate
extension SearchVC: MKMapViewDelegate {
    //TODO: - create callouts
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //TODO: - show user blue defualt dot
        if annotation is MKUserLocation {
            return nil
        }
        
        //TODO: - set-up annotation view for map
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "VenueAnnotationView") as? MKMarkerAnnotationView
        if annotationView == nil { // setup annotation view
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "VenueAnnotationView")
            annotationView?.canShowCallout = true
            
            let index = annotations.index{$0 === annotation}
            if let annotationIndex = index {
                let venue = searchResults?.response.venues?[annotationIndex]
                
                annotationView?.glyphText = "\(venue?.stats.checkinsCount ?? 0)"
                //annotationView?.glyphText = venue?.categories[0].icon.purplePrefix
            }
            
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    //        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    //            //TODO: - find place (in array) selected when user clicks on pin
    //            let index = annotations.index{$0 === view.annotation}
    //            guard let annotationIndex = index else { print("index is nil"); return }
    //            let venue = searchResults?.response.venues[annotationIndex]
    //
    //            currentSelectedVenue = venue
    //        }
    
    //Mark: - sending to which VC
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//          TODO
            
//            let detailVC = VenueDetailVC(venue: <#T##Venue?#>, photo: <#T##UIImage?#>)
//            navigationController?.pushViewController(detailVC, animated: true)
        }
    
    
}

extension SearchVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var venue: String?
        var locationName: String?
        var userLocation: CLLocationCoordinate2D?
        
        //        if CLLocationManager.locationServicesEnabled() {
        //
        //        } else {
        //
        //        }
        
        if (searchView.venueSearchBar.text?.isEmpty)! {
            self.searchView.mapView.dodo.style.bar.hideAfterDelaySeconds = 3
            self.searchView.mapView.dodo.info("Please enter a venue.")
            venue = nil
        } else {
            venue = searchView.venueSearchBar.text
        }
        
        if (searchView.locationSearchBar.text?.isEmpty)! {
            locationName = "Queens, NY"
        } else {
            locationName = searchView.locationSearchBar.text
        }
        
        let venueEndpoint = VenueEndpoint(query: venue, locationName: locationName, userLocation: nil, currentDate: nil)
        VenueSearchAPIClientWithAlamo.manager.getSearchResults(from: venueEndpoint, completionHandler: completion, errorHandler: handle)
        
        
    }
}

extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as! VenueCell
        let venue = searchResults?.response.venues?[indexPath.row]
        let image = selectedCell.venueImageView.image
        
        let detailVC = VenueDetailVC(venue: venue, photo: image)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 140)
    }
}

extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults?.response.venues?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VenueCell", for: indexPath) as! VenueCell
        let index = indexPath.item
        guard let venue = searchResults?.response.venues?[index] else { return cell }
        let completion: (VenuePhotoResults) -> Void = { [unowned self] (results) in
            guard let photo = results.response.photos.items.first else { return }
            let endpoint = "\(photo.purplePrefix)original\(photo.suffix)"
            self.searchResults?.response.venues?[index].photoURL = endpoint
            if let image = ImageCache.manager.cachedImage(url: URL(string: (self.searchResults?.response.venues?[index].photoURL!)!)!) {
                cell.venueImageView.image = image
            } else {
                ImageCache.manager.processImageInBackground(imageURL: URL(string: (self.searchResults?.response.venues?[index].photoURL!)!)!,
                                                            completion: {(error, image) in
                                                                cell.venueImageView.image = image; cell.setNeedsLayout()})
            }
        }
        
        let photoEndpoint = VenuePhotoAPIClient.manager.photoEndpoint(venue: venue)
        VenuePhotoAPIClient.manager.getVenuePhotos(from: photoEndpoint,
                                                   completionHandler: completion,
                                                   errorHandler: handle)
        return cell
    }
}
