//
//  MapViewController.swift
//  Amrita Events
//
//  Created by kishore saravanan on 11/01/20.
//  Copyright © 2020 kishore saravanan. All rights reserved.
//

// error 1 : state with no cases show up as 1 case
// error 2 : state with no case should not be allowed to show district view
// error 3 : constraints for uiScrollView
// error 4 : loading symbol when state marker is tapped
// error 5 : make info page
// error 6 : change the images in initial view controller
// error 7 : clean all the excess feces
import UIKit
import MapKit
import CoreLocation

var initmarker = 0
var countmark = 0
var arraymark: [MKAnnotation] = []
var Statedisplay: [MKAnnotation] = []
var removedSate:  [MKAnnotation] = []
var statelist: [String] = []
//var districtdict = [String:Any]()
//var distlist: [[String]] = []
var distlist = Array(repeating: Array(repeating: "-", count: 70), count: 70)
var latarr: [Double] = []
var lngarr: [Double] = []
var case_dist_count: [Int] = []
var recovered_dist_count: [Int] = []
var recovered_state_count: [Int] = []
var case_state_count: [Int] = []
var distcount = Array(repeating: Array(repeating: 0, count: 70), count: 70) // no of cases in each district for each state
var distRecovered = Array(repeating: Array(repeating: 0, count: 70), count: 70) // no of cases in each district for each state
var statelatarr: [Double] = []
var statelngarr: [Double] = []



class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate{
    
    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    
    
    
    
    //var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var countShow: UILabel!
    
    @IBOutlet weak var Map: MKMapView!
    
    let manager = CLLocationManager()
    
    //func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    // let location = locations[0]
    
    /*
     let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.007, longitudeDelta: 0.007)
     let mylocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
     let region:MKCoordinateRegion = MKCoordinateRegion.init(center: mylocation, span: span)
     Map.setRegion(region, animated: true)
     
     Map.showsUserLocation = true
     */
    // }
    
    // when clicked on state, it should show all district values.
    // do info page and mention crowd sourced database, api, covid19india.org website and data are recieved from state gov and
    // when user opens app for the first time show play video of what to do and yeah
    // loading bar launch view lol
    // loading icon when i pressed on dtate
    
    override func viewDidAppear(_ animated: Bool) {
        self.removeActivitySpinner()
    }
    
    override func viewDidLoad() {
        
        tabBarController?.selectedIndex = 1
        var tempcity = 0
        var tempdist = 0
        var tempstate = 0
        var count = 0
        var tndistcount = 0
        super.viewDidLoad()
        tabBarController?.tabBar.barTintColor = UIColor.black
        tabBarController?.tabBar.tintColor = UIColor.red
        Map.delegate = self
        let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 19, longitudeDelta: 18)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(23.552299, 78.878760)
        let region:MKCoordinateRegion = MKCoordinateRegion.init(center: location, span: span)
        Map.setRegion(region, animated: true)
        
        activityindicator.center = self.view.center
        activityindicator.hidesWhenStopped = true
        activityindicator.style = UIActivityIndicatorView.Style.medium
        self.view.addSubview(activityindicator)
        //activityindicator.startAnimating()
        //activityindicator.stopAnimating()
        
        
        //manager.delegate = self
        //manager.desiredAccuracy = kCLLocationAccuracyBest
        //manager.requestWhenInUseAuthorization()
        //manager.startUpdatingLocation()
        //Map.showsUserLocation = true
        guard let url = NSURL(string: "https://api.covid19india.org/raw_data.json") else { return }
        do {
            
            let data = try Data(contentsOf: url as URL)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let array = json as? [String:Any] else { return }
            guard let arr = array["raw_data"] as? [Any] else { return }
            var temp_state = 0
            while temp_state<36 {              // initalise count of cases in each state as 0
                case_state_count.append(0)
                //recovered_state_count.append(0)
                temp_state = temp_state + 1
            }
            var tn_num = 0
            for patient in arr  {
                guard let patientDict = patient as? [String : Any] else { print("f"); return }
                guard let detectedcity = patientDict["detectedcity"] as? String else { return }
                guard let detecteddistrict = patientDict["detecteddistrict"] as? String else { return }
                guard let detectedstate = patientDict["detectedstate"] as? String else { return }
                guard let currentstatus = patientDict["currentstatus"] as? String else { return }
                
                if detectedstate != "" {
                    if (statelist.isEmpty) {
                        statelist.append(detectedstate)
                        //print("woo")
                    }
                    if (statelist.contains(detectedstate) == false ) {
                        statelist.append(detectedstate)
                        //print("woo")
                    }
                    if (statelist.contains(detectedstate) == true ) {
                        var state_num = 0
                        for i in statelist {
                            if i == detectedstate {
                                case_state_count[state_num] = case_state_count[state_num] + 1
                                //if (currentstatus == "Recovered") {
                                  //  recovered_state_count[state_num] = recovered_state_count[state_num] + 1
                                //}
                            }
                            
                            state_num = state_num + 1
                        }
                    }
                }
                
                
                if detectedstate == "Tamil Nadu" {
                    
                    var Temp_num = 0
                    for i in statelist {
                        if i == detectedstate {
                            tn_num = Temp_num
                        }
                        Temp_num = Temp_num + 1
                    }
                    if (distlist[tn_num][0] == "-") {
                        distlist[tn_num][0] = detecteddistrict
                        distcount[tn_num][0] += 1
                        if (currentstatus == "Recovered") {
                            distRecovered[tn_num][tempdist] += 1
                        }
                    }
                    else if (distlist[tn_num].contains(detecteddistrict) == false ) {
                        if(detecteddistrict) == ""{
                            
                        }
                        else {
                            var tempdist = 0
                            var i = 0
                            while distlist[tn_num][i] != "-" {
                                tempdist = tempdist + 1
                                i = i + 1
                            }
                            tndistcount = tempdist
                            distlist[tn_num][tempdist] = (detecteddistrict)
                            distcount[tn_num][tempdist] += 1
                            if (currentstatus == "Recovered") {
                                distRecovered[tn_num][tempdist] += 1
                            }
                        }
                    }
                    else if (distlist[tn_num].contains(detecteddistrict) == true ){
                        var itrue = 0
                        var tempdisttrue = 0
                        while distlist[tn_num][itrue] != detecteddistrict {
                            tempdisttrue = tempdisttrue + 1
                            itrue = itrue + 1
                        }
                        distcount[tn_num][tempdisttrue] += 1
                        if (currentstatus == "Recovered") {
                            distRecovered[tn_num][tempdist] += 1
                        }
                    }
                }
                    
                    
                else {
                    var Temp_num = 0
                    var state_num = 0
                    for i in statelist {
                        if i == detectedstate {
                            state_num = Temp_num
                        }
                        Temp_num = Temp_num + 1
                    }
                    if (distlist[state_num][0] == "-") {
                        distlist[state_num][0] = detecteddistrict
                        distcount[state_num][0] += 1
                        if (currentstatus == "Recovered") {
                            distRecovered[state_num][tempdist] += 1
                        }
                        
                    }
                    else if (distlist[state_num].contains(detecteddistrict) == false ) {
                        if(detecteddistrict) == ""{
                            
                        }
                        else {
                            //distlist[tn_num].append(detecteddistrict)
                            var tempdist = 0
                            var i = 0
                            while distlist[state_num][i] != "-" {
                                tempdist = tempdist + 1
                                i = i + 1
                            }
                            //tndistcount = tempdist
                            distlist[state_num][tempdist] = (detecteddistrict)
                            distcount[state_num][tempdist] += 1
                            if (currentstatus == "Recovered") {
                                distRecovered[state_num][tempdist] += 1
                            }
                        }
                    }
                    else if (distlist[state_num].contains(detecteddistrict) == true ){
                        var itrue = 0
                        var tempdisttrue = 0
                        while distlist[state_num][itrue] != detecteddistrict {
                            tempdisttrue = tempdisttrue + 1
                            itrue = itrue + 1
                        }
                        //tndistcount = tempdist
                        //distlist[tn_num][tempdist] = (detecteddistrict)
                        distcount[state_num][tempdisttrue] += 1
                        if (currentstatus == "Recovered") {
                            distRecovered[state_num][tempdisttrue] += 1
                        }
                    }
                }
                
                
            }
            print("no of state",statelist.count)
            print(StateCode.count)
            /*
            statelist.append("Daman and Diu")
            statelist.append("Lakshadweep")
            statelist.append("Meghalaya")
            statelist.append("Nagaland")
            statelist.append("Sikkim")
            */



            //print("tamilnadu")
            //print("1d district count",case_dist_count.count)
            //print("2d district count",distcount[tn_num].count)
            //print("all dist count",distcount)
            /*                             //apple code
             for i in distlist {
             let geocoder = CLGeocoder()
             geocoder.geocodeAddressString(i, completionHandler: { placemarks, error in
             if (error != nil) { print(error!, i) ; return }
             if let placemark = placemarks?[0]  {
             let lat = String(format: "%.04f", (placemark.location?.coordinate.longitude ?? 0.0)!)
             let lon = String(format: "%.04f", (placemark.location?.coordinate.latitude ?? 0.0)!)
             //let name = placemark.name!
             //let country = placemark.country!
             //let region = placemark.administrativeArea!
             //print("\(lat),\(lon)\n\(i)")
             latlng[i][0] = lat
             latlng[i][1] = long
             
             }
             })
             }
             */
            /*
             var dist_no_temp = 0
             //print("distlist count",distlist.count)
             while dist_no_temp<tndistcount + 1 {              // initalise count of cases in each case as 0
             //print(dist_no_temp)
             case_dist_count.append(0)
             dist_no_temp = dist_no_temp + 1
             }
             */
            for patient in arr  {
                guard let patientDict = patient as? [String : Any] else {
                    print("f")
                    return }
                guard let detectedcity = patientDict["detectedcity"] as? String else { return }
                guard let detecteddistrict = patientDict["detecteddistrict"] as? String else { return }
                guard let detectedstate = patientDict["detectedstate"] as? String else { return }
                tempstate = 0
                tempdist = 0
                tempcity = 0
                if(detectedstate != "") {
                    
                    
                    /*
                     var dist_no = 0
                     for i in distlist[tn_num] {                         // gets count of cases in districts after all iterations
                     if i == detecteddistrict {
                     case_dist_count[dist_no] = case_dist_count[dist_no] + 1
                     }
                     dist_no = dist_no + 1
                     }
                     */
                    //apple function to geocode *NOT WORKING*
                    ///*
                    if (detectedstate == "Tamil Nadu" && detecteddistrict == "Chennai" ) {
                        /*          //apple geocoder
                         let geocoder = CLGeocoder()
                         geocoder.geocodeAddressString(detecteddistrict, completionHandler: { placemarks, error in
                         if (error != nil) {
                         //print(error!, detecteddistrict)
                         return
                         }
                         if let placemark = placemarks?[0]  {
                         let lat = String(format: "%.04f", (placemark.location?.coordinate.longitude ?? 0.0)!)
                         let lon = String(format: "%.04f", (placemark.location?.coordinate.latitude ?? 0.0)!)
                         //let name = placemark.name!
                         //let country = placemark.country!
                         //let region = placemark.administrativeArea!
                         //print("\(lat),\(lon)\n\(detecteddistrict)")
                         
                         }
                         })
                         */
                    }
                    
                    
                    //code for converting area to co-ord using google api
                    /*
                     if (detectedcity != "" ) {
                     tempcity = 1
                     }
                     else{
                     //print("no city!")
                     }
                     if (detecteddistrict.isEmpty == false) {
                     tempdist = 1
                     }
                     else{
                     //print("nodist")
                     }
                     var area_to_search = "lol"
                     if(tempdist == 1 && tempcity == 0) {
                     area_to_search = (detecteddistrict+"+"+detectedstate as String?)!
                     }
                     else if (tempdist == 1 && tempcity == 1) {
                     area_to_search = ((detecteddistrict+"+"+detectedcity+"+"+detectedstate) as String?)!
                     }
                     else if (tempdist == 0 && tempcity == 1) {
                     area_to_search = (detectedcity+"+"+detectedstate as String?)!
                     }
                     else {
                     area_to_search = (detectedstate as String?)!
                     }
                     */
                    /*
                     //print(area_to_search)
                     guard let googleurl = NSURL(string: "https://maps.googleapis.com/maps/api/geocode/json?address=\(area_to_search)&key=AIzaSyB2b2AVwJIS47fKGkf2rvPrBcMzLWCYSC8") else { return }
                     do {
                     let data = try Data(contentsOf: googleurl as URL)
                     print(data)
                     let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                     guard let arraygoogle = json as? [String:Any] else { return }
                     //print(array["raw_data"]!)
                     guard let arrgoogle = array["results"] as? [Any] else { return }
                     for result in arrgoogle {
                     guard let loctest = result as?  [String:Any] else { print("f") ; return }
                     guard let geometry = loctest["geometry"] as? [String:Any] else { return }
                     }
                     }
                     */
                }                                                                                   //end of if statement for check state
                //putMarker(lat: lat, long: long, title: title, Day1: Day1, Day2: Day2, Day3: Day3, Venue: Venue)
            }                                       // end of for loop
            //print("1d",case_dist_count)
            //var area_to_search = "Anna Nagar"
            
            
            var distcounter = 0
            var tempp = 0
            while distlist[tn_num][tempp] != "-" {
                if distlist[tn_num][tempp] == "" {
                    distlist[tn_num][tempp] = "-"
                }
                distcounter = distcounter + 1
                tempp = tempp + 1
            }
            let counti = distcounter  // takes input from list of districts and then gets lat,long values from api
            var case_tn_countt_temp = 0
            var i = counti
            let j = statelist.count
            var area_to_search = String()
            while(i<counti+j){
                
                if(i < counti){
                    area_to_search = distlist[tn_num][i]
                }
                else {
                    area_to_search = statelist[i-counti]
                }
                //if area_to_search == "The Nilgiris" {
                area_to_search = area_to_search.replacingOccurrences(of: " ", with: "+")
                //}
                
                area_to_search = area_to_search+",+India"
                
                
                guard let googleurl = NSURL(string: "https://maps.googleapis.com/maps/api/geocode/json?address=\(area_to_search)&key=AIzaSyB47qXTeoW5NXYRFMRp_B6r3DG7q6VEN84") else { print(area_to_search);return }
                do {
                    let data = try Data(contentsOf: googleurl as URL)
                    //print(data)
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    guard let arraygoogle = json as? [String:Any] else { print("2");return }
                    //print(array["raw_data"]!)
                    guard let arrgoogle = arraygoogle["results"] as? [Any] else { print("3");return }
                    for result in arrgoogle {
                        guard let loctest = result as?  [String:Any] else { print("f") ; return }
                        guard let geometry = loctest["geometry"] as? [String:Any] else {  print("g"); return }
                        guard let location = geometry["location"] as? [String:Any] else {  print("h"); return }
                        guard let latt = location["lat"] as? Double else {  print("i"); return }
                        guard let longg = location["lng"] as? Double else { print("j"); return }
                        //print(i)
                        //print(latt)
                        if(i < counti) {
                            latarr.append(latt)
                            lngarr.append(longg)
                        }
                        else {
                            //print(area_to_search)
                            statelatarr.append(latt)
                            statelngarr.append(longg)
                        }
                        case_tn_countt_temp = case_tn_countt_temp + 1
                    }
                }
                i=i+1
            }
            //print("yes",statelist)
            //print("ooo",statelngarr)
            
            for i in 0...statelist.count-1 {
                putMarker(lat: statelatarr[i], long: statelngarr[i], District_Name: statelist[i], State_Name: String(case_state_count[i]), state:0 )
            }
            
            var indiacount = 0
            for i in case_state_count {
                indiacount += i
            }
            var countText = "India Covid-19 Cases:"
            countText = countText + String(indiacount)
            countShow.text = countText
            
            // put pins on each state and then when that particular button is tapped, show all data in districtd
            // also change how u get count of cases in al dist in TN
            
            // putting markers for all cases in all districts
            /*
             var tnlen = 0
             for i in 0...distcount[tn_num].count - 10 {
             if(distcount[tn_num][i] != 0) {
             tnlen = tnlen + 1
             }
             }
             print("tnlen",tnlen)
             print(distcount[tn_num])
             var dist_counter = 0
             var tottt = 0
             while dist_counter<tnlen {
             
             let case_count = distcount[tn_num][dist_counter]
             var temp = 0
             while temp<case_count {
             putMarker(lat: latarr[dist_counter], long: lngarr[dist_counter], District_Name: distlist[tn_num][dist_counter], State_Name: "Tamil Nadu")
             temp = temp+1
             tottt = tottt+1
             }
             dist_counter = dist_counter + 1
             }
             
             print("marker",countmark)
             var sum = 0
             for i in case_dist_count {
             sum = sum + i
             }
             print(sum)
             */
            
            
            
        }
            
            
        catch {
            print(error)
        }
        
        //Map.showAnnotations(arraymark, animated: true)
        Map.register(EventMarkerView.self, forAnnotationViewWithReuseIdentifier: "a")
        Map.register(MapEventClusterView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        Map.register(StatesView.self, forAnnotationViewWithReuseIdentifier: "b")
        
    }
    
    
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
     override func viewDidAppear(_ animated:Bool ) {
     guard let path = Bundle.main.path(forResource: "Events", ofType: "json") else { return }
     let url = URL(fileURLWithPath: path)
     do {
     
     let data = try Data(contentsOf: url)
     let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
     guard let array = json as? [Any] else { return }
     
     for user in array {
     guard let userDict = user as? [String : Any] else { return }
     guard let lat = userDict["Lat"] as? Double else { return }
     guard let long = userDict["Long"] as? Double else { return }
     guard let title = userDict["title"] as? String else { return }
     guard let startTime = userDict["Start_Time"] as? String else { return }
     guard let endTime = userDict["End_Time"] as? String else { return }
     guard let date = userDict["Date"] as? String else { return }
     
     print(lat)
     print(long)
     print(title)
     
     putMarker(lat: lat, long: long, title: title, startTime: startTime, endTime: endTime, date: date)
     
     }
     catch {
     print(error)
     }
     }
     
     */
    
    
    func showspinner() {
        
        self.activityindicator.startAnimating()
        
    }
    
    
    func hidespinners()  {
        self.activityindicator.stopAnimating()
    }
    
    func putMarker(lat:Double, long:Double, District_Name:String, State_Name:String, state:Int ) {
        countmark += 1
        //print(lat,long)
        let annotation = MKPointAnnotation()
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
        annotation.coordinate = location
        annotation.title = District_Name
        annotation.subtitle = State_Name
        
        if(state == 1){
            Statedisplay.append(annotation)
        }
        Map.addAnnotation(annotation)
        //Map!.dequeueReusableAnnotationView(withIdentifier: nil)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if(statelist.contains(annotation.title!!)) {
            return StatesView(annotation: annotation, reuseIdentifier: "a")
        }
        else {
            return EventMarkerView(annotation: annotation, reuseIdentifier: "b")
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        showspinner()
        self.ShowActivitySpinner()
        if(initmarker != 100) {
            // move map to state
            let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 4, longitudeDelta: 4)
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake((view.annotation?.coordinate.latitude)!, (view.annotation?.coordinate.longitude)!)
            let region:MKCoordinateRegion = MKCoordinateRegion.init(center: location, span: span)
            mapView.setRegion(region, animated: true)
            
            if(removedSate.count != 0) {
                print("hi")
                mapView.addAnnotation(removedSate[0])
                removedSate.removeAll()
            }
            removedSate.append(view.annotation!)
            let StateSelected = view.annotation?.title
            print(StateSelected)
            mapView.removeAnnotation(view.annotation!)
            if(Statedisplay.count != 0) {
                mapView.removeAnnotations(Statedisplay)
                Statedisplay.removeAll()
                
                print("removed kerala")
            }
            var Temp_num = 0
            var state_num = 0
            for i in statelist {
                if i == StateSelected {
                    state_num = Temp_num
                }
                Temp_num = Temp_num + 1
            }
            var state_len = 0
            for i in 0...distcount[state_num].count - 10 {
                if(distcount[state_num][i] != 0) {
                    state_len = state_len + 1
                }
            }
            
            // trying state code lol
            
            var distcounter = 0
            var tempp = 0
            while distlist[state_num][tempp] != "-" {
                if distlist[state_num][tempp] == "" {
                    distlist[state_num][tempp] = "-"
                }
                distcounter = distcounter + 1
                tempp = tempp + 1
            }
            var Statelatarr: [Double] = []
            var Statelngarr: [Double] = []
            let counti = distcounter  // takes input from list of districts and then gets lat,long values from api
            var i = 0
            var area_to_search = String()
            while(i<counti){
                area_to_search = distlist[state_num][i]
                area_to_search = area_to_search.replacingOccurrences(of: " ", with: "+")
                let stateNameEdit = StateSelected!!.replacingOccurrences(of: " ", with: "+")
                area_to_search = area_to_search+",+"+"\(stateNameEdit)"
                guard let googleurl = NSURL(string: "https://maps.googleapis.com/maps/api/geocode/json?address=\(area_to_search)&key=AIzaSyB47qXTeoW5NXYRFMRp_B6r3DG7q6VEN84") else { print(area_to_search);return }
                do {
                    let data = try Data(contentsOf: googleurl as URL)
                    //print(data)
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    guard let arraygoogle = json as? [String:Any] else { print("2");return }
                    //print(array["raw_data"]!)
                    guard let arrgoogle = arraygoogle["results"] as? [Any] else { print("3");return }
                    for result in arrgoogle {
                        guard let loctest = result as?  [String:Any] else { print("f") ; return }
                        guard let geometry = loctest["geometry"] as? [String:Any] else {  print("g"); return }
                        guard let location = geometry["location"] as? [String:Any] else {  print("h"); return }
                        guard let latt = location["lat"] as? Double else {  print("i"); return }
                        guard let longg = location["lng"] as? Double else { print("j"); return }
                        Statelatarr.append(latt)
                        Statelngarr.append(longg)
                        
                    }
                }
                catch {
                    print(error)
                }
                i=i+1
            }
            
            var countText =  StateSelected!! + " Covid-19 Cases:"
            countText = countText + String(case_state_count[state_num])
            self.countShow.text = countText
            
            initmarker = 0
            
            
            // finding lat long from google api
            
            //print("state_len",state_len)
            //print("distcount of selected state",distcount[state_num])
            
            self.hidespinners()
            var dist_counter = 0
            var tottt = 0
            while dist_counter<state_len {
                let case_count = distcount[state_num][dist_counter]
                var temp = 0
                initmarker = 1
                while temp<case_count {
                    self.putMarker(lat: Statelatarr[dist_counter], long: Statelngarr[dist_counter], District_Name: distlist[state_num][dist_counter], State_Name: StateSelected!!, state: 1 )
                    
                    temp = temp+1
                    tottt = tottt+1
                }
                dist_counter = dist_counter + 1
            }
            
        }
            
        else if(view.rightCalloutAccessoryView?.tintColor == UIColor.red)
        {   /*
             print("hi")
             guard let clusterAnnotation = view.annotation as? MKClusterAnnotation else { return }
             let arrayCluster = clusterAnnotation.memberAnnotations
             arraymark = arrayCluster
             var i = Int()
             i=0
             // print(arrayCluster.count)
             while(i<arrayCluster.count){
             //print(arrayCluster[i].title as! String)
             i = i+1
             }
             //let controller = SheetViewController2()
             performSegue(withIdentifier: "collectionSegue", sender: view)
             // let sheetController = SheetViewController(controller: controller)
             // It is important to set animated to false or it behaves weird currently
             //self.present(controller, animated: false, completion: nil)
             */
            
        }
        else
        {
            //erformSegue(withIdentifier: "mapSegue", sender: view)
            //EventNameGlobal = view.annotation?.title as! String
            //print(view.clusteringIdentifier)
        }
        // EventNameGlobal = annotation!.title as! String
        //activityindicator.stopAnimating()
        
        self.removeActivitySpinner()
        
    }
    
    
    func seguebutton()
    {
        MapOrList = 2
        //print(MapOrList)
        //dismiss(animated: true, completion: nil)
        //   pushViewController(_ viewController: DetailsViewController, animated: Bool)
        self.performSegue(withIdentifier: "mapSegue", sender: EventMarkerView.self)
        //let myController = storyboard?.instantiateViewController(identifier: "DetailsViewController")
        //myController?.modalPresentationStyle = .fullScreen
        //self.present(myController!, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
}
