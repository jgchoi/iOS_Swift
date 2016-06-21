//
//  Store+CoreDataProperties.swift
//  LCBO Finder
//
//  Created by Jung Geon Choi on 2016. 3. 24..
//  Copyright © 2016년 Jung Geon Choi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Store {

    @NSManaged var id: NSNumber?
    @NSManaged var is_dead: NSNumber?
    @NSManaged var name: String?
    @NSManaged var address_line_1: String?
    @NSManaged var address_line_2: String?
    @NSManaged var city: String?
    @NSManaged var postal_code: String?
    @NSManaged var telephone: String?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var has_wheelchair_accessability: NSNumber?
    @NSManaged var has_bilingual_services: NSNumber?
    @NSManaged var has_product_consultant: NSNumber?
    @NSManaged var has_tasting_bar: NSNumber?
    @NSManaged var has_beer_cold_room: NSNumber?
    @NSManaged var has_special_occasion_permits: NSNumber?
    @NSManaged var has_vintages_corner: NSNumber?
    @NSManaged var has_parking: NSNumber?
    @NSManaged var has_transit_access: NSNumber?
    @NSManaged var sunday_open: NSNumber?
    @NSManaged var sunday_close: NSNumber?
    @NSManaged var monday_open: NSNumber?
    @NSManaged var monday_close: NSNumber?
    @NSManaged var saturday_open: NSNumber?
    @NSManaged var saturday_close: NSNumber?
    @NSManaged var store_no: NSNumber?
    @NSManaged var tuesday_open: NSNumber?
    @NSManaged var tuesday_close: NSNumber?
    @NSManaged var thursday_open: NSNumber?
    @NSManaged var thursday_close: NSNumber?
    @NSManaged var friday_open: NSNumber?
    @NSManaged var friday_close: NSNumber?
    @NSManaged var updated_at: NSDate?

}
