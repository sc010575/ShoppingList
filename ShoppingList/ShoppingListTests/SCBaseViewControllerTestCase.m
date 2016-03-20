//
//  SCBaseViewControllerTestCase.m
//  ShoppingList
//
//  Created by Suman Chatterjee on 20/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

#import "SCBaseViewControllerTestCase.h"

@implementation SCBaseViewControllerTestCase

- (NSString*)storyboardRestorationId {
    return NSStringFromClass([self viewControllerClassUnderTest]);
}

- (Class)viewControllerClassUnderTest {
    //Should be overriden in child classes though
    return [SCBaseViewControllerTestCase class];
}

- (BOOL) shouldSkipAssert {
    return [self viewControllerClassUnderTest] == [SCBaseViewControllerTestCase class];
}



- (void)setUp {
    [super setUp];
    if (![self shouldSkipAssert]) {
        NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
        XCTAssert(info, @"Failed to retrieve contents of the Info.plist file");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:info[@"UIMainStoryboardFile"] bundle:[NSBundle mainBundle]];
        XCTAssert(storyboard, @"Failed to get the main storyboard");
        self.viewController = [storyboard instantiateViewControllerWithIdentifier:[self storyboardRestorationId]];
        [self.viewController performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
        [self.viewController performSelectorOnMainThread:@selector(viewDidLoad) withObject:nil waitUntilDone:YES];
    }
    
}

- (void)tearDown {
    self.viewController = nil;
    [super tearDown];
}

#pragma mark - Tests

- (void) testViewControllerCreation {
    XCTAssert(self.viewController || [self shouldSkipAssert], @"View Controller not created successfully");
    XCTAssert([self.viewController isMemberOfClass:[self viewControllerClassUnderTest]] || [self shouldSkipAssert], @"Test instance is incorrect class");
}

-(void) testViewLoading {
    XCTAssert(self.viewController.view || [self shouldSkipAssert], @"View not initiated properly");
}



@end
