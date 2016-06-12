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
    
    [self updateWineView];
}

- (IBAction)buttonPressed:(id)sender {
    [self.beerPercentTextField resignFirstResponder];
    
    [self updateWineView];
   
    
}

- (IBAction)tapGestureDidFIre:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}

- (float)calculateWineEquivalent {
    
    // first, calculate how much alcohol is in all those beers..
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12; // Assume 12oz bottles
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesofAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    // now calculate the equivalent amount of wine
    float ouncesInOneWineGlass = 5;
    float alcoholPercentageOfWine = 0.13; // 13% average
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    
    // check for div by 0
    if (ouncesOfAlcoholPerWineGlass > 0) {
        return (ouncesofAlcoholTotal / ouncesOfAlcoholPerWineGlass);
    } else {
        return 0;
    }
    
}

- (void)updateWineView {
    
    float numberOfWineGlassesForEquivalentAlcoholAmount = [self calculateWineEquivalent];
    
    NSString *wineTitle = [NSString stringWithFormat:NSLocalizedString(@"Wine (%.1f glasses)", nil),numberOfWineGlassesForEquivalentAlcoholAmount];
    self.navigationItem.title = wineTitle;

    
    int numberOfBeers = self.beerCountSlider.value;
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
        NSString *beerText;
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
        NSString *wineText;
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText  = NSLocalizedString(@"glasses", @"plural of glass");
    }

    
    // generate the result text, and display it on the label
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ (with %.2f%% alcohol) contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, [self.beerPercentTextField.text floatValue], numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;

}


@end
