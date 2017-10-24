//
//  ViewController.m
//  数据持久化
//
//  Created by doohanTech on 2017/10/24.
//  Copyright © 2017年 CaiJie. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "FMDB.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     沙盒目录：
     Document：           比较常用的一个用户数据存储目录          iTunes会同步此文件夹中的内容
     Library：
         Caches           缓存一些不重要的数据                  不会iTunes同步
         Preferences      存储一些应用程序偏好设置的目录          iTunes会同步
     tmp                  系统运行缓存数据，程序关闭时会自动清除    不会iTunes同步

     NSArray;
     NSMutableArray;
     NSDictionary;
     NSMutableDictionary;
     NSData;
     NSMutableData;
     NSString;
     NSMutableString;
     NSNumber;
     NSDate;

     */

    // plist文件
    [self plistStore];
    // preference
    [self preferenceStore];
    // NSKeyedArchiver
    [self ArchiverStore];
    // SQLite3

}

- (void)plistStore {
    // plist 将某些Foundation框架中的数据类型以XML文件的方式存储在目录当中

    // 创建一个存储路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    //NSString *filePath = [path stringByAppendingString:@"/account.plist"];
    NSString *filePath = [path stringByAppendingPathComponent:@"account.plist"];
    
    // 存储
    NSDictionary *accountModel = @{@"tel":@"155", @"pasword":@"123"};
    [accountModel writeToFile:filePath atomically:YES];
    // 读取
    NSDictionary *reqAccountModel = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"plist:%@",reqAccountModel);
}

- (void)preferenceStore {
    // preference 一般存储一些应用配置程序，一般不存储其他数据（不安全、数据量小）
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    // 存储
    [userDefaults setObject:@"李明" forKey:@"name"];
    [userDefaults setBool:YES forKey:@"boy"];
    [userDefaults setInteger:18.0 forKey:@"age"];
    [userDefaults synchronize]; //立即同步保存
    
    // 读取
    NSLog(@"preferenceStore:%@ %@ %@",
          [userDefaults valueForKey:@"name"],
          [userDefaults boolForKey:@"boy"]?@"男":@"女",
          [userDefaults valueForKey:@"age"]);
}

- (void)ArchiverStore {
    // 归档存储必须实现NSCoding协议，子类归档和解档时，需要先实现父类的归档和解档方法
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"student.data"];// 文件扩展名可以任意指定
    
    // 存储
    Student *xiaoMing = [[Student alloc] init];
    xiaoMing.name = @"小明";
    xiaoMing.age = 18;
    xiaoMing.boy = YES;
    [NSKeyedArchiver archiveRootObject:xiaoMing toFile:path];

    // 读取
    Student *whichStu = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"ArchiverStore:%@ %@ %zi",whichStu.name, whichStu.boy?@"男":@"女", whichStu.age);
}

- (void)FMDBStore {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"person.db"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    if (![database open]) {
        NSLog(@"数据库打开失败！");
    }

}

@end
