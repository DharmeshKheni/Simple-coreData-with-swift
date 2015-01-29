//
//  Model.swift
//  CoreData
//
//  Created by Dharmesh on 01/11/14.
//  Copyright (c) 2014 Dharmesh. All rights reserved.
//

import UIKit
import CoreData
@objc(Model)

class Model: NSManagedObject {
   
    // Properties feeding the attributes in our entity
    // Must match the entity atributes
    
    @NSManaged var iteam : String
    @NSManaged var quantity : String
    @NSManaged var info : String
     
}
