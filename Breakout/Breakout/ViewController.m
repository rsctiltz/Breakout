//
//  ViewController.m
//  Breakout
//
//  Created by Ryan Tiltz on 5/22/14.
//  Copyright (c) 2014 Ryan Tiltz. All rights reserved.
//

#import "ViewController.h"
#import "PaddleView.h"
#import "BallView.h"
#import "BlockView.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet PaddleView *paddleView;
@property UIDynamicAnimator *dynamicAnimator;
@property (strong, nonatomic) IBOutlet BallView *ballView;
@property UIPushBehavior *pushBehavior;
@property UICollisionBehavior *collisionBehavior;
@property UIDynamicItemBehavior *paddleDynamicBehavior;
@property UIDynamicItemBehavior *ballDynamicBehavior;
@property UIDynamicItemBehavior *blockViewDynamicBehavior;
@property (strong, nonatomic) IBOutlet BlockView *blockView;
@property NSMutableArray *blocks;
@property (strong, nonatomic) IBOutlet BlockView *blockView2;
@property (strong, nonatomic) IBOutlet BlockView *blockView3;
@property (strong, nonatomic) IBOutlet BlockView *blockView4;
@property (strong, nonatomic) IBOutlet BlockView *blockView5;
@property (strong, nonatomic) IBOutlet BlockView *blockView6;
@property (strong, nonatomic) IBOutlet BlockView *blockView7;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.ballView] mode:UIPushBehaviorModeInstantaneous];
    self.pushBehavior.pushDirection = CGVectorMake(0.5,1.0);
    self.pushBehavior.active = YES;
    self.pushBehavior.magnitude = 0.1;
    [self.dynamicAnimator addBehavior:self.pushBehavior];

    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.ballView, self.paddleView, self.blockView, self.blockView2, self.blockView3, self.blockView4, self.blockView5, self.blockView6, self.blockView7]];
    self.collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    self.collisionBehavior.collisionDelegate = self;
    [self.dynamicAnimator addBehavior:self.collisionBehavior];

    self.paddleDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.paddleView]];
    self.paddleDynamicBehavior.allowsRotation = NO;
    self.paddleDynamicBehavior.density = 1000;
    [self.dynamicAnimator addBehavior:self.paddleDynamicBehavior];

    self.ballDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.ballView]];
    self.ballDynamicBehavior.allowsRotation = NO;
    self.ballDynamicBehavior.elasticity = 1.0;
    self.ballDynamicBehavior.friction = 0.0;
    self.ballDynamicBehavior.resistance = 0.0;
    [self.dynamicAnimator addBehavior:self.ballDynamicBehavior];

    self.blockViewDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.blockView, self.blockView2, self.blockView3, self.blockView4, self.blockView5, self.blockView6, self.blockView7]];
    self.blockViewDynamicBehavior.allowsRotation = NO;
    self.blockViewDynamicBehavior.density = 1000;
    [self.dynamicAnimator addBehavior:self.blockViewDynamicBehavior];
}
- (IBAction)dragPaddle:(UIPanGestureRecognizer *)panGestureRecognizer

{
    self.paddleView.center = CGPointMake([panGestureRecognizer locationInView:self.view].x, self.paddleView.center.y);
    [self.dynamicAnimator updateItemUsingCurrentState:self.paddleView];
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p;

{
    if (self.ballView.center.y > 548){
        self.ballView.center = self.view.center;
}
    [self.dynamicAnimator updateItemUsingCurrentState:self.ballView];
}
-(void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2
{
    //BlockView* block =  (BlockView*)item2;
    if ([item2 isKindOfClass:[BlockView class]])
    {
        [UIView animateWithDuration:0.0 animations:^{
            //block.backgroundColor = [UIColor orangeColor];
            //NSLog(@"animating");
        } completion:^(BOOL finished) {
            //[(BlockView*)item2 setBackgroundColor:[UIColor orangeColor]];
            [self.collisionBehavior removeItem:item2];
            [self.blocks removeObject:(BlockView*)item2];
            //you can only remove a view from itʻs Superview
            [(BlockView*)item2 removeFromSuperview];
            [self.dynamicAnimator updateItemUsingCurrentState:item2];}];
        
    }
}
@end
