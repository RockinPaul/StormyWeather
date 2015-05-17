//
//  City.h
//  StormyWeather
//
//  Created by Pavel on 17.05.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface City : NSObject

//{"coord":{"lon":145.77,"lat":-16.92},"sys":{"message":0.0065,"country":"AU","sunrise":1431808443,"sunset":1431849154},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"base":"cmc stations","main":{"temp":298.666,"temp_min":298.666,"temp_max":298.666,"pressure":1011.72,"sea_level":1029.32,"grnd_level":1011.72,"humidity":92},"wind":{"speed":7.47,"deg":125.5},"clouds":{"all":76},"dt":1431835644,"id":2172797,"name":"Cairns","cod":200}

@property (nonatomic, strong) NSString *iD;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *descriptions;
@property (nonatomic, strong) NSString *temp;
@property (nonatomic, strong) NSString *tempMin;
@property (nonatomic, strong) NSString *tempMax;
@property (nonatomic, strong) NSString *pressure;
@property (nonatomic, strong) NSString *windSpeed;

- (id)initWithName:(NSString *)name;

@end
