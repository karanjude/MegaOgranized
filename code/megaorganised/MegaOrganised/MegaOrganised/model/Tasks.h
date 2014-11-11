//
//  Tasks.h
//  
//
//  Created by karan singh on 10/31/14.
//
//

#import <Foundation/Foundation.h>

@class Task;

@interface Tasks : NSObject

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

- (id)initTasks;
- (Task*)rootItem:(Task*)taskParent;


@end
