//
//  TestViewController.m
//  KVCandKVO
//
//  Created by 丹丹 on 15-3-25.
//  Copyright (c) 2015年 博文卡特. All rights reserved.
//

#import "TestViewController.h"
#import "Person.h"

@interface TestViewController ()
{
    Person *p;
    NSMutableArray *m_observedPeople;
}
@property (weak, nonatomic) IBOutlet UITextView *logTextView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    Person *spouse = [[Person alloc]initWithName:@"木棉" age:@"45"];
//    
//    p = [[Person alloc]initWithName:@"wendy" age:@"25" spouses:spouse];
    
    Person *spouse = [[Person alloc]init];
    spouse.name = @"木棉";
    spouse.age = @"45";
    
    
    p = [[Person alloc]init];
    p.name = @"wendy";
    p.age = @"123";
    p.spouse = spouse;
    p.address = @"beijing";
    [self watchPersonForChangeOfAddress:p];
    
}

-(void)changePersonNameWithNewname:(NSString *)newName forPerson:(Person *)per
{
    // using the KVC accessor (getter) method
    NSString *originalName = [per valueForKey:@"name"];
    
    // using the KVC  accessor (setter) method.
    [per setValue:newName forKey:@"name"];
//    NSString *str = [NSString stringWithFormat:@"%@",];
    NSLog(@"Changed %@'s name to: %@", originalName, newName);
    
    

    
}

-(void)kvcTestWithPerson:(Person *)spouses
{
    // just using the accessor again, same as example above
    NSString *personsName = [p valueForKey:@"name"];
    
    // this line is different, because it is using
    // a "key path" instead of a normal "key"
    NSString *spousesName = [p valueForKeyPath:@"spouse.name"];
    
//    [p valueForKeyPath:@"spouse.name"];
//    相当于这样……
//    [[p valueForKey:@"spouse"] valueForKey:@"name"];
    
    NSLog(@"%@ is happily married to %@", personsName, spousesName);
    
    //    改变地址
    //
    [spouses setValue:@"tieling" forKey:@"address"];
}


#pragma mark- kvo
-(void)watchPersonForChangeOfAddress:(Person *)person
{
    
    // this begins the observing
    [person addObserver:self
        forKeyPath:@"address"
           options:0
           context:@"你懂的"];
    
    // keep a record of all the people being observed,
    // because we need to stop observing them in dealloc
    [m_observedPeople addObject:p];
}

// whenever an observed key path changes, this method will be called
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context

{
    // use the context to make sure this is a change in the address,
    // because we may also be observing other things
    if(context == @"你懂的") {
        NSString *name = [object valueForKey:@"name"];
        NSString *address = [object valueForKey:@"address"];
        NSLog(@"%@ has a new address: %@", name, address);
    }
    else{
        NSLog(@"%@ has a address: %@", @"dd", @"dd");
    }
}

-(void) dealloc;
{
    
    // must stop observing everything before this object is
    // deallocated, otherwise it will cause crashes
    for(Person *person in m_observedPeople){
        [person removeObserver:self forKeyPath:@"address"];
    }
    m_observedPeople = nil;
    
}


- (IBAction)changeName:(id)sender {
    
    [self changePersonNameWithNewname:@"abv" forPerson:p];
    
}
- (IBAction)doSometing:(id)sender {
    
   
    [self kvcTestWithPerson:p];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
