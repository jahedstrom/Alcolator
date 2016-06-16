//
//  ViewController.m
//  Alcolator
//
//  Created by Jonathan on 6/6/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldDidChange:(UITextField *)sender {
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    if(enteredNumber == 0) {
        // The user typed 0 or something that's not a number
        sender.text = 0;
    }
    
}

- (IBAction)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    
    [self updateView];
}

- (IBAction)buttonPressed:(id)sender {
    [self.beerPercentTextField resignFirstResponder];
    
    [self updateView];
   
    
}

- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}

- (float)calculateEquivalentAlcoholAmountWithOunces:(float)ouncesPerUnit andAlcoholPercentage:(float)alcoholPercentagePerUnit {
    // first, calculate how much alcohol is in all those beers..
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12; // Assume 12oz bottles
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesofAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    // now calculate the equivalent amount of alcohol per unit
    float ouncesOfAlcoholPerUnit = ouncesPerUnit * alcoholPercentagePerUnit;
    
    // check for div by 0
    if (ouncesOfAlcoholPerUnit > 0) {
        return (ouncesofAlcoholTotal / ouncesOfAlcoholPerUnit);
    } else {
        return 0;
    }
    
}

- (NSString *)getBeerText {
    int numberOfBeers = self.beerCountSlider.value;
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
    if (numberOfBeers == 1) {
        return NSLocalizedString(@"beer", @"singular beer");
    } else {
        return NSLocalizedString(@"beers", @"plural of beer");

    }
}

- (NSString *)resultTextWithAmount:(float)alcoholAmount {
    NSString *wineText;
    if (alcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText  = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    int numberOfBeers = self.beerCountSlider.value;
    
    // generate the result text, and display it on the label
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ (with %.2f%% alcohol) contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers,[self getBeerText], [self.beerPercentTextField.text floatValue], alcoholAmount, wineText];
    
    return resultText;
}

- (void)updateView {
    float EquivalentAlcoholAmount = [self calculateEquivalentAlcoholAmountWithOunces:5.0 andAlcoholPercentage:0.13];
    
    NSString *navTitle = [NSString stringWithFormat:NSLocalizedString(@"Wine (%.1f glasses)", nil), EquivalentAlcoholAmount];
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
