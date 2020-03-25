//
//  TTVPollution.m
//  AirQuality ObjC
//
//  Created by theevo on 3/25/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

#import "TTVPollution.h"

@implementation TTVPollution

-(instancetype)initWithInt:(NSInteger) aqi
{
    self = [super init];
    if (self) {
        _airQualityIndex = aqi;
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSInteger aqi = [dictionary[@"aqius"] intValue];
    return [self initWithInt:aqi];
}

@end
