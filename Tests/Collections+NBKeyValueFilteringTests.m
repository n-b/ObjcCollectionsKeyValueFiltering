//
//  CollectionsKeyValueFilteringTests.m
//
//
//  Copyright (c) 2010-2013 Nicolas Bouilleaud.
//  http://bou.io/FilteringNSArrayWithKeyValueCoding
//

#import "CollectionsKeyValueFiltering.h"
#import <SenTestingKit/SenTestingKit.h>

#pragma mark - Array

@interface NSArrayTests : SenTestCase
@end

@implementation NSArrayTests

- (void) testFirstObjectWithValueForKeyPath
{
    NSArray * testdata = @[@{@"key" : @"v", @"id": @1},
                           @{@"key" : @"a", @"id": @2},
                           @{@"key" : @"l", @"id": @3},
                           @{@"key" : @"u", @"id": @4},
                           @{@"key" : @"e", @"id": @5},
                           ];
    
    STAssertEqualObjects([[testdata firstObjectWithValue:@"a" forKeyPath:@"key"] objectForKey:@"id"], @2, nil);
}

- (void) testFilteredArrayWithValueForKeyPath
{
    NSArray * testdata = @[@{@"key" : @"b", @"id": @1},
                           @{@"key" : @"a", @"id": @2},
                           @{@"key" : @"b", @"id": @3},
                           @{@"key" : @"a", @"id": @4},
                           @{@"key" : @"b", @"id": @5},
                           ];

    STAssertEqualObjects([[testdata filteredArrayWithValue:@"b" forKeyPath:@"key"] valueForKey:@"id"], (@[@1,@3,@5]), nil);
}

- (void) testArrayToIndexedDictionary
{
    NSArray * testdata = @[@{@"key" : @"a", @"value": @1},
                           @{@"key" : @"b", @"value": @2},
                           @{@"key" : @"c", @"value": @3},
                           @{@"key" : @"d", @"value": @4},
                           @{@"key" : @"e", @"value": @5},
                           ];
    
    NSDictionary * result = [testdata indexedDictionaryByKeyPath:@"key"];
    STAssertEqualObjects([testdata[1] objectForKey:@"value"], [result[@"b"]  objectForKey:@"value"], nil);
}

@end

#pragma mark - Set

@interface NSSetTests : SenTestCase
@end

@implementation NSSetTests

- (void) testAnyObjectWithValueForKeyPath
{
    NSSet * testdata = [NSSet setWithArray:
                        @[@{@"key" : @"v", @"id": @1},
                        @{@"key" : @"a", @"id": @2},
                        @{@"key" : @"l", @"id": @3},
                        @{@"key" : @"u", @"id": @4},
                        @{@"key" : @"e", @"id": @5},
                        ]];
    
    STAssertEqualObjects([[testdata anyObjectWithValue:@"a" forKeyPath:@"key"] valueForKey:@"id"], @2, nil);
}

- (void) testFilteredSetWithValueForKeyPath
{
    NSSet * testdata = [NSSet setWithArray:
                        @[@{@"key" : @"b", @"id": @1},
                        @{@"key" : @"a", @"id": @2},
                        @{@"key" : @"b", @"id": @3},
                        @{@"key" : @"a", @"id": @4},
                        @{@"key" : @"b", @"id": @5},
                        ]];
    
    STAssertEqualObjects([[testdata filteredSetWithValue:@"b" forKeyPath:@"key"] valueForKey:@"id"], ([NSSet setWithArray:@[@1,@3,@5]]), nil);
}

- (void) testSetToIndexedDictionary
{
    NSSet * testdata = [NSSet setWithArray:
                          @[@{@"key" : @"a", @"value": @1},
                           @{@"key" : @"b", @"value": @2},
                           @{@"key" : @"c", @"value": @3},
                           @{@"key" : @"d", @"value": @4},
                           @{@"key" : @"e", @"value": @5},
                           ]];
    
    NSDictionary * result = [testdata indexedDictionaryByKeyPath:@"key"];
    STAssertEqualObjects([[testdata anyObjectWithValue:@"b" forKeyPath:@"key" ] objectForKey:@"value"], [result[@"b"]  objectForKey:@"value"], nil);
}



- (void) testSetExcept
{
    NSMutableSet * testdata = [NSMutableSet setWithArray:
                        @[@1, @2, @3, @4]];
    NSMutableSet * othertestdata = [NSMutableSet setWithArray:
                        @[@3, @4, @5, @6]];
    
    [testdata exceptSet:othertestdata];

    STAssertTrue(testdata.count == 2, nil);
    
}

@end

#pragma mark - KeyPathTests

@interface KeyPathTests : SenTestCase
@end

@implementation KeyPathTests

- (void) testFilteredWithKeyPath
{
    NSArray * testdata = @[@{@"id": @1, @"key1": @{@"key2": @"b"}},
                           @{@"id": @2, @"key1": @{@"key2": @"a"}},
                           @{@"id": @3, @"key1": @{@"key2": @"b"}},
                           @{@"id": @4, @"key1": @{@"key2": @"a"}},
                           @{@"id": @5, @"key1": @{@"key2": @"b"}},
                           ];
    
    STAssertEqualObjects([[testdata filteredArrayWithValue:@"a" forKeyPath:@"key1.key2"] valueForKey:@"id"],(@[@2,@4]), nil);
}

- (void) testFilteredWithCollectionOperator
{
    NSArray * testdata = @[@{@"id": @1, @"items": @[]},
                           @{@"id": @2, @"items": @[@0]},
                           @{@"id": @3, @"items": @[@0,@0]},
                           @{@"id": @4, @"items": @[@0,@0,@0]},
                           @{@"id": @5, @"items": @[]},
                           ];
    
    STAssertEqualObjects([[testdata filteredArrayWithValue:@0 forKeyPath:@"items.@count"] valueForKey:@"id"],(@[@1,@5]), nil);
}

@end

