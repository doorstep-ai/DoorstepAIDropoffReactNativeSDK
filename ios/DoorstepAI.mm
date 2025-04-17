#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(DoorstepAI, NSObject)

RCT_EXTERN_METHOD(setApiKey:(NSString *)apiKey)
RCT_EXTERN_METHOD(startDeliveryByPlaceID:(NSString *)placeID
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(startDeliveryByPlusCode:(NSString *)plusCode
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(startDeliveryByAddress:(NSString *)addressJSON
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(newEvent:(NSString *)eventName
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(stopDelivery:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)

@end 