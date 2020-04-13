//
//Created by ESJsonFormatForMac on 20/04/09.
//

#import <Foundation/Foundation.h>

@class LawModel;
@interface LawListModel : NSObject

@property (nonatomic, strong) NSArray *result;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger total;

@end
@interface LawModel : NSObject

@property (nonatomic, copy) NSString *lawAddress;

@property (nonatomic, copy) NSString *lawType;

@property (nonatomic, copy) NSString *createPerson;

@property (nonatomic, copy) NSString *beginTime;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger integral;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, assign) NSInteger channelType;

@property (nonatomic, copy) NSString *law;

@property (nonatomic, copy) NSString *accountNo;

@property (nonatomic, copy) NSString *checkTime;

@property (nonatomic, copy) NSString *vehicleNo;

@property (nonatomic, copy) NSString *file2;

@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, copy) NSString *totalFront;

@property (nonatomic, copy) NSString *condition;

@property (nonatomic, copy) NSString *like;

@property (nonatomic, copy) NSString *appeal;

@property (nonatomic, copy) NSString *disposeTime;

@property (nonatomic, copy) NSString *disposePerson;

@property (nonatomic, copy) NSString *orderBy;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger companyId;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, copy) NSString *companyNo;

@property (nonatomic, copy) NSString *createPersonName;

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, copy) NSString *orderNo;

@property (nonatomic, copy) NSString *between;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *file3;

@property (nonatomic, copy) NSString *sql;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *file1;

@property (nonatomic, copy) NSString *checkPerson;

@property (nonatomic, copy) NSString *appealFile;

@property (nonatomic, copy) NSString *companyName;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) NSInteger userId;

@end

