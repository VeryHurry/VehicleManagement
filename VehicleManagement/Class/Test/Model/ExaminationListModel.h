//
//Created by ESJsonFormatForMac on 19/12/19.
//

#import <Foundation/Foundation.h>

@class ExaminationModel;
@interface ExaminationListModel : NSObject

@property (nonatomic, strong) NSArray *result;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger total;

@end
@interface ExaminationModel : NSObject

@property (nonatomic, copy) NSString *totalFront;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, copy) NSString *createPerson;

@property (nonatomic, copy) NSString *between;

@property (nonatomic, copy) NSString *examinationName;

@property (nonatomic, copy) NSString *answerNo;

@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, copy) NSString *titleNo;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *examinationNo;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *sql;

@property (nonatomic, copy) NSString *isFinish;

@property (nonatomic, copy) NSString *condition;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSString *scoreNo;

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, copy) NSString *orderBy;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *like;

@property (nonatomic, copy) NSString *beginTime;

@end

