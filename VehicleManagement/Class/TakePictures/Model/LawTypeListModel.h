//
//Created by ESJsonFormatForMac on 20/01/18.
//

#import <Foundation/Foundation.h>

@class LawTypeModel;
@interface ESRootClass : NSObject

@property (nonatomic, strong) NSArray *LawTypeListModel;

@end
@interface LawTypeModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *like;

@property (nonatomic, copy) NSString *between;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, copy) NSString *condition;

@property (nonatomic, copy) NSString *sql;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *orderBy;

@property (nonatomic, copy) NSString *totalFront;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, assign) NSInteger integral;

@property (nonatomic, copy) NSString *beginTime;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger pageSize;

@end

