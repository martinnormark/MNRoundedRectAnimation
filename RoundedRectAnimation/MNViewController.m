//
//  MNViewController.m
//  RoundedRectAnimation
//
//  Created by Martin Høst Normark on 11/03/14.
//  Copyright (c) 2014 Martin Høst Normark. All rights reserved.
//

#import "MNViewController.h"

@interface MNViewController ()

@property (nonatomic, retain) CAShapeLayer *progressLayer;

@end

@implementation MNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.strokeColor = [UIColor grayColor].CGColor;
    _progressLayer.fillColor = nil;
    _progressLayer.lineCap = kCALineCapButt;
    _progressLayer.lineJoin = kCALineJoinRound;
    _progressLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:670],
                                      [NSNumber numberWithInt:45],
                                      nil];
    _progressLayer.lineWidth = 5;
    
    CABasicAnimation *dashAnimation = [CABasicAnimation animationWithKeyPath:@"lineDashPhase"];
    [dashAnimation setFromValue:[NSNumber numberWithFloat:715.0f]];
    [dashAnimation setToValue:[NSNumber numberWithFloat:0.0f]];
    [dashAnimation setDuration:2.1f];
    [dashAnimation setRepeatCount:1000000];
    
    [_progressLayer addAnimation:dashAnimation forKey:@"linePhase"];

    [self.view.layer addSublayer:_progressLayer];
    
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 110, 300, 100) cornerRadius:50];
    
    // Set the path
    [_progressLayer setPath:roundedRect.CGPath];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 250, 300, 10)];
    slider.value = 2.1f;
    slider.minimumValue = 0.01f;
    slider.maximumValue = 10.0f;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:slider];
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    CAShapeLayer *presLayer = (CAShapeLayer*)[_progressLayer presentationLayer];

    CABasicAnimation *dashAnimation = [CABasicAnimation animationWithKeyPath:@"lineDashPhase"];
    [dashAnimation setFromValue:[NSNumber numberWithFloat:presLayer.lineDashPhase]];
    [dashAnimation setToValue:[NSNumber numberWithFloat:presLayer.lineDashPhase - 715.0f]];
    [dashAnimation setDuration:sender.value];
    [dashAnimation setRepeatCount:1000000];
    
    [_progressLayer removeAnimationForKey:@"linePhase"];
    [_progressLayer addAnimation:dashAnimation forKey:@"linePhase"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
