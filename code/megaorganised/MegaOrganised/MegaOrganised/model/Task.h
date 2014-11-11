//
//  Task.h
//  
//
//  Created by karan singh on 10/31/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Task;

@interface Task : NSManagedObject

@property (nonatomic, retain) NSString * taskDescription;
@property (nonatomic, retain) NSNumber * taskOrder;
@property (nonatomic, retain) Task *parent;
@property (nonatomic, retain) NSSet *children;
@end

@interface Task (CoreDataGeneratedAccessors)

- (void)addChildrenObject:(Task *)value;
- (void)removeChildrenObject:(Task *)value;
- (void)addChildren:(NSSet *)values;
- (void)removeChildren:(NSSet *)values;

+ (instancetype)insertItemWithTitle:(NSString*)title
                             parent:(Task*)parent
             inManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;


- (NSFetchedResultsController*)childrenFetchedResultsController:(Task*)parent;



@end
