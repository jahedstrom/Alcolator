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
    
    [self updateWhiskeyView];
}

- (void)buttonPressed:(UIButton *)sender {
    
    [self.beerPercentTextField resignFirstResponder];

    [self updateWhiskeyView];
}

- (float)calculateWhiskeyEquivalent {
    
    // first, calculate how much alcohol is in all those beers..
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12; // Assume 12oz bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesofAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    // now calculate the equivalent amount of whiskey
    float ouncesInOneWhiskeyGlass = 1;  // a 1oz shot
    float alcoholPercentageOfWhiskey = 0.4;  // 40% is average
    float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
    
    
    // check for div by 0
    if (ouncesOfAlcoholPerWhiskeyGlass > 0) {
        return (ouncesofAlcoholTotal / ouncesOfAlcoholPerWhiskeyGlass);
    } else {
        return 0;
    }
}

- (void)updateWhiskeyView {
    
    float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = [self calculateWhiskeyEquivalent];
    
    NSString *whiskeyTitle = [NSString stringWithFormat:NSLocalizedString(@"Whiskey (%.1f shots)", nil),numberOfWhiskeyGlassesForEquivalentAlcoholAmount];
    self.navigationItem.title = whiskeyTitle;
    
    
    int numberOfBeers = self.beerCountSlider.value;
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *whiskeyText;
    
    if (numberOfWhiskeyGlassesForEquivalentAlcoholAmount == 1) {
        whiskeyText = NSLocalizedString(@"shot", @"singular shot");
    } else {
        whiskeyText = NSLocalizedString(@"shots", @"plural of shot");
    }
    
    // generate the result text, and display it on the label
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ (with %.2f%% alcohol) contains as much alcohol as %.1f %@ of whiskey.", nil), numberOfBeers, beerText, [self.beerPercentTextField.text floatValue], numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];
    self.resultLabel.text = resultText;
}


@end
