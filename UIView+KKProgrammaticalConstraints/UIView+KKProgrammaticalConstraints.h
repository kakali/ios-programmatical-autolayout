//
//  UIView+KKProgrammaticalConstraints.h
//
//  Created by Katarzyna Kalinowska-Górska on 24.02.2015.
//  Copyright (c) 2015 Katarzyna Kalinowska-Górska. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKUserInterfaceSize.h"

@interface UIView (KKProgrammaticalConstraints)

@property(readonly,nonatomic) NSMutableDictionary* kk_ConstraintsSelf;
@property(readonly,nonatomic) NSMutableDictionary* kk_ConstraintsSuperview;

- (void)kk_storeConstraintSelf:(NSLayoutConstraint *)constraint forSize:(KKUserInterfaceSize*)size;

- (void)kk_storeConstraintsSelf:(NSArray *)constraints forSize:(KKUserInterfaceSize*)size;

- (void)kk_storeConstraintSuperview:(NSLayoutConstraint *)constraint forSize:(KKUserInterfaceSize*)size;

- (void)kk_storeConstraintsSuperview:(NSArray *)constraints forSize:(KKUserInterfaceSize*)size;

- (void)kk_removeStoredConstraintSelf:(NSLayoutConstraint *)constraint forSize:(KKUserInterfaceSize*)size;

- (void)kk_removeStoredConstraintSuperview:(NSLayoutConstraint *)constraint forSize:(KKUserInterfaceSize*)size;

// Add all stored constraints and activate those intended for the current size class. Should be called after attaching to the superview.
- (void)kk_applyStoredConstraints;

// Activate appropriate constraints and deactivate others. Use when current traits change, e.g. when rotating an iPhone.
- (void)kk_switchToConstraintsForHorizontalSizeClass: (UIUserInterfaceSizeClass) horizontalSizeClass verticalSizeClass: (UIUserInterfaceSizeClass) verticalSizeClass;

@end
