//
//  Person.h
//  KVCandKVO
//
//  Created by 丹丹 on 15-3-25.
//  Copyright (c) 2015年 博文卡特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *age;
@property (nonatomic,strong) Person *spouse;
@property (nonatomic,strong) NSString *address;

//-(instancetype)initWithName:(NSString*)aName;
//-(instancetype)initWithName:(NSString*)aName age:(NSString *)aAge;
//-(instancetype)initWithName:(NSString*)aName age:(NSString *)aAge spouses:(Person*)aSpouses;
@end
