//
//  MainViewController.swift
//  BioInform
//
//  Created by Thor on 3/22/17.
//  Copyright © 2017 Thor. All rights reserved.
//

import CoreLocation
import UIKit
import Contacts
import MapKit
// Location View Controller
class ConferenceAnnotation: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    let span: MKCoordinateSpan
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D, span: MKCoordinateSpan) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        self.span = span
        super.init()
    }
    var subtitle: String? {
        return locationName
    }
    
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(CNPostalAddressStreetKey) : self.subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    
    
}


class MainViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, CLLocationManagerDelegate, MKMapViewDelegate {
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionViewButtons = [UIImage]()
    var collectionViewButtonLabels = [String]()
    
    // MARK: JSON data
    
    func jsonDataToTable(_ data: Data) {
        do {
            if let jsonDict: NSDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                if let presenters : NSArray = jsonDict["Sessions"] as? NSArray {
                    // 34
                    // 27 posters
                    for i in 0..<33 {
                        if let aPresenter : NSDictionary = presenters[i] as? NSDictionary {
                            // var a = abstractObject()
                            var jsonObj = AgendaDetailsModel()
                            jsonObj.name = aPresenter["name"] as! String
                            jsonObj.date = aPresenter["date"] as! String
                            jsonObj.time = aPresenter["time"] as! String
                            jsonObj.title = aPresenter["title"] as! String
                            jsonObj.session = aPresenter["session"] as! Int
                            jsonObj.guestOrVIPSpeaker = aPresenter["guestOrVIPSpeaker"] as! Bool
                            jsonObj.sponsor = aPresenter["sponsor"] as! Bool
                            jsonObj.speakerBio = aPresenter["speakerBio"] as! String
                            jsonObj.position = aPresenter["position"] as! String
                            jsonObj.institution = aPresenter["institution"] as! String
                            jsonObj.abstractTalk = aPresenter["abstractTalk"] as! Bool
                            jsonObj.posterTalk = aPresenter["posterTalk"] as! Bool
                            jsonObj.submissionCoAuthors = aPresenter["submissionCoAuthors"] as! String
                            jsonObj.submissionCoAuthorsInst = aPresenter["submissionCoAuthorsInst"] as! String
                            jsonObj.abstract = aPresenter["abstract"] as! String
                            jsonObj.skip = aPresenter["skip"] as! Bool
                            if !jsonObj.skip {
                                p.addObj(presenter: jsonObj)
                            }
                        }
                    }
                    
                }
            }
            
        } catch {print(error)}
        
    }
    
    func retrieveJSONfromFile() {
        let jsonFilePath = Bundle.main.path(forResource: "agendaJSON_2017", ofType: "json")
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath!), options: Data.ReadingOptions.mappedIfSafe)
            
            if jsonData.count > 0 {
                jsonDataToTable(jsonData)
            } else { print("Error with Reading JSON")}
            
        } catch { print(error) }
        
    }
    


    
    
    // MARK: MAPVIEW Setup
    lazy var locationManager: CLLocationManager = {
        let m = CLLocationManager()
        m.delegate = self
        m.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        return m
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Updated Location!")
    }
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Failed!")
        print((error))
    }
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if case .authorizedWhenInUse = status{
            manager.requestLocation()
            print("Got Location")
        }
        else {
            //manager.
            print("No location")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveJSONfromFile()
        // Option 1: Create UITextView in IB, modify in IB
        // Option 2: Uncomment section below.  Theoretically, creating in IB, 
        // adding a property, then modifying below should also work, however these steps did not work
        /*
        let titleTextString = "5th Annual Louisiana Conference on Computational Biology and Bioinformatics"
        let alignmentAttribute = NSMutableParagraphStyle()
        alignmentAttribute.alignment = .center
        let attributedTitleText = NSAttributedString(string: titleTextString, attributes: [NSFontAttributeName : (UIFont(name: "Palatino", size: 26)!), NSParagraphStyleAttributeName : alignmentAttribute])
        titleText.attributedText = attributedTitleText
        */
        collectionViewButtons = [(UIImage(named: "speakersButton")!), (UIImage(named: "agendaButton")!), (UIImage(named: "abstractsButton")!), (UIImage(named: "mapButton")!), (UIImage(named: "websiteButton")!), (UIImage(named: "lbrnButton")!)]
        collectionViewButtonLabels = ["Speakers", "Agenda", "Abstracts", "Map", "Website", " LBRN "]
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layoutMargins = layout.sectionInset

        
        // selects only VIP or Guest Speakers for SpeakersDetailController
        if p.guestSpeakers.count == 0 {
            p.addGuestSpeakers()
        }

        
    }
    func resizeImage(_ image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    // MARK: CollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewButtons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cCell", for: indexPath) as! DetailCollectionViewCell
        cell.bgImage4Cell.image = collectionViewButtons[indexPath.row]
        cell.bgImage4Cell.contentMode = .scaleAspectFit
        let w = cell.bounds.size.width
        let aTitle: UILabel!
        
        if indexPath.row == 3 {
            let nameFrame = CGRect(x: 30, y: 60.0, width: w, height: 20.0)
            aTitle = UILabel(frame: nameFrame)
            // Text Label requires different x position in frame for shorter Label words
        }
        else {
            let nameFrame = CGRect(x: 20, y: 60.0, width: w, height: 20.0)
            aTitle = UILabel(frame: nameFrame)
        }
        
        
        let labelString = collectionViewButtonLabels[indexPath.row]
        let labelAttributedString = NSMutableAttributedString(string: labelString, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 10.0)!])

        aTitle.attributedText = labelAttributedString
        
        cell.contentView.addSubview(aTitle)
        return cell
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAgendaDetails" {
            _ = segue.destination as! MainDetailsViewController
            let cCell = sender as! DetailCollectionViewCell
            _ = self.collectionView!.indexPath(for: cCell)
        }
        else {
            
        }

    }
    */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // order is:
        // Speakers, agenda, abstracts, map, website
        

        
        
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "showSpeakers", sender: self)
            /*
            let speakerURL = "https://lbrn.lsu.edu/events/bioinformatics-conference/"
            if #available(iOS 10.0, *) {
                let alert = UIAlertController(title: "Website", message: "This will open the conference webpage in Safari", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction((UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{(paramAction:UIAlertAction) -> Void in
                        UIApplication.shared.open(URL(string: speakerURL)!, options: [:], completionHandler: nil)})))
                alert.addAction((UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)))
                present(alert, animated: true, completion: nil)

            } else {
                // Fallback on earlier versions
                let alert = UIAlertController(title: "Website", message: "This will open the conference webpage in Safari", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction((UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{(paramAction:UIAlertAction) -> Void in
                    UIApplication.shared.open(URL(string: speakerURL)!, options: [:], completionHandler: nil)})))
                alert.addAction((UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)))
                present(alert, animated: true, completion: nil)
                UIApplication.shared.open(URL(string: speakerURL)!, options: [:], completionHandler: nil)
            }
            */
 
        }
        else if indexPath.row == 1 {
            // let vc = self.storyboard?.instantiateViewController(withIdentifier: "AgendaStoryboard")
            // present(vc!, animated: true, completion: nil)
            
            self.performSegue(withIdentifier: "showAgendaDetails", sender: self)
            
            // let vc = self.storyboard?.instantiateViewController(withIdentifier: "AgendaStoryboard") as! MainDetailsViewController
           // let navController = UINavigationController(rootViewController: vc)
            //
            // self.performSegue(withIdentifier: "showAgendaDetails", sender: collectionView)
            //
            
        }
        else if indexPath.row == 2 {
            

            self.performSegue(withIdentifier: "showAbstractSegue", sender: self)


        } else if indexPath.row == 3 {
            if CLLocationManager.locationServicesEnabled() {
                switch CLLocationManager.authorizationStatus(){
                case .authorizedWhenInUse:
                    let src = MKMapItem.forCurrentLocation()
                    let regionSpan: MKCoordinateSpan = MKCoordinateSpanMake(3.0, 3.0)
                    print("Open Map")
                    let locationForConference = ConferenceAnnotation(title: "4th Annual LA Bioinformatics Conference", locationName: "Xavier University, Convocation Center Annex Building", coordinate: CLLocationCoordinate2D(latitude: 29.964038, longitude: -90.1087681), span: regionSpan)
                    // set zoom location to a CLLocationCoordinate2D, and set destination as a MKapItem
                    let zoomLoc = CLLocationCoordinate2D(latitude: 29.964038, longitude: -90.1087681)
                    let dest = locationForConference.mapItem()
                    // set launchOptions as a Dict of options with type [String : AnyObject] if necessary
                    let opt = [MKLaunchOptionsMapCenterKey : NSValue(mkCoordinate: zoomLoc),MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan),
                               MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving] as [String : Any]
                    MKMapItem.openMaps(with: [src, dest], launchOptions: opt)
                case .denied:
                    print("LocationServices Not Allowed")
                    let mapNotify = UIAlertController(title: "Location Services Turned Off", message: "Turn On Location Services in Settings > Privacy to Allow App to determine your current location", preferredStyle: UIAlertControllerStyle.alert)
                    
                    let mapAction = UIAlertAction(title: "Settings", style: UIAlertActionStyle.default, handler: { (paramAction:UIAlertAction) -> Void in
                        DispatchQueue.main.async(execute: ({
                            _ = NSURL(string: UIApplicationOpenSettingsURLString)
                        }))})
                    mapNotify.addAction(mapAction)
                    mapNotify.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                    self.present(mapNotify, animated: true, completion: nil)
                    
                case .restricted:
                    print("Restricted")
                    let mapRestrictedNotify = UIAlertController(title: "Location Services Could Not be determined", message: "Location Services could not be determined at this time", preferredStyle: UIAlertControllerStyle.alert)
                    mapRestrictedNotify.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(mapRestrictedNotify, animated: true, completion: nil)
                case .notDetermined:
                    locationManager.requestWhenInUseAuthorization()
                default:
                    print("Unknown")
                }
            } else {
                print("LocationServices Not enabled!")
                
            }
        } else if indexPath.row == 4 {
            
            let speakerURL = "https://lbrn.lsu.edu/events/bioinformatics-conference/"
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: speakerURL)!, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.open(URL(string: speakerURL)!, options: [:], completionHandler: nil)
            }
        } else if indexPath.row == 5 {
            self.performSegue(withIdentifier: "segueToLBRN", sender: self)
        }else {
            print("unexpected input")
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    
}
