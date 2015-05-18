//
//  ViewController.m
//  StormyWeather
//
//  Created by Pavel on 14.05.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *addCityButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addCityButtonClicked:)];
    self.navigationItem.rightBarButtonItem = addCityButton;
    
    CRUDController *crud = [CRUDController sharedInstance];
    // TODO: try to load from database
    
    NSArray *idArray = @[@"524901", @"498817"];
    City *city = [[City alloc] init];
    self.cities = [city getDataForCities:idArray];
    
    // Set the tableView
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(layoutMargins)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    // Existing in DB
    if ([crud hasEntriesForEntityName:@"Cities"]) {
        // TODO: process cities from DB
    } else {
        NSLog(@"NO ENTRIES");
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(citiesWasInit)
                                                     name:@"cities_data_retrieved"
                                                   object:nil];
    }
    
    [self.tableView reloadData];
}

- (void)addCityButtonClicked:(UIBarButtonItem *)barButtonItem {
    CitiesTableViewController *listController = [[CitiesTableViewController alloc] init];
    [self presentViewController:listController animated:YES completion:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    City *city = self.cities[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.layoutMargins = UIEdgeInsetsZero;

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(260, 28, 80, 20)];
    tempLabel.text = [NSString stringWithFormat:@"%@", city.temp];
    
    cell.textLabel.text = city.name;
    cell.detailTextLabel.text = city.country;
    [cell addSubview:tempLabel];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", (long)indexPath.row); // TODO: modal adding-city window
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cities count]; // number of cities in user menu
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (void)citiesWasInit {
    // TODO: process the city
//    for (City *city in self.cities) {
//        NSLog(@"%@ %@ %@", city.name, city.country, city.temp);
//    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
