# NSArray and NSSet categories for Key-Value filtering

Demo time : 

// Quick and easy search
NSArray * employees = [...]
Person * ceo = [employees firstObjectWithValue:@"timcook@apple.com" forKeyPath:@"email"];

// Keypaths
Person * steve = [employees firstObjectWithValue:[NSNull null] forKeyPath:@"car.licenseplate"]

// Keypath collection operators
NSArray * boxes = [...]
NSArray * emptyBoxes = [boxes filteredArrayWithValue:@0 forKey:@"items.@count"];

More details [on my blog](http://bou.io/FilteringNSArrayWithKeyValueCoding).