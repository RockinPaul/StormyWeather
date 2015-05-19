//
//  WeekTableViewController.m
//  StormyWeather
//
//  Created by Pavel on 19.05.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import "WeekTableViewController.h"

@interface WeekTableViewController ()

@end

@implementation WeekTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(layoutMargins)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    CRUDController *crud = [[CRUDController alloc] init];
    
    NSLog(@"%@", ViewController.passingId);
    City *city = [crud getCityById:ViewController.passingId];
    self.weather = [city getWeeklyWeatherForCity:city.iD];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(weekDataRetreived)
                                                 name:@"weekly_data_retrieved"
                                               object:nil];
}

- (void)weekDataRetreived {
    NSLog(@"%@", [self.weather description]);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [NSString  stringWithFormat:@"Cell_%ld", (long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.layoutMargins = UIEdgeInsetsZero;
    }

    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
