//
//  SCTableViewControllerTestCase.m
//  ShoppingList
//
//  Created by Suman Chatterjee on 20/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

#import "SCTableViewControllerTestCase.h"

@implementation SCTableViewControllerTestCase

- (UITableViewController*)tableViewController {
    return (UITableViewController*)self.viewController;
}

- (Class)classUnderTest {
    //Should be overriden in child classes though
    return [SCTableViewControllerTestCase class];
}

- (BOOL) shouldSkipAssert {
    return [self classUnderTest] == [SCTableViewControllerTestCase class];
}

#pragma mark - UITableView tests cases

-(void)testThatTableViewLoads {
    XCTAssert(self.tableViewController.tableView || [self shouldSkipAssert], @"TableView not initiated");
}

- (void)testThatViewConformsToUITableViewDataSource {
    XCTAssert([self.tableViewController conformsToProtocol:@protocol(UITableViewDataSource)] || [self shouldSkipAssert], @"View does not conform to UITableView datasource protocol");
}

- (void)testThatTableViewHasDataSource {
    XCTAssert(self.tableViewController.tableView.dataSource || [self shouldSkipAssert], @"Table datasource cannot be nil");
}

- (void)testThatViewConformsToUITableViewDelegate {
    XCTAssert([self.tableViewController conformsToProtocol:@protocol(UITableViewDelegate)] || [self shouldSkipAssert], @"View does not conform to UITableView delegate protocol");
}

- (void)testTableViewIsConnectedToDelegate {
    XCTAssert(self.tableViewController.tableView.delegate || [self shouldSkipAssert], @"Table delegate cannot be nil");
}

- (void)testTableViewCellCreateCellsWithReuseIdentifier {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [self.tableViewController tableView:self.tableViewController.tableView cellForRowAtIndexPath:indexPath];
    XCTAssert(cell || [self shouldSkipAssert], @"Table data source failed to create a cell");
}

@end
