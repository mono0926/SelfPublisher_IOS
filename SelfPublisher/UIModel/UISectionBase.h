//
//  UISectionBase.h
//  SelfPublisher
//
//  Created by mono on 7/14/13.
//  Copyright (c) 2013 mono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import "Mantle.h"
@class SectionBase;

@interface UISectionBase : MTLModel<MTLJSONSerializing> {
    SectionBase* _sectionBase;
}
- (id)initWithSectionBase:(SectionBase*)sectionBase;
@property (nonatomic, readonly) NSString* caption;
@property (nonatomic, readonly) NSString* body;
@property (nonatomic, readonly) NSArray* bodies;

-(void)saveCaption:(NSString*)caption body:(NSString*)body errorBlock:(void(^)(NSError*))errorBlock;
-(NSError*)saveCaption:(NSString*)caption body:(NSString*)body;
-(NSString*)addImage:(UIImage*)image;
@end
