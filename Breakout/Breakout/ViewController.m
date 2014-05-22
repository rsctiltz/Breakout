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
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.ballView] mode:UIPushBehaviorModeInstantaneous];
    self.pushBehavior.pushDirection = CGVectorMake(0.5,1.0);
    self.pushBehavior.active = YES;
    self.pushBehavior.magnitude = 0.2;
    [self.dynamicAnimator addBehavior:self.pushBehavior];

    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.ballView, self.paddleView, self.blockView]];
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

    self.blockViewDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.blockView]];
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
-(void) collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p;
{

}

@end
