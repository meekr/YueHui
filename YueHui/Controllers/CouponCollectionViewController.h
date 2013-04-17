//
//  CouponViewController.h
//  YueHui
//
//  Created by Lei Perry on 3/16/13.
//  Copyright (c) 2013 BitRice. All rights reserved.
//

@interface CouponCollectionViewController : UIViewController<UIScrollViewDelegate>{

}

@end

//====================

@interface CardPosition: NSObject{
    
}
@property int positionId;
@property(nonatomic)CGPoint center;
@property float alpha;
@property int zOrder;
@end


//====================

@interface Card: NSObject{
    
}
@property(nonatomic)int cardId;
@property(nonatomic)UIImageView* imageView;
@property CardPosition* position;
@end

