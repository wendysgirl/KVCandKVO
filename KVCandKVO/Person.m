//
//  Person.m
//  KVCandKVO
//
//  Created by 丹丹 on 15-3-25.
//  Copyright (c) 2015年 博文卡特. All rights reserved.
//

#import "Person.h"

@implementation Person

-(instancetype)initWithName:(NSString*)aName age:(NSString *)aAge {
    if (self=[super init]) {
        self.name=aName;
        self.age=aAge;
    }
    return self;
}
-(instancetype)initWithName:(NSString*)aName age:(NSString *)aAge spouses:(Person*)aSpouses{
    if (self=[super init]) {
        self.name=aName;
        self.age=aAge;
        self.spouse=aSpouses;
    }
    return self;
}
@end
