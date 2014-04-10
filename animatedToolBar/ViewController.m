//
//  ViewController.m
//  animatedToolBar
//
//  Created by Marcelo Sampaio on 4/10/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Initialization

-(void)viewWillAppear:(BOOL)animated {
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectOrientation) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UI Rotation
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"WILL rotate TO: %d",toInterfaceOrientation);
    
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"DID rotate FROM: %d",fromInterfaceOrientation);
}

#pragma mark - Orientation Initialization
-(void)detectOrientation {
    
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait)
    {
        NSLog(@"  detected: UIDeviceOrientationPortrait");
    }

    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft)
    {
        NSLog(@"  detected: UIDeviceOrientationLandscapeLeft");
    }
    
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown)
    {
        NSLog(@"  detected: UIDeviceOrientationPortraitUpsideDown");
    }
    
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)
    {
        NSLog(@"  detected: UIDeviceOrientationLandscapeRight");
    }
    [self dropTestImage];
    
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
//}


#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Debug Methods
-(void)dropTestImage
{
    
    UIImageView *testImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, -100, 50, 50)];
    testImageView.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:testImageView];
    
    // animate to the bottom of the screen
    [UIView animateWithDuration:0.80f animations:^(void)
     // Aqui se faz a animacao
     {
         CGPoint position=CGPointMake(testImageView.center.x,self.view.frame.size.height);
         
         testImageView.center=position;
         
     } completion:^(BOOL finished)
     //  Aqui executamos os procedimentos logo apos o termino da animacao
     {
         // Faz nada por enquanto no completion
     }];
    // FIM DA ANIMACAO
    [UIView commitAnimations];

    
    
    
    
}
    


@end
