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
        CRUDController *crud = [CRUDController sharedInstance];
        for (int i = 0; i < [nameArray count]; i++) {
            city = [[City alloc] init];
            
            city.name = [NSString stringWithFormat:@"%@", nameArray[i]];
            city.country = [NSString stringWithFormat:@"%@", countryArray[i]];
            city.temp = [NSString stringWithFormat:@"%@", tempArray[i]];
            city.tempMax = [NSString stringWithFormat:@"%@", tempMaxArray[i]];
            city.tempMin = [NSString stringWithFormat:@"%@", tempMinArray[i]];
            city.pressure = [NSString stringWithFormat:@"%@", pressureArray[i]];
            
            NSLog(@"%@", city.name);
            [cities addObject:city];
            
            if ([crud searchItemFromEntity:@"Cities" ForName:city.name]) {
                NSLog(@"City already in DB");
            } else {
                [crud createCity:city];
            }
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
    
    self.city = [[City alloc] init];
    self.city.name = name;
    self.city.country = country;
    self.city.iD = Id;
    
    NSURL *url = [[NSURL alloc] initWithString:[BaseURL stringByAppendingString:Id]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation
                                               , id responseObject) {

        NSString *temp = [NSString stringWithFormat:@"%@", [[responseObject valueForKey:@"main"] valueForKey:@"temp"]];
        NSString *tempMax = [NSString stringWithFormat:@"%@", [[responseObject valueForKey:@"main"] valueForKey:@"temp_max"]];
        NSString *tempMin = [NSString stringWithFormat:@"%@", [[responseObject valueForKey:@"main"] valueForKey:@"temp_min"]];
        NSString *pressure = [NSString stringWithFormat:@"%@", [[responseObject valueForKey:@"main"] valueForKey:@"pressure"]];
        
        double tempCelsius = [temp doubleValue] - 273.15;
        double tempMaxCelsius = [tempMax doubleValue] - 273.15;
        double tempMinCelsius = [tempMin doubleValue] - 273.15;
      
        self.city.temp = [NSString stringWithFormat:@"%f", tempCelsius];
        self.city.tempMax = [NSString stringWithFormat:@"%f", tempMaxCelsius];
        self.city.tempMin = [NSString stringWithFormat:@"%f", tempMinCelsius];
        self.city.pressure = pressure;
        
    // TODO: implement NSNotifications
        [[NSNotificationCenter defaultCenter] postNotificationName:@"city_init_is_finished" object:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Handle error
        NSLog(@"Response error.");
    }];
    
    [operation start];
    
    return self.city;
}

@end
