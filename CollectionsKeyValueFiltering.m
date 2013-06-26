//
//  CollectionsKeyValueFiltering.m
//
//
//  Copyright (c) 2010-2013 Nicolas Bouilleaud.
//  http://bou.io/FilteringNSArrayWithKeyValueCoding
//

#import "CollectionsKeyValueFiltering.h"

@implementation NSArray (KeyValueFiltering)

- (id) firstObjectWithValue:(id)value forKeyPath:(NSString*)key
{
	for (id object in self) {
		if( [[object valueForKeyPath:key] isEqual:value] )
			return object;
	}
	return nil;
}

- (NSArray*) filteredArrayWithValue:(id)value forKeyPath:(NSString*)key
{
	NSMutableArray * objects = [NSMutableArray arrayWithCapacity:[self count]];
	
	for (id object in self) {
		if( [[object valueForKeyPath:key] isEqual:value] )
			[objects addObject:object];
	}
	
	return [NSArray arrayWithArray:objects];
}

- (NSDictionary*) indexedDictionaryByKeyPath:(NSString*)key
{
    NSArray *keys = [self valueForKeyPath:key];
    return [[NSDictionary alloc] initWithObjects:self forKeys:keys];
}

@end


@implementation NSSet (KeyValueFiltering)

- (id) anyObjectWithValue:(id)value forKeyPath:(NSString*)key
{
	for (id object in self) {
		if( [[object valueForKeyPath:key] isEqual:value] )
			return object;
	}
	return nil;
}

- (NSSet*) filteredSetWithValue:(id)value forKeyPath:(NSString*)key
{
	NSMutableSet * objects = [NSMutableSet setWithCapacity:[self count]];
	
	for (id object in self) {
		if( [[object valueForKeyPath:key] isEqual:value] )
			[objects addObject:object];
	}
	
	return [NSSet setWithSet:objects];
}

- (NSDictionary*) indexedDictionaryByKeyPath:(NSString*)key
{
    NSSet *keys = [self valueForKeyPath:key];
    return [[NSDictionary alloc] initWithObjects:self.allObjects forKeys:keys.allObjects];
}

@end

@implementation NSMutableSet (KeyValueFiltering)

- (void)exceptSet:(NSSet *)other
{
    NSMutableSet *cp = [[NSMutableSet alloc] initWithSet:self copyItems:NO];
    [cp intersectSet:other];
    
    [cp enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        [self removeObject:obj];
    }];
}

@end

