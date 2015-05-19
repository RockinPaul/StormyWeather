//
//  DetailViewController.m
//  StormyWeather
//
//  Created by Pavel on 19.05.15.
//  Copyright (c) 2015 Zitech Mobile LLC. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CRUDController *crud = [[CRUDController alloc] init];

    NSLog(@"%@", ViewController.passingId);
    City *city = [crud getCityById:ViewController.passingId];
    NSLog(@"%@", city.temp);

    self.nameLabel.text = city.name;
    self.countryLabel.text = city.country;
    self.tempLabel.text = city.temp;
    self.tempMaxLabel.text = city.tempMax;
    self.tempMinLabel.text = city.tempMin;
    self.pressureLabel.text =city.pressure;
}

- (void)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
