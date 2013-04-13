//
//  CouponViewController.m
//  YueHui
//
//  Created by Lei Perry on 3/16/13.
//  Copyright (c) 2013 BitRice. All rights reserved.
//

#import "CouponCollectionViewController.h"
#import "UINavigationBar+Ext.h"
#import "UIColor+Ext.h"
#import <QuartzCore/QuartzCore.h>
#import <math.h>


/*
 
 */
@interface CardPosition: NSObject{
    
}
@property int positionId;
@property(nonatomic)CGPoint center;
@property float alpha;
@property int zOrder;
@end

@implementation CardPosition
- (id) init
{
	if((self = [super init])) {
        self.alpha=0;
        self.zOrder = 0;
	}
	
	return self;
}

@end


//
@interface Card: NSObject{
    
}
@property(nonatomic)int cardId;
@property(nonatomic)UIImageView* imageView;
@property CardPosition* position;
@end

@implementation Card
- (id) init
{
	if((self = [super init])) {
        self.imageView=nil;
        self.position = nil;
	}
	
	return self;
}

@end


//
@interface CouponCollectionViewController (){
    NSMutableArray* imageViews;
    NSMutableArray* positions;
    NSMutableArray* expandedPositions;
    NSMutableArray* cards;
    
    int backZ;
    int frontZ;
    int stackCount;
    int positionCount;
    int visbleCardCount;
    int imageHeight;
    UIScrollView* scrollView;
    UIImageView *handleImageView;
    
    CGPoint lastGestureVelocity;
    CGPoint startGestureVelocity;
    int panDirction;
    CGPoint origanPoint;
    UIImageView* topImageView;
    Card* topCard;
    Card* swapCard;
    
    BOOL isExpanded;
//    BOOL isAnimating;
    int expandedDivHeight;

    UIPanGestureRecognizer *pan;
}
- (void)handleLeftPan:(UIPanGestureRecognizer *)recognizer ;
- (void)handleRightPan:(UIPanGestureRecognizer *)recognizer ;
- (void)handleDownPan:(UIPanGestureRecognizer *)recognizer ;

@end


@implementation CouponCollectionViewController


- (void)loadView {
    [super loadView];
    
    // init vars    
    backZ=0;
    frontZ=1;
    stackCount=6;
    positionCount = 6;
    visbleCardCount = 3;
    imageHeight = 292;
    
    isExpanded = NO;
//    isAnimating = NO;
    expandedDivHeight = 98;

    // app background
    self.view.backgroundColor = [UIColor colorWithHex:0xedeae1];
    UIImage *appBg = [[UIImage imageNamed:@"app-bg"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    UIImageView *appBgView = [[UIImageView alloc] initWithImage:appBg];
    appBgView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), appBg.size.height);
    [self.view addSubview:appBgView];
    
    CGRect r = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - (85));
    scrollView=[[UIScrollView alloc] initWithFrame:r];
    [self.view addSubview:scrollView];
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(r.size.width, imageHeight+(positionCount-1)*expandedDivHeight);
    scrollView.delegate = self;
    //
    pan = [[UIPanGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(handlePan:)] ;
    [scrollView addGestureRecognizer:pan];
    UIPinchGestureRecognizer* pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)] ;
    [scrollView addGestureRecognizer:pinch];
    
    //
    positions = [[NSMutableArray alloc] initWithCapacity:positionCount];
    expandedPositions = [[NSMutableArray alloc] initWithCapacity:positionCount];
    cards = [[NSMutableArray alloc] initWithCapacity:positionCount];
    
    //init positions and cards
    //0 is top
    for (int i=0; i<positionCount; i++) {
        
        CardPosition* position = [[CardPosition alloc]init];
        CardPosition* expandedPosition = [[CardPosition alloc]init];
        Card* card = [[Card alloc]init];

        position.positionId=i;
        if(i<visbleCardCount){
            position.center=CGPointMake(160,200-i*5);
            position.alpha=1;
            position.zOrder=100+positionCount-i;
        }
        else if(i<positionCount-1){//unvisible positions
            position.center=CGPointMake(160,200-i*5);
            position.alpha=0;
            position.zOrder=100-1;
        }
        else{//swap position
            position.center=CGPointMake(-100,200);
            position.alpha=0;
            position.zOrder=100+positionCount+1;
            swapCard = card;
        }
        if(i==0){
            topCard=card;
        }
        [positions addObject:position];

        expandedPosition.positionId = i;
        expandedPosition.alpha=1;
        expandedPosition.zOrder=100+positionCount-i;
        expandedPosition.center=CGPointMake(160,
                                             imageHeight/2
                                             +positionCount*expandedDivHeight*(stackCount-(i+1))/stackCount);
        [expandedPositions addObject:expandedPosition];
        

        //
        UIImage *image          = [UIImage imageNamed:[NSString stringWithFormat: @"store_b%d",i]];
        UIImageView *imageView  = [[UIImageView alloc]initWithImage:image];
        imageView.center        =  CGPointMake(160,200);
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

        CGFloat radians = M_PI * 8+(i*2) / 360.0;
        if(arc4random()%10 >6)
            radians*=-1.0f;
        CGAffineTransform transform = CGAffineTransformMakeRotation(radians);
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             imageView.transform = transform;
                             imageView.center =  position.center;
                         }];

        card.position = position;
        card.imageView=imageView;
        [cards addObject:card];
        [scrollView addSubview:imageView];
    }

    
//    imageViews = [[NSMutableArray alloc] initWithCapacity:stackCount];
//
//    topImageView= (UIImageView*)[imageViews objectAtIndex:0];
//    origanPoint = ((UIImageView*)[imageViews objectAtIndex:0]).center;

    [self resetGestureOrderAndTag];
    
    UIImage *handleImage = [UIImage imageNamed:[NSString stringWithFormat: @"handle"]];
    handleImageView = [[UIImageView alloc]initWithImage:handleImage];
    handleImageView.center =  CGPointMake(160,0);
    handleImageView.alpha=0;
    [scrollView addSubview:handleImageView];
    [UIView animateWithDuration:0.3
                     animations:^{
                         handleImageView.center =  CGPointMake(160,35-visbleCardCount*2.5);
                         handleImageView.alpha = 1;
                     }];
    
    UITapGestureRecognizer *handleTapG =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapHandle:)];
    handleImageView.userInteractionEnabled = YES;
    [handleImageView addGestureRecognizer:handleTapG];
    handleImageView.layer.zPosition=999999;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setTitle:@"我的优惠券"];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint velocity2 = [recognizer velocityInView:self.view];
    //    NSLog(@"pan velocity2: %f,%f", velocity2.x, velocity2.y);
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"pad began");
        
        if(velocity2.y<0&& fabs(velocity2.y)>fabs(velocity2.x*2)){
            NSLog(@"to up");
            panDirction = 0;
        }
        else if(velocity2.y>0&& fabs(velocity2.y)>fabs(velocity2.x*2)){
            NSLog(@"to down");
            panDirction = 2;
        }
        else if(velocity2.x<0 ){
            NSLog(@"to left");
            panDirction = 3;
        }
        else {//(velocity2.x>0&& fabs(velocity2.x)>fabs(velocity2.y*2))
            NSLog(@"to right");
            panDirction = 1;
        }
        startGestureVelocity = velocity2;
    }
    
    //    NSLog(@"pan location: %f,%f", translation.x, translation.y);
    
    if(panDirction==3){
        [self handleLeftPan:recognizer];
    }
    if(panDirction==1){
        [self handleRightPan:recognizer];
    }
    if(panDirction==2 || panDirction==0){
        [self handleDownPan:recognizer];
    }
}

- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer {
    CardPosition* topPosition = [positions objectAtIndex:0];
    switch (recognizer.state) {
		case UIGestureRecognizerStateBegan:
		case UIGestureRecognizerStateChanged:
		{
            float factor = recognizer.scale - 1;
            if(isExpanded==NO){
                break;
            }
            
            if(factor > 0)
                factor=0;
            else if(factor <-3){
                factor=-3;
            }
            NSLog(@" %f",factor);
            //                float y = topCard.imageView.center.y + recognizer.scale*10;
            //                NSLog(@"%f, %f",topPosition.center.y, y);
            CardPosition* expandedTopPosition = [expandedPositions objectAtIndex:0];
            CGPoint target=CGPointMake(topCard.position.center.x,
                                       scrollView.contentOffset.y
                                       +scrollView.bounds.size.height/2);
            NSLog(@"target.y: %f",target.y);
            for (int i=0; i<positionCount; i++) {
                Card* card = [cards objectAtIndex:(topCard.cardId+i)%positionCount];
                card.imageView.center = CGPointMake(card.imageView.center.x,
                                                    card.position.center.y
                                                    - (target.y - card.position.center.y)*factor);
            
                NSLog(@"%i, imageView: %f, %f",i, card.imageView.center.y,factor);
                NSLog(@"%f",card.position.center.y-target.y);
            }
            
            break;
        }
        case UIGestureRecognizerStateEnded:
		{
            if(isExpanded==NO)return;
            
            NSLog(@"%f",topPosition.center.y-topCard.imageView.center.y<10);
            float s = 300/recognizer.velocity;
            if(recognizer.velocity<0
               && (s<0.7 || topPosition.center.y-topCard.imageView.center.y<10)){
                [self moveToContract:0.2 newTopCardId:topCard.cardId];
            }
            else{
                [self moveToExpanded:s];
            }        

            break;
        }
        default:
            break;
    }
}


//UIImageView* flyingImageView;
- (void)handleLeftPan:(UIPanGestureRecognizer *)recognizer
{
//    if(isExpanded) return;
    
    CGPoint translation = [recognizer translationInView:self.view];
    NSLog(@"transloation.x: %f",translation.x);
    NSLog(@"tag:%d",topImageView.tag);
    
    topCard.imageView.center = CGPointMake(topCard.imageView.center.x + translation.x,
                                           topCard.imageView.center.y + 0);
    
    NSLog(@"x:%f",    topCard.imageView.center.x);
    CardPosition* topPosition = (CardPosition*)[positions objectAtIndex:0];
    if (topCard.imageView.center.x>topPosition.center.x) {
        topCard.imageView.center=CGPointMake(topPosition.center.x, topPosition.center.y);
    }
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    //
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        
        float s = 300/fabs(velocity.x);
        if(s<0.7 && velocity.x<0){
            [self moveToNext:s];
        }
        else{
            [self moveToCurrentPosition:s];
        }        

//        NSLog(@"s: %f, vel x: %f",s,velocity.x);

    }
}


- (void)handleRightPan:(UIPanGestureRecognizer *)recognizer {
    if(isExpanded) return;
    
    //    NSLog(@"%f, %f",flyingInImageView.center.x,flyingInImageView.center.y);
    CGPoint translation = [recognizer translationInView:self.view];
    NSLog(@"%f",translation.x);
    
    swapCard.imageView.alpha=1;
        swapCard.imageView.center = CGPointMake(swapCard.imageView.center.x + translation.x,
                                           swapCard.imageView.center.y + 0);

    
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    //
    if (recognizer.state == UIGestureRecognizerStateEnded) {

        CGPoint velocity = [recognizer velocityInView:self.view];
        
        float s = 300/fabs(velocity.x);
        if(s<0.7 && velocity.x>0){
            [self moveToPrevious:s];
        }
        else{
            [self moveToCurrentPosition:s];
        }
    }
}


-(void)moveToNext:(float)animationDuration{
    for (int i=0; i<cards.count; i++) {
        Card* card=[cards objectAtIndex:i];
        int newInx =(card.position.positionId-1);
        if(newInx<0)newInx = positions.count-1;
        card.position = [positions objectAtIndex:newInx];
        
        if(newInx==0)topCard=card;
        else if(newInx==positions.count-1)swapCard=card;
    }
    [self moveToCurrentPosition:animationDuration];

}


-(void)moveToPrevious:(float)animationDuration{
    for (int i=0; i<cards.count; i++) {
        Card* card=[cards objectAtIndex:i];
        int newInx =(card.position.positionId+1)%positions.count;
        card.position = [positions objectAtIndex:newInx];
        
        if(newInx==0)topCard=card;
        else if(newInx==positions.count-1)swapCard=card;
    }
    [self moveToCurrentPosition:animationDuration];
    
}

-(void)moveToExpanded:(float)animationDuration{
    for (int i=0; i<cards.count; i++) {
        Card* card=[cards objectAtIndex:i];
        card.position = [expandedPositions objectAtIndex:card.position.positionId];
    }
    isExpanded=YES;
    pan.enabled = NO;
    [self moveToCurrentPosition:animationDuration];
}

-(void)moveToContract:(float)animationDuration newTopCardId:(int)cardId{
    for (int i=0; i<cards.count; i++) {
        Card* card=[cards objectAtIndex:(cardId + i)%positionCount];
        card.position = [positions objectAtIndex:i];
        
        if(i==0)topCard=card;
        else if(i==positions.count-1)swapCard=card;
    }
    isExpanded=NO;
    [self moveToCurrentPosition:0.3];
    [scrollView scrollRectToVisible:CGRectMake(0, 0, 10, 10) animated:YES];
    
    pan.enabled = YES;
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
                         
                         if(isExpanded)
                             handleImageView.alpha=0;
                         else
                             handleImageView.alpha=1;
                     }
                     completion:nil];
    [self resetGestureOrderAndTag];
}

- (void)handleDownPan:(UIPanGestureRecognizer *)recognizer {
//    if(isAnimating) return;

    if(handleImageView.alpha>0){
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [handleImageView setAlpha:0];
                     }
                     completion:nil];
    }
    
    CGPoint translation = [recognizer translationInView:self.view];
        
    CardPosition* topPosition = [positions objectAtIndex:0];
    float y = topCard.imageView.center.y + translation.y;
    NSLog(@"%f, %f",topPosition.center.y, y);

    if(y > topPosition.center.y)
    {
        for (int i=0; i<positionCount; i++) {
            
            Card* card = [cards objectAtIndex:(topCard.cardId+i)%positionCount];
            card.imageView.center = CGPointMake(card.imageView.center.x,
                                                 card.imageView.center.y
                                                +translation.y*(visbleCardCount-i)/visbleCardCount);
        }
    }
//    if(isExpanded){
//        UIImageView* m = (UIImageView*)[imageViews objectAtIndex:0];
//        [scrollView scrollRectToVisible:CGRectMake(0, m.center.y-imageHeight/2-20, 10, 10) animated:NO];
//    }
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        float s = 300/fabs(velocity.y);
        
        if(s<0.7 && velocity.y>0){
            [self moveToExpanded:s];
        }
        else{
            [self moveToCurrentPosition:s];
        }
        
    }
}


- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:[self view]];
    NSLog(@"tap - start location: %f,%f", point.x, point.y);
    NSLog(@"tag: %d", recognizer.view.tag);
    if(isExpanded){
        [self moveToContract:0.3 newTopCardId:recognizer.view.tag];
    }
}

- (void)handleTapHandle:(UISwipeGestureRecognizer *)recognizer
{
    NSLog(@"tap handle.");
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [handleImageView setAlpha:0];
                     }
                     completion:nil];

    [self moveToExpanded:0.3];
//    isAnimating=YES;
//    [UIView animateWithDuration:0.5
//                          delay:0
//                        options:UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         //                             flyingInImageView.center = finalPoint;
//                         for (int i=0; i<stackCount; i++) {
//                             UIImageView* m = (UIImageView*)[imageViews objectAtIndex:i];
//                             m.center = CGPointMake(m.center.x,
//                                                    imageHeight/2+stackCount*height*(stackCount-(i+1))/stackCount);
//                             NSLog(@"m.y:%f",m.center.y);
//                         }
//                         [handleImageView setAlpha:0];
//                     }
//                     completion:^(BOOL b){
//                         [self setExpandedToTrue];
////                         isAnimating=NO;
//                         [self resetGestureOrderAndTag];
//                     }
//
//     ];
//
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
        Card* card = [cards objectAtIndex:(topCard.cardId+i)%positionCount];
        [scrollView bringSubviewToFront:card.imageView];
    }
    [scrollView bringSubviewToFront:handleImageView];
}

@end

