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
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    self.ids = [json valueForKey:@"_id"];
    self.locations = [json valueForKey:@"name"];
    self.countries = [json valueForKey:@"country"];
    
    City *city;
    
    // Existing in DB
    if ([crud hasEntriesForEntityName:@"Cities"]) {
        // TODO: process cities from DB
    } else {
        NSLog(@"NO ENTRIES");
        for (int i = 0; i < [self.ids count]; i++) {
            if ([self.locations[i] isEqualToString:@"Saint Petersburg"]) {
                if ([self.countries[i] isEqualToString:@"RU"]) {
                    city = [[City alloc] initWithName:self.locations[i] id:self.ids[i] andCountry:self.countries[i]];
                }
            }
        }
    }

    // Set default cities
//    NSArray *values = [@"Moscow", @"Saint-Petersburg"];
    
   
    NSLog(@"Hey Ho, let's go!");
    
    [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if (cell == nil) {
        NSLog(@"Hey Ho, let's go!");

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = self.locations[indexPath.row];
    cell.detailTextLabel.text = @"Temperature";
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", (long)indexPath.row); // TODO: modal adding-city window
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.locations count]; // number of cities in user menu
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
