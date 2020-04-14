//
//  EventMarkerView.swift
//  COVID19 Tracker
//
//  Created by kishore saravanan on 09/02/20.
//  Copyright © 2020 kishore saravanan. All rights reserved.
//

import Foundation
import MapKit
import UIKit

//  MARK: Event Marker View
class EventMarkerView: MKMarkerAnnotationView {
    //  MARK: Properties
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
//  MARK: Configuration
extension EventMarkerView {
    func configure(with annotation: MKAnnotation) {
        glyphTintColor = .white
        markerTintColor = .red
        clusteringIdentifier = String(describing: EventMarkerView.self)
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
        glyphTintColor = .black
        markerTintColor = .systemTeal
    }
}
