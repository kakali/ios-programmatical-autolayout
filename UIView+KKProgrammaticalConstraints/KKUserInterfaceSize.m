//
//  KKUserInterfaceSize.m
//
//  Created by Katarzyna Kalinowska-Górska on 27.02.2015.
//  Copyright (c) 2015 Katarzyna Kalinowska-Górska. All rights reserved.
//

#import "KKUserInterfaceSize.h"


@implementation KKUserInterfaceSize

+ (KKUserInterfaceSize*)sizeWithHorizontalSizeClass:(UIUserInterfaceSizeClass)horizontalSizeClass verticalSizeClass:(UIUserInterfaceSizeClass)verticalSizeClass {
    return [[KKUserInterfaceSize alloc]initWithHorizontalSizeClass:horizontalSizeClass verticalSizeClass:verticalSizeClass];
}

- (id)initWithHorizontalSizeClass:(UIUserInterfaceSizeClass)horizontalSizeClass verticalSizeClass:(UIUserInterfaceSizeClass)verticalSizeClass {
    self = [super init];
    if (self) {
        _horizontalSizeClass = horizontalSizeClass;
        _verticalSizeClass = verticalSizeClass;
    }
    return self;
}

- (id)copyWithZone:(NSZone*)zone {
    
    KKUserInterfaceSize* copy = [[[self class] allocWithZone:zone]init];
    copy.horizontalSizeClass = self.horizontalSizeClass;
    copy.verticalSizeClass = self.verticalSizeClass;
    return copy;
}

- (BOOL)isEqual:(id)object {
    if (self.horizontalSizeClass == ((KKUserInterfaceSize*)object).horizontalSizeClass && self.verticalSizeClass == ((KKUserInterfaceSize*)object).verticalSizeClass) {
        return YES;
    }
    return NO;
}

- (NSUInteger)hash {
    // could change the multiplier to a bigger one to be more future-proof
    return self.horizontalSizeClass + self.verticalSizeClass*3;
}

@end