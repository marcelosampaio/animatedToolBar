//
//  ViewController.m
//  animatedToolBar
//
//  Created by Marcelo Sampaio on 4/10/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "ViewController.h"

// iPhone 3.5'' inch
#define DEVICE_IPHONE_35_PORTRAIT_WIDTH             320
#define DEVICE_IPHONE_35_PORTRAIT_HEIGHT            480

#define DEVICE_IPHONE_35_LANDSCAPE_WIDTH            480
#define DEVICE_IPHONE_35_LANDSCAPE_HEIGHT           320


// iPhone 4'' inch
#define DEVICE_IPHONE_40_PORTRAIT_WIDTH             320
#define DEVICE_IPHONE_40_PORTRAIT_HEIGHT            568

#define DEVICE_IPHONE_40_LANDSCAPE_WIDTH            568
#define DEVICE_IPHONE_40_LANDSCAPE_HEIGHT           320


// iPad
#define DEVICE_IPAD_PORTRAIT_WIDTH                  768
#define DEVICE_IPAD_PORTRAIT_HEIGHT                 1024

#define DEVICE_IPAD_LANDSCAPE_WIDTH                 1024
#define DEVICE_IPAD_LANDSCAPE_HEIGHT                768




@interface ViewController ()

@end

@implementation ViewController

@synthesize deviceWidth,deviceHeigth;



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
        [self setDeviceLogicalSizeFor:@"Portrait"];
    }
    
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown)
    {
        NSLog(@"  detected: UIDeviceOrientationPortraitUpsideDown");
        [self setDeviceLogicalSizeFor:@"Portrait"];
    }

    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft)
    {
        NSLog(@"  detected: UIDeviceOrientationLandscapeLeft");
        [self setDeviceLogicalSizeFor:@"Landscape"];
    }
    
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)
    {
        NSLog(@"  detected: UIDeviceOrientationLandscapeRight");
        [self setDeviceLogicalSizeFor:@"Landscape"];
    }
    
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
//}



#pragma mark - Working Methods

-(void)setDeviceLogicalSizeFor:(NSString *)orientation
{
    BOOL iPhoneDevice=[self deviceRecognition];
    if (iPhoneDevice) {
        // 4 inch  or 3.5 inch screen size (TO DO)
        if ([orientation isEqualToString:@"Portrait"]) {
            self.deviceWidth=DEVICE_IPHONE_40_PORTRAIT_WIDTH;
            self.deviceHeigth=DEVICE_IPHONE_40_PORTRAIT_HEIGHT;
        } else {
            self.deviceWidth=DEVICE_IPHONE_40_LANDSCAPE_WIDTH;
            self.deviceHeigth=DEVICE_IPHONE_40_LANDSCAPE_HEIGHT;
        }

        
    } else {
        // iPad
        if ([orientation isEqualToString:@"Portrait"]) {
            self.deviceWidth=DEVICE_IPAD_PORTRAIT_WIDTH;
            self.deviceHeigth=DEVICE_IPAD_PORTRAIT_HEIGHT;
        } else {
            self.deviceWidth=DEVICE_IPAD_LANDSCAPE_WIDTH;
            self.deviceHeigth=DEVICE_IPAD_LANDSCAPE_HEIGHT;
        }
    }

    // Remove views from super view
    [self removeAllViewsFromSuperView];
    
    // Debug purposes
    [self dropTestImage];
    
}

-(BOOL)deviceRecognition
{
    BOOL iPhoneDevice=YES;
    //device recognition
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        iPhoneDevice=NO;
    }else if (([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)) {
        iPhoneDevice=YES;
    }
    return iPhoneDevice;
}

-(void)removeAllViewsFromSuperView
{
    for (UIView *subview in self.view.subviews) {
        [subview removeFromSuperview];
    }
}


#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Debug Methods
-(void)dropTestImage
{
    UIImageView *testImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.deviceWidth/2, -100, 50, 50)];
    testImageView.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:testImageView];
    
    // animate to the bottom of the screen
    [UIView animateWithDuration:0.80f animations:^(void)
     // Aqui se faz a animacao
     {
         CGPoint position=CGPointMake(testImageView.center.x,self.deviceHeigth);
         
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
