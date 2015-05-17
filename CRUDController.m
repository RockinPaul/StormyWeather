//
//  CRUDController.m
//  StormyWeather
//
//  Created by Pavel on 15.05.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import "CRUDController.h"
#import "City.h"

@implementation CRUDController

- (void)createCity:(City *)city {
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Cities" inManagedObjectContext:context];
    NSManagedObject *newCity = [[NSManagedObject alloc] initWithEntity:entityDesc insertIntoManagedObjectContext:context];
    
    [newCity setValue:city.iD forKey:@"id"];
    [newCity setValue:city.name forKey:@"name"];
    [newCity setValue:city.country forKey:@"country"];
    [newCity setValue:city.descriptions forKey:@"descriptions"];
    [newCity setValue:city.temp forKey:@"temp"];
    [newCity setValue:city.tempMin forKey:@"tempMin"];
    [newCity setValue:city.tempMax forKey:@"tempMax"];
    [newCity setValue:city.pressure forKey:@"pressure"];
    [newCity setValue:city.windSpeed forKey:@"windSpeed"];
    
    NSError *error;
    [context save:&error];
    NSLog(@"User added to CoreData!");
}

- (NSString *) getObjectId {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *objectId;
    
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"User"];
    [request setEntity:entityDesc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId != nil"];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (error != nil) {
        NSLog(@"ERROR!");
    }
    else {
        NSString *result = [results firstObject];
        objectId = [result valueForKey:@"objectId"];
        NSLog(@"%@", objectId);
    }
    
    return objectId;
}

- (void) printEntityContent: (NSString *) entityName forKey:(NSString *) keyName {
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:entityName];
    [request setEntity:entityDesc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId != nil"];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (error != nil) {
        NSLog(@"ERROR!");
    }
    else {
        for (NSString *result in results) {
            NSLog(@"%@", [result valueForKey:keyName]);
        }
        //NSLog(@"%@", [results description]);
    }
}

- (void) searchItemFromEntity:(NSString *) entity ForName:(NSString *) name {
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:entity inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId like %@", name];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:request error:&error];
    
    if(matchingData.count <= 0) {
        NSLog(@"NO item found");
    } else {
        NSString *item;
        
        for (NSManagedObject *obj in matchingData) {
            item = [obj valueForKey:@"objectId"];
        }
        NSLog(@"%@", item);
    }
}


- (BOOL) coreDataHasEntriesForEntityName:(NSString *)entityName {
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [request setEntity:entity];
    [request setFetchLimit:1];
    NSError *error = nil;
    if(entity)
    {
        NSArray *results = [context executeFetchRequest:request error:&error];
        if (!results) {
            NSLog(@"Fetch error: %@", error);
            abort();
        }
        if ([results count] == 0) {
            NSLog(@"NO!");
            return NO;
        }
        NSLog(@"Yeah!");
        return YES;
    }
    return NO;
}

- (void) deleteAllObjectsFromEntity: (NSString *) entityName {
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSFetchRequest *allObjects = [[NSFetchRequest alloc] init];
    [allObjects setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:context]];
    [allObjects setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:allObjects error:&error];
    //error handling goes here
    for (NSManagedObject *obj in objects) {
        [context deleteObject:obj];
    }
    NSError *saveError = nil;
    [context save:&saveError];
    //more error handling here
    
    NSLog(@"All enteries are deleted!");
}

+(CRUDController *) sharedInstance {
    static dispatch_once_t pred;
    static CRUDController *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[CRUDController alloc] init];
    });
    return sharedInstance;
}

@end
