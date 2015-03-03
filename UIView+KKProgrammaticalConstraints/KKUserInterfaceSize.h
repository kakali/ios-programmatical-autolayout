//
//  KKUserInterfaceSize.h
//
//  Created by Katarzyna Kalinowska-Górska on 27.02.2015.
//  Copyright (c) 2015 Katarzyna Kalinowska-Górska. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKUserInterfaceSize : NSObject <NSCopying>

@property(nonatomic) UIUserInterfaceSizeClass horizontalSizeClass;
@property(nonatomic) UIUserInterfaceSizeClass verticalSizeClass;

+ (instancetype)sizeWithHorizontalSizeClass:(UIUserInterfaceSizeClass)horizontalSizeClass verticalSizeClass:(UIUserInterfaceSizeClass)verticalSizeClass;

- (id)initWithHorizontalSizeClass:(UIUserInterfaceSizeClass)horizontalSizeClass verticalSizeClass:(UIUserInterfaceSizeClass)verticalSizeClass;

@end