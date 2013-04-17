//
//  CouponViewController.m
//  YueHui
//
//  Created by Lei Perry on 3/16/13.
//  Copyright (c) 2013 BitRice. All rights reserved.
//

#import "Coupon2LViewController.h"
#import "CouponCollectionViewController.h"
#import "UINavigationBar+Ext.h"
#import "UIColor+Ext.h"
#import <QuartzCore/QuartzCore.h>
#import <math.h>

//
@interface Coupon2LViewController (){
    NSMutableArray* positions;
    NSMutableArray* cards;
    
    int panDirction;
    int positionCount;

    UIScrollView* scrollView;

    Card* centerCard;
    Card* leftCard;
    Card* rightCard;

    UIPanGestureRecognizer *pan;
}

@end


@implementation Coupon2LViewController
- (void)loadView {
    [super loadView];
    positionCount = 6;

    
    // app background
    self.view.backgroundColor = [UIColor colorWithHex:0xedeae1];
    UIImage *appBg = [[UIImage imageNamed:@"app-bg"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    UIImageView *appBgView = [[UIImageView alloc] initWithImage:appBg];
    appBgView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), appBg.size.height);
    [self.view addSubview:appBgView];
    
    CGRect r = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - (85));
    scrollView=[[UIScrollView alloc] initWithFrame:r];
    [self.view addSubview:scrollView];
    scrollView.scrollEnabled = NO;
    scrollView.contentSize = r.size;
    scrollView.delegate = self;
    //
    pan = [[UIPanGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(handlePan:)] ;
    [scrollView addGestureRecognizer:pan];

    positions = [[NSMutableArray alloc] initWithCapacity:positionCount];
    cards = [[NSMutableArray alloc] initWithCapacity:positionCount];

    
    centerCard=nil;
    leftCard=nil;
    rightCard=nil;
    for (int i=0; i<positionCount; i++) {
        
        CardPosition* position = [[CardPosition alloc]init];
//        CardPosition* expandedPosition = [[CardPosition alloc]init];
        Card* card = [[Card alloc]init];

        position.positionId=i;
        if(i==0){
            position.center=CGPointMake(160,200);
            position.alpha=1;
            position.zOrder=100;
        }
        else if(i==positionCount-1){
            position.center=CGPointMake(-170,200);
            position.alpha=0.0;
            position.zOrder=100;
        }
        else{
            position.center=CGPointMake(490,200);
            position.alpha=0.0;
            position.zOrder=100;
        }
        
        if(i==0){
            centerCard=card;
        }
        if(i==1){
            rightCard=card;
        }
        if(i>2&&i==positionCount-1){
            leftCard=card;
        }

        [positions addObject:position];        

        //
        UIImage *image          = [UIImage imageNamed:[NSString stringWithFormat: @"store_c%d",i]];
        UIImageView *imageView  = [[UIImageView alloc]initWithImage:image];
        imageView.center        =  CGPointMake(160,-100);
        imageView.alpha         = position.alpha;
        
        imageView.layer.masksToBounds       = NO;
        imageView.layer.shadowRadius        = 2.0;
        imageView.layer.shadowColor         = [UIColor blackColor].CGColor;
        imageView.layer.shadowOffset        = CGSizeMake(.5, .5);
        imageView.layer.shadowOpacity       = .7f;
        imageView.layer.zPosition           = position.zOrder;
        imageView.layer.borderWidth        = 5;
        imageView.layer.borderColor        = [[UIColor whiteColor] CGColor];
        imageView.layer.shouldRasterize     =YES;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:imageView.bounds];
        imageView.layer.shadowPath = path.CGPath;
        card.cardId = imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)] ;
        
        [imageView addGestureRecognizer:tap];

        CGFloat radians = M_PI * 8+((arc4random()%5)*2) / 360.0;
        if(arc4random()%10 >6)
            radians*=-1.0f;
        
        [UIView animateWithDuration:0.2
                         animations:^{
//                             imageView.transform = transform;
                             imageView.center =  position.center;
                         }];

        card.position = position;
        card.imageView=imageView;
        [cards addObject:card];
        [scrollView addSubview:imageView];
    }

    
    [self resetGestureOrderAndTag];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setTitle:@"优惠卷"];
    
    [self becomeFirstResponder];
    
    //
    UIImage *backImage = [UIImage imageNamed:@"tab-icon-back"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, backImage.size.width, backImage.size.height);
    NSLog(@"back w %fx ,%f",backBtn.frame.size.width,backBtn.frame.origin.x);
    [backBtn setImage:backImage forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"tab-icon-back-selected"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    

}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {

    //
    //    NSLog(@"%f, %f",flyingInImageView.center.x,flyingInImageView.center.y);
    CGPoint translation = [recognizer translationInView:self.view];
    NSLog(@"%f",translation.x);
    
    if(leftCard!=nil) {
        leftCard.imageView.center = CGPointMake(leftCard.imageView.center.x + translation.x,
                                                leftCard.imageView.center.y);
        leftCard.imageView.alpha=1-abs(leftCard.imageView.center.x-160)/320.0;
    }
    if(centerCard!=nil) {
        centerCard.imageView.center = CGPointMake(centerCard.imageView.center.x + translation.x,
                                               centerCard.imageView.center.y);
        centerCard.imageView.alpha=1-abs(centerCard.imageView.center.x-160)/320.0;
    }
    if(rightCard!=nil) {
        rightCard.imageView.center = CGPointMake(rightCard.imageView.center.x + translation.x,
                                                rightCard.imageView.center.y);
        rightCard.imageView.alpha=1-abs(rightCard.imageView.center.x-160)/320.0;
    }
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    //
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [recognizer velocityInView:self.view];
        
        float s = 300/fabs(velocity.x);
        NSLog(@"centerCard.imageView.center: %f",centerCard.imageView.center.x );
        if(velocity.x>0 && (s<0.5 || centerCard.imageView.center.x>320)){
            [self moveToRight:s];
        }
        else if(velocity.x<0 && (s<0.5 || centerCard.imageView.center.x<0)){
            [self moveToLeft:s];
        }
        else{
            [self moveToCurrentPosition:s];
        }
    }

}

- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer {
}




-(void)moveToLeft:(float)animationDuration{
    for (int i=0; i<cards.count; i++) {
        Card* card=[cards objectAtIndex:i];
        int newInx =(card.position.positionId-1);
        if(newInx<0)newInx = positions.count-1;
        card.position = [positions objectAtIndex:newInx];
    }
    [self reset3TopCards];

    [self moveToCurrentPosition:animationDuration];

}


-(void)moveToRight:(float)animationDuration{
    for (int i=0; i<cards.count; i++) {
        Card* card=[cards objectAtIndex:i];
        int newInx =(card.position.positionId+1)%positionCount;
        //        if(newInx<0)newInx = positions.count-1;
        card.position = [positions objectAtIndex:newInx];
    }
    [self reset3TopCards];
    [self moveToCurrentPosition:animationDuration];
}

-(void)reset3TopCards{
    for (int i=0; i<cards.count; i++) {
        Card* card=[cards objectAtIndex:i];
        
        if(card.position.positionId==0){
            centerCard=card;
        }
        if(card.position.positionId==1){
            rightCard=card;
        }
        if(card.position.positionId>2
           &&card.position.positionId==positionCount-1){
            leftCard=card;
        }
    }

}

-(void)moveToCurrentPosition:(float)animationDuration{
    [UIView animateWithDuration:(animationDuration>0.7) ? 0.7 : animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         for (int i=0; i<cards.count; i++) {
                             Card* card=[cards objectAtIndex:i];
                             if(card.position.center.x != card.imageView.center.x
                                ||card.position.center.y != card.imageView.center.y)
                             {
                                 card.imageView.center = card.position.center;
                                 card.imageView.alpha = card.position.alpha;
                                 card.imageView.layer.zPosition = card.position.zOrder;
                             }
                         }
//                         
//                         if(isExpanded)
//                             handleImageView.alpha=0;
//                         else
//                             handleImageView.alpha=1;
                     }
                     completion:nil];
    [self resetGestureOrderAndTag];
}


- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:[self view]];
    NSLog(@"tap - start location: %f,%f", point.x, point.y);
    NSLog(@"tag: %d", recognizer.view.tag);
//    if(isExpanded){
//        [self moveToContract:0.3 newTopCardId:recognizer.view.tag];
//    }
}

//BOOL isExpandedToBottom = NO;
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView;
{
    //    NSLog(@" scrollViewDidScroll");
NSLog(@"ContentOffset  x is  %f,yis %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
//    if(scrollView.contentOffset.y >= 407){
//        pan.enabled = YES;
////        isExpandedToBottom=YES;
//    }
}


-(void)resetGestureOrderAndTag {
    for (int i=positionCount-1; i>=0; i--) {
        Card* card = [cards objectAtIndex:(centerCard.cardId+i)%positionCount];
        [scrollView bringSubviewToFront:card.imageView];
    }
//    [scrollView bringSubviewToFront:handleImageView];
}



-(void)backAction{
    //    LoginViewController *controller = [[LoginViewController alloc] init];
    [self.navigationController popViewControllerAnimated:YES];
}

@end

