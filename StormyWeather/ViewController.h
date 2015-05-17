//
//  ViewController.h
//  StormyWeather
//
//  Created by Pavel on 14.05.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRUDController.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableData;
//
//@property (nonatomic, strong) NSArray *locations;
//@property (nonatomic, strong) NSArray *ids;
//@property (nonatomic, strong) NSArray *countries;

@end

