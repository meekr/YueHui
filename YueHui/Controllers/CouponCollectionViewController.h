//
//  CouponViewController.h
//  YueHui
//
//  Created by Lei Perry on 3/16/13.
//  Copyright (c) 2013 BitRice. All rights reserved.
//

@interface CouponCollectionViewController : UIViewController<UIScrollViewDelegate>{

    
    NSMutableArray* imageViews;
    int backZ;
    int frontZ;
    int stack;
    int imageHeight;
    UIScrollView* scrollView;
    UIImageView *handleImageView;
    
    CGPoint lastGestureVelocity;
    CGPoint startGestureVelocity;
    int panDirction;
    CGPoint origanPoint;
    UIImageView* topImageView;
    
    BOOL isExpanded;
    BOOL isAnimating;
    int height;

}

@end