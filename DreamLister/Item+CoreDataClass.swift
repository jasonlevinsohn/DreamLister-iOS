//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by jlev on 7/13/17.
//  Copyright © 2017 L3. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }
}
