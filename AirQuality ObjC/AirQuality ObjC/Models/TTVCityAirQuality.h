//
//  TTVCityAirQuality.h
//  AirQuality ObjC
//
//  Created by theevo on 3/25/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TTVWeather;
@class TTVPollution;

@interface TTVCityAirQuality : NSObject

@property (nonatomic, copy, readonly) NSString * city;
@property (nonatomic, copy, readonly) NSString * state;
@property (nonatomic, copy, readonly) NSString * country;

@property (nonatomic, copy, readonly) TTVWeather * weather;
@property (nonatomic, copy, readonly) TTVPollution * pollution;

-(instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(TTVWeather *)weather pollution:(TTVPollution *)pollution;

@end


@interface TTVCityAirQuality (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
