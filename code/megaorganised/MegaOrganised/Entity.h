//
//  Entity.h
//  
//
//  Created by karan singh on 10/31/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Entity;

@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * taskDescription;
@property (nonatomic, retain) NSNumber * taskOrder;
@property (nonatomic, retain) Entity *parent;
@property (nonatomic, retain) Entity *children;

@end
