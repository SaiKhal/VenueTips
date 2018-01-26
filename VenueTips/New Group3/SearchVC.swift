//
//  SearchVC.swift
//  VenueTips
//
//  Created by Masai Young on 1/16/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class SearchVC: UIViewController {
    
    let searchView = SearchView()
    var photoResults: VenuePhotoResults?
    
    var currentSelectedVenue: VenueSearchResults!
    
    var searchResults: VenueSearchResults? {
        didSet{
            //TODO: - create annotations
            if let venues = searchResults?.response.venues{
                for venue in venues {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2DMake(venue.location.lat, venue.location.lng)
                    annotation.title = venue.name
                    annotations.append(annotation)
                }
            }
            //TODO: - add annotations to the mapView
            DispatchQueue.main.async {
                self.searchView.mapView.addAnnotations(self.annotations)
                self.searchView.mapView.showAnnotations(self.annotations, animated: true)
                print("annotations added")
            }
        }
    }
    
    private var annotations = [MKAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContentView()
        setNavBar()
        //ask user for permission
        let _ = LocationHelper.manager.checkForLocationServices()
        print("user asked permission")
        
        //mapView delegates
        searchView.mapView.delegate = self
        
        //                let endpoint = VenueSearchAPIClient.manager.searchEndpointWithNear(near: "Chicago,IL", query: "tacos")
        //                VenueSearchAPIClient.manager.getSearchResults(from: endpoint,
        //                                                              completionHandler: { self.searchResults = $0; self.searchView.collectionView.reloadData()},
        //                                                              errorHandler: {print($0)})
    }
    
    private func setContentView() {
        view.addSubview(searchView)
        searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        searchView.venueSearchBar.delegate = self
        searchView.locationSearchBar.delegate = self
        searchView.locationSearchBar.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = true
        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
    }
    
    private func setNavBar() {
        //        Add search bar
        navigationItem.titleView = searchView.venueSearchBar
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        
        //mainCustomSB.delegate = self
        
        //        Add right bar button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "??", style: .plain, target: self, action: #selector(showResultsVC))
    }
    
    @objc func showResultsVC() {
        let newVC = ResultsVC()
        navigationController?.pushViewController(newVC, animated: true)
    }
}



//MARK: Map View: Creating callouts
extension SearchVC: MKMapViewDelegate{
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
                let venue = searchResults?.response.venues[annotationIndex]
                
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
    //    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    //        let detailVC = DetailViewController(place: currentSelectedPlace)
    //        navigationController?.pushViewController(detailVC, animated: true)
    //    }
}



//MARK: Search bar
extension SearchVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        //TODO: - validate venue search
        guard let text = searchView.venueSearchBar.text else {print("venue search is nil");return}
        guard !text.isEmpty else {print("venue text is empty");return}
        
        //TODO: - check for spaces e.g " Burrito Bowl
        guard let encodedVenueSearch = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {print("no spaces allowed");return}
        
        //TODO: - check for empty address field, i.e placeholder text
        var address: String!
        if let enteredLocation = searchView.locationSearchBar.text {
            if enteredLocation.isEmpty {
                address = nil
            } else {
                address = enteredLocation.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            }
        }
        
        let completion: (VenueSearchResults) -> Void = {(venueResults) in
            self.searchResults = venueResults
            //removing current venues and pins
            //resetting venues based on the newly entered location
            DispatchQueue.main.async {
                self.searchResults?.response.venues.removeAll()
                self.searchView.mapView.removeAnnotations(self.annotations)
                self.annotations.removeAll()
                self.searchResults = venueResults
            }
        }
        
        //TODO: -  calls out Foursquare API with search query
        VenueSearchAPIClientWithAlamo.manager.getSearchResults(from: encodedVenueSearch,
                                                               locationName: address,
                                                               userLocation: nil,
                                                               completionHandler: completion,
                                                               errorHandler: {print($0)})
        searchView.collectionView.reloadData()
        searchBar.resignFirstResponder()
    }
}

//MARK: Collection View Flow Layout
extension SearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 140)
    }
}

//MARK: Collection View Data Source
extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults?.response.venues.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VenueCell", for: indexPath) as! VenueCell
        let index = indexPath.item
        
        guard let venue = searchResults?.response.venues[index] else { return cell }
        
        cell.backgroundColor = .orange
        if Int(venue.name.count) > 15 {
            cell.backgroundColor = .blue
        }
        
        
        let completion: (VenuePhotoResults) -> Void = { (results) in
            guard let photo = results.response.photos.items.first else { return }
            let endpoint = "\(photo.purplePrefix)original\(photo.suffix)"
            ImageDownloader.manager.getImage(from: endpoint,
                                             completionHandler: {cell.venueImageView.image = $0; cell.setNeedsLayout()},
                                             errorHandler: {print($0)})
            
        }
        
        let photoEndpoint = VenuePhotoAPIClient.manager.photoEndpoint(venue: venue)
        VenuePhotoAPIClient.manager.getVenuePhotos(from: photoEndpoint,
                                                   completionHandler: completion,
                                                   errorHandler: {print($0)})
        return cell
    }
}
