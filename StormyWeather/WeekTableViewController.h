//
//  WeekTableViewController.h
//  StormyWeather
//
//  Created by Pavel on 19.05.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface WeekTableViewController : UITableViewController

@property (nonatomic, strong) NSString *iD;
@property (nonatomic, strong) NSArray *weather;

@end