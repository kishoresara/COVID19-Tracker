//
//  EventMarkerView.swift
//  Amrita Events
//
//  Created by kishore saravanan on 09/02/20.
//  Copyright © 2020 kishore saravanan. All rights reserved.
//

import Foundation
import MapKit
import UIKit

var EventNameGlobal = String()

//  MARK: Event Marker View
class EventMarkerView: MKMarkerAnnotationView {
    
    
    //  MARK: Properties
    override var annotation: MKAnnotation? { willSet { newValue.flatMap(configure(with:)) } }
    
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        displayPriority = .defaultHigh
        //isEnabled = true
        canShowCallout = true
        let btn = UIButton(type: .infoLight)
        rightCalloutAccessoryView = btn
        //btn.tintColor = .red
      //  accessibilityRespondsToUserInteraction = false
      //  btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    // @objc func buttonTapped() {
      //  print(annotation!.title as! String)
      //  EventNameGlobal = annotation!.title as! String
        
        
        
      
   // }

    
   required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
      
    
}

//  MARK: Configuration

 extension EventMarkerView {
    func configure(with annotation: MKAnnotation) {
       // guard annotation is BattleRapper else { fatalError("Unexpected annotation type: \(annotation)") }
        glyphTintColor = .white
        markerTintColor = .red
        //print(initmarker)
        //if(initmarker == 1) {
        clusteringIdentifier = String(describing: EventMarkerView.self)
        //}
    }


}


class StatesView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? { willSet { newValue.flatMap(configure(with:)) } }
     
     
     override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
         super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
         
         displayPriority = .defaultHigh
         canShowCallout = true
         let btn = UIButton(type: .infoLight)
         rightCalloutAccessoryView = btn
         
     }
     
     
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }
     
       
     
}

extension StatesView {
    func configure(with annotation: MKAnnotation) {
       // guard annotation is BattleRapper else { fatalError("Unexpected annotation type: \(annotation)") }
        glyphTintColor = .black
        markerTintColor = .systemTeal
        
    }


}
