//
//  TTVCityAirQuality.m
//  AirQuality ObjC
//
//  Created by theevo on 3/25/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

#import "TTVCityAirQuality.h"
#import "TTVWeather.h"
#import "TTVPollution.h"

@implementation TTVCityAirQuality

- (instancetype)initWithCity:(NSString *)city
                       state:(NSString *)state
                     country:(NSString *)country
                     weather:(TTVWeather *)weather
                   pollution:(TTVPollution *)pollution
{
    self = [super init];
    if (self)
    {
        _city = city;
        _state = state;
        _country = country;
        _weather = weather;
        _pollution = pollution;
    }
    return self;
}

@end


@implementation TTVCityAirQuality (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *city = [dictionary[@"city"] stringValue];
    NSString *state = [dictionary[@"state"] stringValue];
    NSString *country = [dictionary[@"country"] stringValue];
    
    NSDictionary *currentDictionary = dictionary[@"current"];
    
    TTVWeather *weather = [[TTVWeather alloc] initWithDictionary:currentDictionary[@"weather"]];
    TTVPollution *pollution = [[TTVPollution alloc] initWithDictionary:currentDictionary[@"pollution"]];
    
    return [self initWithCity:city state:state country:country weather:weather pollution:pollution];
}

@end
