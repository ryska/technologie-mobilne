//
//  AlbumsSingleton.swift
//  zadanie1
//
//  Created by Adrianna Ryś on 11.11.2016.
//  Copyright © 2016 ada. All rights reserved.
//

import Foundation

class AlbumsSingleton {
    static let sharedInstance : AlbumsSingleton = {
        let instance = AlbumsSingleton()
        return instance
    }();
    
    var list: NSMutableArray = NSMutableArray(contentsOfFile:Bundle.main.path(forResource: "albums", ofType: "plist")!)!;
}
