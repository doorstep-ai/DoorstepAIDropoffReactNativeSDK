#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(DoorstepAI, NSObject)

RCT_EXTERN_METHOD(setApiKey:(NSString *)apiKey)
RCT_EXTERN_METHOD(setDevMode:(BOOL)devModeEnabled)
RCT_EXTERN_METHOD(startDeliveryByPlaceID:(NSString *)placeID
                 deliveryId:(NSString *)deliveryId
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(startDeliveryByPlusCode:(NSString *)plusCode
                 deliveryId:(NSString *)deliveryId
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(startDeliveryByAddress:(NSDictionary *)address
                 deliveryId:(NSString *)deliveryId
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(newEvent:(NSString *)eventName
                 deliveryId:(NSString *)deliveryId
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(stopDelivery:(NSString *)deliveryId
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)

@end 