//
//  TTVCityAirQualityController.m
//  AirQuality ObjC
//
//  Created by theevo on 3/25/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

#import "TTVCityAirQualityController.h"
#import "TTVCityAirQuality.h"

static NSString * const baseURLstring = @"https://api.airvisual.com/v2/";
static NSString * const countriesComponent = @"countries";
static NSString * const countryDetailComponent = @"country";
static NSString * const statesComponent = @"states";
static NSString * const stateDetailComponent = @"state";
static NSString * const citiesComponent = @"cities";
static NSString * const cityDetailsComponent = @"city";
static NSString * const apiKeyAirvisual = @"key";
static NSString * const apiKeyValueAirvisual = @"c624f1f8-8282-4868-9b56-01bb71a3cbe3";


@implementation TTVCityAirQualityController

+ (void)fetchSupportedCountries:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLstring];
    
    NSURL *countryURL = [baseURL URLByAppendingPathComponent:countriesComponent];
    
    NSURLQueryItem *apiQueryItem = [[NSURLQueryItem alloc] initWithName:apiKeyAirvisual value:apiKeyValueAirvisual];
    
    // building an array of QueryItems, bc URLComponents expects an array
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    [queryItems addObject:apiQueryItem];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:countryURL resolvingAgainstBaseURL:true];
    [urlComponents setQueryItems:queryItems];
    NSURL *finalURL = [urlComponents URL];
    
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"Error fetching posts: %@", error);
            completion(nil);
            return;
        }
        
        if (!data)
        {
            NSLog(@"Error. No data was returned: %@", error);
            completion(nil);
            return;
        }
        
        NSDictionary *topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &error];
        NSDictionary *secondLevelJSON = topLevelJSON[@"data"];
        
        NSMutableArray *countriesArray = [NSMutableArray new];
        
        for (NSDictionary *currentDictionary in secondLevelJSON)
        {
            NSString *country = [[NSString alloc] initWithString:currentDictionary[@"country"]];
            [countriesArray addObject:country];
        }
        
        completion(countriesArray);
        
    }] resume];
    
}

+ (void)fetchSupportedStatesInCountry:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLstring];
    
    NSURL *statesURL = [baseURL URLByAppendingPathComponent:statesComponent];
    
    NSURLQueryItem *apiQueryItem = [[NSURLQueryItem alloc] initWithName:apiKeyAirvisual value:apiKeyValueAirvisual];
    NSURLQueryItem *countryQueryItem = [[NSURLQueryItem alloc] initWithName:countryDetailComponent value:country];
    
    // building an array of QueryItems, bc URLComponents expects an array
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    [queryItems addObject:apiQueryItem];
    [queryItems addObject:countryQueryItem];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:statesURL resolvingAgainstBaseURL:true];
    [urlComponents setQueryItems:queryItems];
    NSURL *finalURL = [urlComponents URL];
    
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"Error fetching posts: %@", error);
            completion(nil);
            return;
        }
        
        if (!data)
        {
            NSLog(@"Error. No data was returned: %@", error);
            completion(nil);
            return;
        }
        
        NSDictionary *topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &error];
        NSDictionary *secondLevelJSON = topLevelJSON[@"data"];
        
        NSMutableArray *statesArray = [NSMutableArray new];
        
        for (NSDictionary *currentDictionary in secondLevelJSON)
        {
            NSString *state = [[NSString alloc] initWithString:currentDictionary[@"state"]];
            [statesArray addObject:state];
        }
        
        completion(statesArray);
        
    }] resume];
}

+ (void)fetchSupportedCitiesInState:(NSString *)state country:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLstring];
    
    NSURL *citiesURL = [baseURL URLByAppendingPathComponent:citiesComponent];
    
    NSURLQueryItem *apiQueryItem = [[NSURLQueryItem alloc] initWithName:apiKeyAirvisual value:apiKeyValueAirvisual];
    NSURLQueryItem *countryQueryItem = [[NSURLQueryItem alloc] initWithName:countryDetailComponent value:country];
    NSURLQueryItem *stateQueryItem = [[NSURLQueryItem alloc] initWithName:stateDetailComponent value:state];
    
    // building an array of QueryItems, bc URLComponents expects an array
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    [queryItems addObject:apiQueryItem];
    [queryItems addObject:countryQueryItem];
    [queryItems addObject:stateQueryItem];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:citiesURL resolvingAgainstBaseURL:true];
    [urlComponents setQueryItems:queryItems];
    NSURL *finalURL = [urlComponents URL];
    
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"Error fetching posts: %@", error);
            completion(nil);
            return;
        }
        
        if (!data)
        {
            NSLog(@"Error. No data was returned: %@", error);
            completion(nil);
            return;
        }
        
        NSDictionary *topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &error];
        NSDictionary *secondLevelJSON = topLevelJSON[@"data"];
        
        NSMutableArray *citiesArray = [NSMutableArray new];
        
        for (NSDictionary *currentDictionary in secondLevelJSON)
        {
            NSString *city = [[NSString alloc] initWithString:currentDictionary[@"city"]];
            [citiesArray addObject:city];
        }
        
        completion(citiesArray);
        
    }] resume];
}

+ (void)fetchDataForCity:(NSString *)city state:(NSString *)state country:(NSString *)country completion:(void (^)(TTVCityAirQuality * _Nullable))completion

{
    NSURL *baseURL = [NSURL URLWithString:baseURLstring];
    
    NSURL *cityURL = [baseURL URLByAppendingPathComponent:cityDetailsComponent];
    
    NSURLQueryItem *apiQueryItem = [[NSURLQueryItem alloc] initWithName:apiKeyAirvisual value:apiKeyValueAirvisual];
    NSURLQueryItem *countryQueryItem = [[NSURLQueryItem alloc] initWithName:countryDetailComponent value:country];
    NSURLQueryItem *stateQueryItem = [[NSURLQueryItem alloc] initWithName:stateDetailComponent value:state];
    NSURLQueryItem *cityQueryItem = [[NSURLQueryItem alloc] initWithName:cityDetailsComponent value:city];
    
    // building an array of QueryItems, bc URLComponents expects an array
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    [queryItems addObject:apiQueryItem];
    [queryItems addObject:countryQueryItem];
    [queryItems addObject:stateQueryItem];
    [queryItems addObject:cityQueryItem];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:cityURL resolvingAgainstBaseURL:true];
    [urlComponents setQueryItems:queryItems];
    NSURL *finalURL = [urlComponents URL];
    
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"Error fetching posts: %@", error);
            completion(nil);
            return;
        }
        
        if (!data)
        {
            NSLog(@"Error. No data was returned: %@", error);
            completion(nil);
            return;
        }
        
        NSDictionary *topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &error];
        NSDictionary *secondLevelJSON = topLevelJSON[@"data"];
        
        TTVCityAirQuality *cityObject = [[TTVCityAirQuality alloc] initWithDictionary:secondLevelJSON];
        
        completion(cityObject);
        
    }] resume];
}


@end
