//
//  Student.h
//  数据持久化
//
//  Created by doohanTech on 2017/10/24.
//  Copyright © 2017年 CaiJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (nonatomic, strong) NSString    *name;
@property (nonatomic, assign) BOOL        boy;
@property (nonatomic, assign) int  age;

@end
