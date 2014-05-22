//
//  ViewController.h
//  Breakout
//
//  Created by Ryan Tiltz on 5/22/14.
//  Copyright (c) 2014 Ryan Tiltz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollisionBehaviorDelegate>
-(void) collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p;
-(void) collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p;
@end
