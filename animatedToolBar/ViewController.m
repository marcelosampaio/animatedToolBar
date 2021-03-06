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
#define DEVICE_IPHONE_35_PORTRAIT_TOOLBAR_IMAGE     @"iPhone35PortraitToolBar"

#define DEVICE_IPHONE_35_LANDSCAPE_WIDTH            480
#define DEVICE_IPHONE_35_LANDSCAPE_HEIGHT           320
#define DEVICE_IPHONE_35_LANDSCAPE_TOOLBAR_IMAGE    @"iPhone35LandscapeToolBar"

// iPhone 4'' inch
#define DEVICE_IPHONE_40_PORTRAIT_WIDTH             320
#define DEVICE_IPHONE_40_PORTRAIT_HEIGHT            568
#define DEVICE_IPHONE_40_PORTRAIT_TOOLBAR_IMAGE     @"iPhone40PortraitToolBar"

#define DEVICE_IPHONE_40_LANDSCAPE_WIDTH            568
#define DEVICE_IPHONE_40_LANDSCAPE_HEIGHT           320
#define DEVICE_IPHONE_40_LANDSCAPE_TOOLBAR_IMAGE    @"iPhone40PortraitToolBar"


// iPad
#define DEVICE_IPAD_PORTRAIT_WIDTH                  768
#define DEVICE_IPAD_PORTRAIT_HEIGHT                 1024
#define DEVICE_IPAD_PORTRAIT_TOOLBAR_IMAGE          @"iPadPortraitToolBar"

#define DEVICE_IPAD_LANDSCAPE_WIDTH                 1024
#define DEVICE_IPAD_LANDSCAPE_HEIGHT                768
#define DEVICE_IPAD_LANDSCAPE_TOOLBAR_IMAGE         @"iPadLandscapeToolBar"


@interface ViewController ()

@end

@implementation ViewController

@synthesize deviceWidth,deviceHeigth;

@synthesize toolBarIsVisible;

@synthesize toolBarImageName;



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

#pragma mark - Orientation
-(void)detectOrientation {
    NSString *orientation;
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait) {
        orientation=@"Portrait";
    } else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown) {
        orientation=@"Portrait";
    } else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) {
        orientation=@"Landscape";
    } else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
        orientation=@"Landscape";
    }else{
        return;
    }
    [self setDeviceLogicalSizeForOrientation:orientation];
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
//}


#pragma mark - Working Methods
-(void)setDeviceLogicalSizeForOrientation:(NSString *)orientation
{
    self.toolBarImageName=@"";
    
    BOOL iPhoneDevice=[self deviceRecognition];
    if (iPhoneDevice) {
        // 4 inch  or 3.5 inch screen size (TO DO)
        if ([orientation isEqualToString:@"Portrait"]) {

            // Determine 3.5 or 4 inch screen size
            if (self.view.frame.size.height==DEVICE_IPHONE_40_PORTRAIT_HEIGHT || self.view.frame.size.width==DEVICE_IPHONE_40_PORTRAIT_HEIGHT) {
                self.deviceWidth=DEVICE_IPHONE_40_PORTRAIT_WIDTH;
                self.deviceHeigth=DEVICE_IPHONE_40_PORTRAIT_HEIGHT;
                self.toolBarImageName=DEVICE_IPHONE_40_PORTRAIT_TOOLBAR_IMAGE;
            }
            else  //  3.5 inch screen size
            {
                self.deviceWidth=DEVICE_IPHONE_35_PORTRAIT_WIDTH;
                self.deviceHeigth=DEVICE_IPHONE_35_PORTRAIT_HEIGHT;
                self.toolBarImageName=DEVICE_IPHONE_35_PORTRAIT_TOOLBAR_IMAGE;
            }
            
            
        } else {
            // Determine 3.5 or 4 inch screen size
            if (self.view.frame.size.height==DEVICE_IPHONE_40_LANDSCAPE_HEIGHT || self.view.frame.size.width==DEVICE_IPHONE_40_LANDSCAPE_HEIGHT) {
                self.deviceWidth=DEVICE_IPHONE_40_LANDSCAPE_WIDTH;
                self.deviceHeigth=DEVICE_IPHONE_40_LANDSCAPE_HEIGHT;
                self.toolBarImageName=DEVICE_IPHONE_40_LANDSCAPE_TOOLBAR_IMAGE;
            }
            else
            {
                self.deviceWidth=DEVICE_IPHONE_35_LANDSCAPE_WIDTH;
                self.deviceHeigth=DEVICE_IPHONE_35_LANDSCAPE_HEIGHT;
                self.toolBarImageName=DEVICE_IPHONE_35_LANDSCAPE_TOOLBAR_IMAGE;
            }
        }
    } else {
        // iPad
        if ([orientation isEqualToString:@"Portrait"]) {
            self.deviceWidth=DEVICE_IPAD_PORTRAIT_WIDTH;
            self.deviceHeigth=DEVICE_IPAD_PORTRAIT_HEIGHT;
            self.toolBarImageName=DEVICE_IPAD_PORTRAIT_TOOLBAR_IMAGE;
        } else {
            self.deviceWidth=DEVICE_IPAD_LANDSCAPE_WIDTH;
            self.deviceHeigth=DEVICE_IPAD_LANDSCAPE_HEIGHT;
            self.toolBarImageName=DEVICE_IPAD_LANDSCAPE_TOOLBAR_IMAGE;
        }
    }

    // Remove views from super view
    [self removeToolBarViewFromView];
    
    // Show Tool Bar
    [self showToolBarWithImage:self.toolBarImageName autoHide:YES];
    
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

-(void)removeToolBarViewFromView
{
    for (UIView *subview in self.view.subviews) {
        if (subview.tag==9999) {
            [subview removeFromSuperview];
        }
    }
}


-(void)showToolBarWithImage:(NSString *)imageName autoHide:(BOOL)hide
{
    UIImageView *toolBarImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, -100, self.deviceWidth, 90)];
    toolBarImage.image=[UIImage imageNamed:imageName];
    toolBarImage.tag=9999;
    
    [self.view addSubview:toolBarImage];
    
    // animate to the bottom of the screen
    [UIView animateWithDuration:0.50f animations:^(void)
     // Aqui se faz a animacao
     {
         CGPoint position=CGPointMake(toolBarImage.center.x,45);
         toolBarImage.center=position;
         
     } completion:^(BOOL finished)
     //  Aqui executamos os procedimentos logo apos o termino da animacao
     {
         if (hide) {
             [UIView animateWithDuration:0.95f animations:^(void)
              // Aqui se faz a animacao
              {
                  CGPoint position=CGPointMake(toolBarImage.center.x,-100);
                  toolBarImage.center=position;
                  
              } completion:^(BOOL finished)
              //  Aqui executamos os procedimentos logo apos o termino da animacao
              {
                  // Faz nada por enquanto no completion
              }];
         }
     }];
    // FIM DA ANIMACAO
    [UIView commitAnimations];
    
    // set flag to NO
    self.toolBarIsVisible=NO;
    
}


-(void)hideToolBar
{
    for (UIView *subView in self.view.subviews) {
        if (subView.tag==9999) {
            [UIView animateWithDuration:0.95f animations:^(void)
             // Aqui se faz a animacao
             {
                 CGPoint position=CGPointMake(subView.center.x,-100);
                 subView.center=position;
                 
             } completion:^(BOOL finished)
             //  Aqui executamos os procedimentos logo apos o termino da animacao
             {
                 // Faz nada por enquanto no completion
             }];
        }
    }
    self.toolBarIsVisible=NO;
}

#pragma mark - Touch Events
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[[event allTouches]anyObject];
    CGPoint location=[touch locationInView:touch.view];
    
    // Touch must be at the top to be valid
    if (location.y>100) {
        return;
    }

    // tool bar must be hidden otherwise escape from here
    if (self.toolBarIsVisible) {
        [self hideToolBar];
        return;
    }
    // Show tool bar
    [self showToolBarWithImage:self.toolBarImageName autoHide:NO];
    self.toolBarIsVisible=YES;
}

#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
