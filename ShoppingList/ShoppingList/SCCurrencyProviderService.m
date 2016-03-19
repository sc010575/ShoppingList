//
//  SCCurrencyProviderService.m
//  ShoppingList
//
//  Created by Suman Chatterjee on 18/03/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

#import "SCCurrencyProviderService.h"
#import "AFNetworking.h"


NSString* const SCLocalCurrency = @"GBP";
NSString* const SCListOfCurrencyDetailsUrl = @"http://apilayer.net/api/list?access_key=a219d06123a388bd0cdc3373e1e40cdb";

NSString* const SCCurrencyBaseUrlForConversion = @"http://apilayer.net/api/convert?access_key=";
NSString* const SCAccountKey = @"a219d06123a388bd0cdc3373e1e40cdb";


@interface SCCurrencyProviderService()

@property (nonatomic, strong) NSDictionary* cachedCurrencyDictonary;

@end


@implementation SCCurrencyProviderService

+ (instancetype) instance
{
    static dispatch_once_t pred;
    static id sharedInstance = nil;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

// Here we request for the currency details , because the list will be same every time therefore I cached it after a successful fetch.

- (void) getCurrenciesDetailsWithCompletion:(SuccessBlock)success
                                    failure:(FailureBlock)failure
{
    
    if(self.cachedCurrencyDictonary != nil){
        
        success(self.cachedCurrencyDictonary);
        
    }else{
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        [manager GET:SCListOfCurrencyDetailsUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            NSString *statusCheck = responseObject[@"success"];
            if([statusCheck boolValue])
            {
                NSDictionary *currencyDict = responseObject[@"currencies"];
                self.cachedCurrencyDictonary = currencyDict;
                success(currencyDict);
            }
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            
            NSLog(@"Error: %@", error);
            failure(error);
            
        }];
    }
    

}

- (NSDictionary*)getCachedCurrency
{
    return self.cachedCurrencyDictonary;
}

- (void) convertAmountInLocalCurrency:(CGFloat)amount
                           toCurrency:(NSString*)currency
                       withCompletion:(SuccessBlock)success
                              failure:(FailureBlock)failure
{
    NSString *fullUrlString = [NSString stringWithFormat:@"%@%@&from=%@&to=%@&amount=%0.2f&format=1",SCCurrencyBaseUrlForConversion,SCAccountKey,SCLocalCurrency,currency,amount];
    NSString *encoded = [fullUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:encoded parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSString *statusCheck = responseObject[@"success"];
        if([statusCheck boolValue])
        {
            NSDictionary *currencyDict = responseObject[@"currencies"];
            self.cachedCurrencyDictonary = currencyDict;
            success(currencyDict);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        failure(error);
        
    }];

 }


@end
