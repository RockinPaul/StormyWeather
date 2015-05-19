//
//  ViewController.h
//  StormyWeather
//
//  Created by Pavel on 14.05.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRUDController.h"
#import "CitiesTableViewController.h"
#import "Reachability.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *cities;
@property (nonatomic, strong) NSMutableArray *updates; // for responded updates

- (void)addCityButtonClicked:(UIBarButtonItem *)barButtonItem;

@end

