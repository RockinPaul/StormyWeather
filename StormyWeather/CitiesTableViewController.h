//
//  CitiesTableViewController.h
//  StormyWeather
//
//  Created by Pavel on 18.05.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRUDController.h"
#import "City.h"

@interface CitiesTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *ids;
@property (nonatomic, strong) NSArray *locations;
@property (nonatomic, strong) NSArray *countries;
@property (nonatomic, strong) City *city;

@end
