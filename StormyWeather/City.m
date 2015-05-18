//
//  City.m
//  StormyWeather
//
//  Created by Pavel on 17.05.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import "City.h"
#import "CRUDController.h"

@implementation City

// Base weather request URL
NSString *const BaseURL = @"http://api.openweathermap.org/data/2.5/weather?id=";


- (NSString *)getURLforSeveralCities:(NSArray *)citiesId {
    
    NSMutableString *url = [NSMutableString stringWithString:@"http://api.openweathermap.org/data/2.5/group?id=&units=metric"]; // 524901,703448,2643743
    NSString *ids = [citiesId componentsJoinedByString:@","];
    NSLog(@"%@", ids);
    
    [url insertString:ids atIndex:48];
    NSLog(@"%@", url);
    
    return url;
}

- (id)getDataForCities:(NSArray *)citiesId {
    
    NSMutableArray *cities = [[NSMutableArray alloc] init]; // Array for City objects
    
    NSURL *url = [[NSURL alloc] initWithString:[self getURLforSeveralCities:citiesId]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation
                                               , id responseObject) {
        NSMutableArray *nameArray = [[responseObject valueForKey:@"list"] valueForKey:@"name"];
        NSMutableArray *countryArray = [[[responseObject valueForKey:@"list"] valueForKey:@"sys"] valueForKey:@"country"];
        NSMutableArray *mainArray = [[responseObject valueForKey:@"list"] valueForKey:@"main"];
        NSMutableArray *tempArray = [mainArray valueForKey:@"temp"];
        NSMutableArray *tempMaxArray = [mainArray valueForKey:@"temp_max"];
        NSMutableArray *tempMinArray = [mainArray valueForKey:@"temp_min"];
        NSMutableArray *pressureArray = [mainArray valueForKey:@"pressure"];
        
        
        City *city;
        for (int i = 0; i < [nameArray count]; i++) {
            city = [[City alloc] init];
            city.name = nameArray[i];
            city.country = countryArray[i];
            city.temp = tempArray[i];
            city.tempMax = tempMaxArray[i];
            city.tempMin = tempMinArray[i];
            city.pressure = pressureArray[i];
            
            NSLog(@"%@", city.name);
            [cities addObject:city];
        }
        
        // Notification to ViewController
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cities_data_retrieved" object:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Handle error
        NSLog(@"Response error.");
    }];
    
    [operation start];
    
    return cities;
}

- (id)initWithName:(NSString *)name id:(NSString *)Id andCountry:(NSString *)country {
    
    CRUDController *crud = [CRUDController sharedInstance];
    
    City *city = [[City alloc] init];
    city.name = name;
    
    // Creating URL string for current city
    // Need to init id from database
    
//    city.iD = [crud getIdByName]; // TODO: implement getIdByName method in CRUDController
    
    NSURL *url = [[NSURL alloc] initWithString:[BaseURL stringByAppendingString:Id]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation
                                               , id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSLog(@"%@", [[responseObject valueForKey:@"main"] valueForKey:@"temp"]);
        
    // TODO: implement NSNotifications
        [[NSNotificationCenter defaultCenter] postNotificationName:@"city_init_is_finished" object:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Handle error
        NSLog(@"Response error.");
    }];
    
    [operation start];
    
    return city;
}

@end
