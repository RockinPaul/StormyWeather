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
