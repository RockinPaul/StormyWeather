//
//  DetailViewController.h
//  StormyWeather
//
//  Created by Pavel on 19.05.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRUDController.h"
#import "ViewController.h"

@interface DetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *countryLabel;
@property (nonatomic, strong) IBOutlet UILabel *tempLabel;
@property (nonatomic, strong) IBOutlet UILabel *tempMaxLabel;
@property (nonatomic, strong) IBOutlet UILabel *tempMinLabel;
@property (nonatomic, strong) IBOutlet UILabel *pressureLabel;

- (IBAction)back:(UIButton *)sender;

@end
