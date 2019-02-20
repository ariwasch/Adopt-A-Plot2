//
//  Border.swift
//  Adopt-A-Plot
//
//  Created by Ari Wasch on 11/3/18.
//  Copyright © 2018 Ari Wasch. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import Foundation
@objc class Border: NSObject {
    
    let coordinates = Coord.getCoords()
    
    var pole: String?
    var point: Int
    
    init(coordinate: CLLocationCoordinate2D, pole: String?, point: Int) {
        self.point = point
        self.pole = pole
        
        
    }
    func getStringName() -> String?{
        var result: String
        result = String(point)
        return result
    }
}
