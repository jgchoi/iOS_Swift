//
//  Transaction+CoreDataProperties.m
//  KidsBank
//
//  Created by Jung Geon Choi on 2016-01-31.
//  Copyright © 2016 Jung Geon Choi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Transaction+CoreDataProperties.h"

@implementation Transaction (CoreDataProperties)

@dynamic date;
@dynamic amount;
@dynamic reason;
@dynamic user;

@end
