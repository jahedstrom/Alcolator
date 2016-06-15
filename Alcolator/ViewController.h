//
//  ViewController.h
//  Alcolator
//
//  Created by Jonathan on 6/6/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *beerPercentTextField;
@property (weak, nonatomic) IBOutlet UISlider *beerCountSlider;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

- (float)calculateEquivalentAlcoholAmountWithOunces:(float)ouncesPerUnit andAlcoholPercentage:(float)alcoholPercentagePerUnit;
- (NSString *)getBeerText;
- (NSString *)resultTextWithAmount:(float)alcoholAmount;
- (void)updateView;


@end

