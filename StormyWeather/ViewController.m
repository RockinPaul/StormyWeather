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
    
    CRUDController *crud = [CRUDController sharedInstance];
    
    NSArray *idArray = @[@"524901", @"498817"];
    City *city = [[City alloc] init];
    self.cities = [city getDataForCities:idArray];

    // TODO: Refactoring this for init behaviour
    
    // Set the tableView
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"json"];
//    NSData *data = [NSData dataWithContentsOfFile:filePath];
//    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//    =
//    self.ids = [json valueForKey:@"_id"];
//    self.locations = [json valueForKey:@"name"];
//    self.countries = [json valueForKey:@"country"];
    
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    City *city = self.cities[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = city.name;
    cell.detailTextLabel.text = city.country;
    
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
