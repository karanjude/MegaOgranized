//
//  Task.m
//  
//
//  Created by karan singh on 10/31/14.
//
//

#import "Task.h"
#import "Task.h"


@implementation Task

@dynamic taskDescription;
@dynamic taskOrder;
@dynamic parent;
@dynamic children;

+ (instancetype)insertItemWithTitle:(NSString*)title
                             parent:(Task*)parent
             inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{

    
    NSUInteger order = parent.numberOfChildren;
    Task* item = [NSEntityDescription insertNewObjectForEntityForName:self.entityName
                                               inManagedObjectContext:managedObjectContext];
    item.taskDescription = title;
    item.taskOrder = @(order);
    item.parent = parent;

    return item;
}

+ (NSString*)entityName
{
    return @"Task";
}

- (NSUInteger)numberOfChildren
{
    return self.children.count;
}

- (NSFetchedResultsController*)childrenFetchedResultsController:(Task*)parent
{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:[self.class entityName]];
    //request.predicate = [NSPredicate predicateWithFormat:@"parent = %@", self];
    request.predicate = [NSPredicate predicateWithFormat:@"parent = %@", parent];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"taskOrder" ascending:YES]];
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}



@end
