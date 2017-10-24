//
//  Student.m
//  数据持久化
//
//  Created by doohanTech on 2017/10/24.
//  Copyright © 2017年 CaiJie. All rights reserved.
//

#import "Student.h"

@interface Student()<NSCoding>

@end

@implementation Student

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.boy = [aDecoder decodeBoolForKey:@"boy"];
        self.age = [aDecoder decodeIntForKey:@"age"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeBool:self.boy forKey:@"boy"];
    [aCoder encodeInt:self.age forKey:@"age"];

}

@end
