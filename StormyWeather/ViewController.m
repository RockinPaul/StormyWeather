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

    // TODO: Refactoring this for init behaviour
    
    // Set the tableView
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"json"];
//    NSData *data = [NSData dataWithContentsOfFile:filePath];
//    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//    
//    self.ids = [json valueForKey:@"_id"];
//    self.locations = [json valueForKey:@"name"];
//    self.countries = [json valueForKey:@"country"];
    
    
    // Some of hardcode
    NSString *name = @"Saint Petersburg";
    NSString *country = @"RU";
    
    // Existing in DB
    if ([crud hasEntriesForEntityName:@"Cities"]) {
        // TODO: process cities from DB
    } else {
        NSLog(@"NO ENTRIES");
//        [self setCityWith:country andName:name];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cityWasInit)
                                                     name:@"city_init_is_finished"
                                                   object:nil];
    }
    
    [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    City *city = self.tableData[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = city.name;
    cell.detailTextLabel.text = city.temp;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", (long)indexPath.row); // TODO: modal adding-city window
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableData count]; // number of cities in user menu
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)cityWasInit {
    // TODO: process the city
    NSLog(@"city was init");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)setCityWith:(NSString *)country andName:(NSString *)name {
//    City *city;
//    for (int i = 0; i < [self.ids count]; i++) {
//        if ([self.locations[i] isEqualToString:name]) {
//            if ([self.countries[i] isEqualToString:country]) {
//                city = [[City alloc] initWithName:self.locations[i] id:self.ids[i] andCountry:self.countries[i]];
//            }
//        }
//    }
//}


@end
