//
//  WhiskeyViewController.m
//  Alcolator
//
//  Created by Jonathan on 6/6/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "WhiskeyViewController.h"

@interface WhiskeyViewController ()

@end

@implementation WhiskeyViewController

- (IBAction)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    
    [self updateView];
}

- (void)buttonPressed:(UIButton *)sender {
    
    [self.beerPercentTextField resignFirstResponder];

    [self updateView];
}

// override this method from ViewController class
- (NSString *)resultTextWithAmount:(float)alcoholAmount {
    NSString *whiskeyText;

    if (alcoholAmount == 1) {
        whiskeyText = NSLocalizedString(@"shot", @"singular shot");
    } else {
        whiskeyText = NSLocalizedString(@"shots", @"plural of shot");
    }
    
    int numberOfBeers = self.beerCountSlider.value;
    
    // generate the result text, and display it on the label
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ (with %.2f%% alcohol) contains as much alcohol as %.1f %@ of whiskey.", nil), numberOfBeers,[self getBeerText], [self.beerPercentTextField.text floatValue], alcoholAmount, whiskeyText];
    
    return resultText;
}

// override this method from ViewController class
- (void)updateView {
    float EquivalentAlcoholAmount = [self calculateEquivalentAlcoholAmountWithOunces:1.0 andAlcoholPercentage:0.4];
    
    NSString *navTitle = [NSString stringWithFormat:NSLocalizedString(@"Whiskey (%.1f shots)", nil), EquivalentAlcoholAmount];
    self.navigationItem.title = navTitle;
    self.resultLabel.text = [self resultTextWithAmount:EquivalentAlcoholAmount];
    
    // determine if we should round the badge value up or down
    float fractionalValue = EquivalentAlcoholAmount - (int) EquivalentAlcoholAmount;
    int badgeNumber;
    if (fractionalValue < 0.5) {
        badgeNumber = (int) EquivalentAlcoholAmount;
    } else {
        badgeNumber = ceilf(EquivalentAlcoholAmount);
    }
    
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", badgeNumber]];
}


@end
