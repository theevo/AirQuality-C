//
//  TTVCityAirQualityController.h
//  AirQuality ObjC
//
//  Created by theevo on 3/25/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TTVCityAirQuality;

@interface TTVCityAirQualityController : NSObject

+(void) fetchSupportedCountries:(void(^)(NSArray<NSString *> *_Nullable))completion;

+(void) fetchSupportedStatesInCountry:(NSString *)country
                           completion:(void(^)(NSArray<NSString *> *_Nullable))completion;

+(void) fetchSupportedCitiesInState:(NSString *)state
                            country:(NSString *)country
                         completion:(void(^)(NSArray<NSString *> *_Nullable))completion;

+(void) fetchDataForCity:(NSString *)city
                   state:(NSString *)state
                 country:(NSString *)country
              completion:(void(^)(TTVCityAirQuality *_Nullable))completion;

@end

NS_ASSUME_NONNULL_END
