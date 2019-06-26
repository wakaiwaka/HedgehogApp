//
//  GoogleMapScreenViewController.swift
//  HedgehogApp
//
//  Created by 若原昌史 on 2019/01/27.
//  Copyright © 2019 若原昌史. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

class GoogleMapScreenViewController: UIViewController {
    
    private var locationManager:CLLocationManager!
    private var currentLocation:CLLocation?
    private var camera:GMSCameraPosition!
    private var mapView:GMSMapView!
    private var placeCient:GMSPlacesClient!
    private var zoomLevel:Float = 15.0
    private var searchBar:UISearchBar!
    
    private var defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)
    
    private var resultArray:[Dictionary<String,AnyObject>] = Array()
    
    private var nowLocation:CLLocation!
    
    //だいたいの場所のリストとユーザーが選択しそうな場所の格納場所
    private var likelyPlaces: [GMSPlace] = []
    private var selectedPlace:GMSPlace?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        self.navigationItem.title = "近くのお店・病院"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.lightSkyBlue]
        
        self.placeCient = GMSPlacesClient.shared()
        
        //地図を表示させる
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: zoomLevel)
        self.nowLocation = self.defaultLocation
        
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        mapView.isMyLocationEnabled = true
        
        view.addSubview(mapView)
        
        
        mapView.isHidden = true
        
        self.listLikelyPlaces()
        
        //検索バーを追加する
        self.searchBar = UISearchBar()
        self.searchBar.delegate = self
        
        searchBar.frame.size = CGSize(width: self.view.frame.width, height: 40)
        if #available(iOS 11.0, *) {
            searchBar.frame.origin = CGPoint(x: 0, y: UINavigationController().navigationBar.frame.size.height + (UIApplication.shared.keyWindow?.safeAreaInsets.top)!)
        } else {
            searchBar.frame.origin = CGPoint(x: 0, y: UINavigationController().navigationBar.frame.size.height)
        }
        
        view.addSubview(searchBar)
    }
    
    
}

extension GoogleMapScreenViewController:CLLocationManagerDelegate,UISearchBarDelegate,GMSPlacePickerViewControllerDelegate{
    
    //ユーザーのいる場所まで位置情報を移動させる
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation! = locations.last
        self.defaultLocation = location
        
        print("location\(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude , longitude: location.coordinate.longitude, zoom: zoomLevel)
        
        if mapView.isHidden{
            mapView.isHidden = false
            mapView.camera = camera
        }else{
            mapView.animate(to: camera)
        }
        
        self.listLikelyPlaces()
        
        self.searchPlaceFromGoogle()
    }
    
    //ユーザーの位置情報の許可の状態を表示
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted")
        case .denied:
            print("User denied access to location")
        case .notDetermined:
            print("Location status Not notDetermined")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location statusn is OK")
        }
    }
    
    //エラーが発生した場合の処理
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error:\(error)")
    }
    
    
    private func listLikelyPlaces(){
        likelyPlaces.removeAll()
        
        placeCient.currentPlace { (placeLikelihoods, error) in
            if let error = error{
                print("error:\(error.localizedDescription)")
            }
            
            if let likelyList = placeLikelihoods{
                for likelihood in likelyList.likelihoods{
                    let place = likelihood.place
                    self.likelyPlaces.append(place)
                }
            }
            
        }
    }
    
    //SearchBarに入力した文字の検索の処理
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //google maps for ios の Place Picker を起動する
        
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        
        placePicker.delegate = self
        
        present(placePicker,animated: true,completion: nil)
        
    }
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchPlaceFromGoogle()
    }
    
    //Google Places APIを利用して近くのエキゾチックアニマルの病院を表示する
    private func searchPlaceFromGoogle(){
        //マップのマーカーをクリアにする
        self.mapView.clear()
        
        var position:CLLocationCoordinate2D!
        let address:String = ""
        var iconImage:UIImage!
        
        var strGoogleAPI:String = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=エキゾチックアニマル&language=ja&location=\(self.defaultLocation.coordinate.latitude),\(self.defaultLocation.coordinate.longitude)&radius=5000&key=AIzaSyApfoXT_y5C8l64fZptkc_a3lbev49x2tE"
        
        strGoogleAPI = strGoogleAPI.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let urlGoogleAPI = URL(string: strGoogleAPI)
        
        var urlRequest = URLRequest(url: urlGoogleAPI!)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error{
                print("error:\(error)が起きました")
            }
            
            if let responseData = data{
                let jsonDic = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                print("json=\(jsonDic)")
                
                if let dict = jsonDic as? Dictionary<String,AnyObject>{
                    
                    
                    if let results = dict["results"] as? [Dictionary<String,AnyObject>]{
                        print("result:\(results)")
                        
                        DispatchQueue.main.sync {
                            for result in results{
                                if let geometry = result["geometry"] as? Dictionary<String,AnyObject>{
                                    let location = geometry["location"] as? Dictionary<String,AnyObject>
                                    if let latitude = location!["lat"] as? Double,let longtitude = location!["lng"] as? Double{
                                        
                                        position = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
                                        
                                        print("----------------------latitude\(latitude)----------longtitude\(longtitude)-----------------------")
                                    }
                                }
                                
                                
                                //アイコンの設定
                                if let types = result["types"] as? [String]{
                                    for type in types{
                                        if type == "veterinary_care"{
                                            iconImage = UIImage(named: "病院")
                                        }else if type == "pet_store"{
                                            iconImage = UIImage(named: "ショップ")
                                        }
                                    }
                                    
                                    
                                    //地名を取得する
                                    if let placeName = result["name"] as? String{
                                        
                                        
                                        print("-----------------------------\(placeName)--------------------")
                                        
                                        let marker = GMSMarker(position: position)
                                        marker.title = """
                                        \(placeName)
                                        \(address)
                                        """
                                        
                                        //地図にマーカーを描写する
                                        marker.map = self.mapView
                                        marker.icon = iconImage
                                        self.locationManager = CLLocationManager()
                                        self.locationManager.startUpdatingLocation()
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        task.resume()
    }
}
