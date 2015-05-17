//
//  CRUDController.h
//  StormyWeather
//
//  Created by Pavel on 15.05.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "City.h"

@interface CRUDController : NSObject

@property (nonatomic, strong) CRUDController *crud;

- (void)createCity:(City *)city;
- (NSString *)getCityId;
- (NSString *)getCityById;
- (void) printEntityContent:(NSString *) entityName forKey:(NSString *) keyName;
- (void) searchItemFromEntity:(NSString *) entity ForName:(NSString *) name;
- (BOOL)hasEntriesForEntityName:(NSString *) entityName;
- (void) deleteAllObjectsFromEntity: (NSString *) entityName;

+ (CRUDController *) sharedInstance;

@end
