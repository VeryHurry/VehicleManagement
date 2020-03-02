//
//  GoTestView.h
//  VehicleManagement
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 ZB. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoTestView : UIView

@property(nonatomic, copy) XXVoidBlock block;

+ (void)alertWithBlock:(XXVoidBlock)block;

@end

NS_ASSUME_NONNULL_END
