//
//  CollectionsKeyValueFiltering.h
//
//
//  Copyright (c) 2010-2013 Nicolas Bouilleaud.
//  http://bou.io/FilteringNSArrayWithKeyValueCoding
//

#import <Foundation/Foundation.h>

@interface NSArray (KeyValueFiltering)

/*
 * KVC related addition : find and return the first object in the array whose value for keypath *keypath* is equal to *value*.
 * will return nil if no such object is found.
 */
- (id) firstObjectWithValue:(id)value forKeyPath:(NSString*)keypath;

/*
 * KVC related addition : find and return the objects in the array whose value for keypath *keypath* is equal to *value*.
 * will return an empty array if no such object is found.
 */
- (NSArray*) filteredArrayWithValue:(id)value forKeyPath:(NSString*)keypath;

@end


@interface NSSet (KeyValueFiltering)

/*
 * KVC related addition : find and return the first object in the array whose value for keypath *keypath* is equal to *value*.
 * will return nil if no such object is found.
 */
- (id) anyObjectWithValue:(id)value forKeyPath:(NSString*)keypath;

/*
 * KVC related addition : find and return the objects in the array whose value for keypath *keypath* is equal to *value*.
 * will return an empty array if no such object is found.
 */
- (NSSet*) filteredSetWithValue:(id)value forKeyPath:(NSString*)keypath;

@end

