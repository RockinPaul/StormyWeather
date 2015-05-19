//
//  ViewController.m
//  StormyWeather
//
//  Created by Pavel on 14.05.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

static NSString *passingId = nil;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *addCityButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addCityButtonClicked:)];
    self.navigationItem.rightBarButtonItem = addCityButton;
    
    // Set the tableView
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(layoutMargins)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    
}

- (void)viewDidAppear:(BOOL)animated {

    CRUDController *crud = [CRUDController sharedInstance];
    NSMutableArray *ids = [[NSMutableArray alloc] init];
    self.updates = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(citiesUpdated)
                                                 name:@"cities_data_retrieved"
                                               object:nil];
    
    if ([crud hasEntriesForEntityName:@"Cities"]) {
        // TODO: process cities from DB
        self.cities = [crud getAllCities];
        [self.tableView reloadData];
        
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];

        if (networkStatus == NotReachable) {
            NSLog(@"There IS NO internet connection");
        } else {
            for (City *tempCity in self.cities) {
                [ids addObject:tempCity.iD];
            }
            NSLog(@"%lu", (unsigned long)[ids count]);
            self.updates = [[City alloc] getDataForCities:ids];
            NSLog(@"There IS internet connection");
        }
    
    } else {
        NSLog(@"NO ENTRIES");
        NSArray *idArray = @[@"524901", @"498817"];
        City *city = [[City alloc] init];
        self.cities = [city getDataForCities:idArray];
    }
}

- (void)addCityButtonClicked:(UIBarButtonItem *)barButtonItem {
    CitiesTableViewController *listController = [[CitiesTableViewController alloc] init];
    [self presentViewController:listController animated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    City *city = self.cities[indexPath.row];
    
    NSString *CellIdentifier = [NSString  stringWithFormat:@"Cell_%ld", (long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 28, 80, 20)];
    tempLabel.text = [NSString stringWithFormat:@"%@", city.temp];
    
    cell.textLabel.text = city.name;
    cell.detailTextLabel.text = city.country;
    [cell addSubview:tempLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(citiesWasInit)
                                                 name:@"city_added"
                                               object:nil];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    City *city = self.cities[indexPath.row];
    [ViewController setPassingId:city.iD];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    TabBarController *controller = (TabBarController*)[mainStoryboard
                                                       instantiateViewControllerWithIdentifier: @"tabbar"];
    [self presentViewController:controller animated:YES completion:nil];
    
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
    [self.tableView reloadData];
}

- (void)citiesUpdated {
    
    CRUDController *crud = [CRUDController sharedInstance];
    self.cities = [self.updates copy];
    
    for (City *city in self.cities) {
        [crud updateCityWithId:city.iD ByCity:city];
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (NSString *)passingId {
    return passingId;
}

+ (void)setPassingId:(NSString *)iD {
    passingId = iD;
}


@end
