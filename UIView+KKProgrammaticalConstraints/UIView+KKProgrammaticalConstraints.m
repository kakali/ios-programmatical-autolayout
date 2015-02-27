//
//  UIView+KKProgrammaticalConstraints.m
//
//  Created by Katarzyna Kalinowska-Górska on 24.02.2015.
//  Copyright (c) 2015 Katarzyna Kalinowska-Górska. All rights reserved.
//

#import "UIView+KKProgrammaticalConstraints.h"
#import <objc/runtime.h>

@implementation UIView (KKProgrammaticalConstraints)

static char* kk_constraintsSelf_Key = "constraintsSelf_Key";
static char* kk_constraintsSuperview_Key = "constraintsSuperview_Key";

- (NSMutableDictionary*)kk_ConstraintsSelf {
    return objc_getAssociatedObject(self, kk_constraintsSelf_Key);
}

- (NSMutableDictionary*)kk_ConstraintsSuperview {
    return objc_getAssociatedObject(self, kk_constraintsSuperview_Key);
}

- (void)kk_storeConstraintSelf:(NSLayoutConstraint *)constraint forSize:(KKUserInterfaceSize*)size {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        objc_setAssociatedObject(self, kk_constraintsSelf_Key, [NSMutableDictionary dictionary], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    });
    [self kk_storeConstraint:constraint forSize:size inStorage:self.kk_ConstraintsSelf];
}

- (void)kk_storeConstraintsSelf:(NSArray *)constraints forSize:(KKUserInterfaceSize*)size {
    for(NSLayoutConstraint* constraint in constraints)
        [self kk_storeConstraintSelf:constraint forSize:size];
}

- (void)kk_removeStoredConstraintSelf:(NSLayoutConstraint *)constraint forSize:(KKUserInterfaceSize*)size {
    [self kk_removeStoredConstraint:constraint forSize:size fromStorage:self.kk_ConstraintsSelf];
}

- (void)kk_storeConstraintSuperview:(NSLayoutConstraint *)constraint forSize:(KKUserInterfaceSize*)size {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        objc_setAssociatedObject(self, kk_constraintsSuperview_Key, [NSMutableDictionary dictionary], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    });
    [self kk_storeConstraint:constraint forSize:size inStorage:self.kk_ConstraintsSuperview];
}

- (void)kk_storeConstraintsSuperview:(NSArray *)constraints forSize:(KKUserInterfaceSize*)size {
    for (NSLayoutConstraint* constraint in constraints)
        [self kk_storeConstraintSuperview:constraint forSize:size];
}

- (void)kk_removeStoredConstraintSuperview:(NSLayoutConstraint *)constraint forSize:(KKUserInterfaceSize*)size {
    [self kk_removeStoredConstraint:constraint forSize:size fromStorage:self.kk_ConstraintsSuperview];
}

- (void)kk_storeConstraint: (NSLayoutConstraint*)constraint forSize:(KKUserInterfaceSize*)size inStorage:(NSMutableDictionary*)storage {
    
    NSArray* constraints = [storage objectForKey:size];
    if(constraints == nil) {
        [storage setObject:[NSArray arrayWithObject:constraint] forKey:size];
    } else {
        NSMutableArray* tempArray = [NSMutableArray arrayWithArray:constraints];
        [tempArray addObject:constraint];
        [storage setObject:tempArray forKey:size];
    }
}

- (void)kk_removeStoredConstraint: (NSLayoutConstraint*)constraint forSize:(KKUserInterfaceSize*)size fromStorage:(NSMutableDictionary*)storage {
    NSArray* constraints = [storage objectForKey:size];
    if(constraints != nil) {
        NSMutableArray* tempArray = [NSMutableArray arrayWithArray:constraints];
        [tempArray removeObject:constraint];
        [storage setObject:tempArray forKey:size];
    }
}

- (void)kk_switchToConstraintsForHorizontalSizeClass: (UIUserInterfaceSizeClass) horizontalSizeClass verticalSizeClass: (UIUserInterfaceSizeClass) verticalSizeClass {
    
    // deactivate everything
    for (KKUserInterfaceSize* key in self.kk_ConstraintsSelf)
        [NSLayoutConstraint deactivateConstraints:(NSArray*)[self.kk_ConstraintsSelf objectForKey:key]];

    for (KKUserInterfaceSize* key in self.kk_ConstraintsSuperview)
        [NSLayoutConstraint deactivateConstraints:(NSArray*)[self.kk_ConstraintsSuperview objectForKey:key]];
    
    // activate h=any and v=any
    [self kk_activateConstraintsForSize:[KKUserInterfaceSize sizeWithHorizontalSizeClass:UIUserInterfaceSizeClassUnspecified verticalSizeClass:UIUserInterfaceSizeClassUnspecified]];

    
    if(horizontalSizeClass == UIUserInterfaceSizeClassRegular){
        
        // activate h=regular and v=any
        [self kk_activateConstraintsForSize:[KKUserInterfaceSize sizeWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular verticalSizeClass:UIUserInterfaceSizeClassUnspecified]];
        
        if(verticalSizeClass == UIUserInterfaceSizeClassRegular){
            // activate h=regular and v=regular
            [self kk_activateConstraintsForSize:[KKUserInterfaceSize sizeWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular verticalSizeClass:UIUserInterfaceSizeClassRegular]];
            //activate h=any and v=regular
            [self kk_activateConstraintsForSize:[KKUserInterfaceSize sizeWithHorizontalSizeClass:UIUserInterfaceSizeClassUnspecified verticalSizeClass:UIUserInterfaceSizeClassRegular]];
        } else if(verticalSizeClass == UIUserInterfaceSizeClassCompact){
            //activate h=regular and v=compact
            [self kk_activateConstraintsForSize:[KKUserInterfaceSize sizeWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular verticalSizeClass:UIUserInterfaceSizeClassCompact]];
            //activate h=any and v=compact
            [self kk_activateConstraintsForSize:[KKUserInterfaceSize sizeWithHorizontalSizeClass:UIUserInterfaceSizeClassUnspecified verticalSizeClass:UIUserInterfaceSizeClassCompact]];
        }
        
    } else if(horizontalSizeClass == UIUserInterfaceSizeClassCompact){
        
        //activate h=compact and v=any
        [self kk_activateConstraintsForSize:[KKUserInterfaceSize sizeWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact verticalSizeClass:UIUserInterfaceSizeClassUnspecified]];
        
        if(verticalSizeClass == UIUserInterfaceSizeClassRegular){
            //activate h=compact and v=regular
            [self kk_activateConstraintsForSize:[KKUserInterfaceSize sizeWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact verticalSizeClass:UIUserInterfaceSizeClassRegular]];
            //activate h=any and v=regular
             [self kk_activateConstraintsForSize:[KKUserInterfaceSize sizeWithHorizontalSizeClass:UIUserInterfaceSizeClassUnspecified verticalSizeClass:UIUserInterfaceSizeClassRegular]];
        } else if(verticalSizeClass == UIUserInterfaceSizeClassCompact){
            //activate h=compact and v=compact
             [self kk_activateConstraintsForSize:[KKUserInterfaceSize sizeWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact verticalSizeClass:UIUserInterfaceSizeClassCompact]];
            //activate h=any and v=compact
             [self kk_activateConstraintsForSize:[KKUserInterfaceSize sizeWithHorizontalSizeClass:UIUserInterfaceSizeClassUnspecified verticalSizeClass:UIUserInterfaceSizeClassCompact]];
        }
    } else { //if(horizontalSizeClass == UIUserInterfaceSizeClassUnspecified)
        
        if(verticalSizeClass == UIUserInterfaceSizeClassRegular){
            //activate h=any and v=regular
            [self kk_activateConstraintsForSize:[KKUserInterfaceSize sizeWithHorizontalSizeClass:UIUserInterfaceSizeClassUnspecified verticalSizeClass:UIUserInterfaceSizeClassRegular]];
        } else if(verticalSizeClass == UIUserInterfaceSizeClassCompact){
            //activate h=any and v=compact
            [self kk_activateConstraintsForSize:[KKUserInterfaceSize sizeWithHorizontalSizeClass:UIUserInterfaceSizeClassUnspecified verticalSizeClass:UIUserInterfaceSizeClassCompact]];
        }
    }
    
}

- (void)kk_activateConstraintsForSize:(KKUserInterfaceSize*)size {
    NSArray* tempConstraints = [self.kk_ConstraintsSelf objectForKey:size];
    if(tempConstraints != nil)
        [NSLayoutConstraint activateConstraints:tempConstraints];
    tempConstraints = [self.kk_ConstraintsSuperview objectForKey:size];
    if (tempConstraints != nil) {
        [NSLayoutConstraint activateConstraints:tempConstraints];
    }
}

- (void)kk_applyStoredConstraints {
    
    // add to self and to superview
    for (KKUserInterfaceSize* key in self.kk_ConstraintsSelf)
        [self addConstraints:[self.kk_ConstraintsSelf objectForKey:key]];
    
    for (KKUserInterfaceSize* key in self.kk_ConstraintsSuperview)
        [self.superview addConstraints:[self.kk_ConstraintsSuperview objectForKey:key]];
    
    // activate
    [self kk_switchToConstraintsForHorizontalSizeClass:self.traitCollection.horizontalSizeClass verticalSizeClass:self.traitCollection.verticalSizeClass];
}

@end

