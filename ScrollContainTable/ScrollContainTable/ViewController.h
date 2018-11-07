//
//  ViewController.h
//  ScrollContainTable
//
//  Created by RLY on 2018/11/6.
//  Copyright © 2018年 RLY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIScrollView *containerScrollView;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIView *header;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutContainerScrollViewHeight;

@end

@interface EGOScrollView: UIScrollView <UIGestureRecognizerDelegate>

@end

@interface EGOTableHeaderView: UIView

- (void)scrollViewDidScroll:(CGFloat)contentOffsetY;

@end


