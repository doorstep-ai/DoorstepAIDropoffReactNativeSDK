import Foundation
import React
import DoorstepDropoffSDK
import CoreLocation

@objc(DoorstepAI)
class DoorstepAIBridge: NSObject {
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        
        // Request authorization
        locationManager.requestAlwaysAuthorization()
        
    }

    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }

    @objc
    func setDevMode(_ devModeEnabled: Bool) {
        DoorstepAI.devMode = devModeEnabled
    }

    @objc
    func setApiKey(_ apiKey: String) {
        DoorstepAI.setApiKey(key: apiKey)
    }

    @objc
    func startDeliveryByPlaceID(_ placeID: NSString,
                                deliveryId: NSString,
                                resolver resolve: @escaping RCTPromiseResolveBlock,
                                rejecter reject: @escaping RCTPromiseRejectBlock) {
        // Use Swift's concurrency support to call the async method.
        Task {
            do {
                try await DoorstepAI.startDeliveryByPlaceID(placeID: placeID as String, deliveryId: deliveryId as String)
                resolve(nil)
            } catch {
                reject("E_START_DELIVERY", "Failed to start delivery by Place ID: \(error.localizedDescription)", error)
            }
        }
    }

    @objc
    func startDeliveryByPlusCode(_ plusCode: NSString,
                                 deliveryId: NSString,
                                 resolver resolve: @escaping RCTPromiseResolveBlock,
                                 rejecter reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                try await DoorstepAI.startDeliveryByPlusCode(plusCode: plusCode as String, deliveryId: deliveryId as String)
                resolve(nil)
            } catch {
                reject("E_START_DELIVERY", "Failed to start delivery by Plus Code: \(error.localizedDescription)", error)
            }
        }
    }

    @objc
    func startDeliveryByAddress(_ address: [String: Any],
                                deliveryId: NSString,
                                resolver resolve: @escaping RCTPromiseResolveBlock,
                                rejecter reject: @escaping RCTPromiseRejectBlock) {
        Task {
            print("Starting delivery by address: \(address)")
            do {
                guard let streetNumber = address["streetNumber"] as? String,
                      let route = address["route"] as? String,
                      let subPremise = address["subPremise"] as? String,
                      let locality = address["locality"] as? String,
                      let administrativeAreaLevel1 = address["administrativeAreaLevel1"] as? String,
                      let postalCode = address["postalCode"] as? String else {
                    reject("E_INVALID_ADDRESS", "Missing or invalid fields in address dictionary.", nil)
                    return
                }

                let addressStruct = AddressType(streetNumber: streetNumber,
                                            route: route,
                                            subPremise: subPremise,
                                            locality: locality,
                                            administrativeAreaLevel1: administrativeAreaLevel1,
                                            postalCode: postalCode)

                try await DoorstepAI.startDeliveryByAddressType(address: addressStruct, deliveryId: deliveryId as String)
                resolve(nil)
            } catch let error as DoorstepAIError {
                reject("E_START_DELIVERY", "Failed to start delivery by address: \(error.localizedDescription)", error)
            } catch {
                reject("E_UNKNOWN", "An unexpected error occurred: \(error.localizedDescription)", error)
            }
        }
    }

    @objc
    func newEvent(_ eventName: NSString,
                  deliveryId: NSString,
                  resolver resolve: @escaping RCTPromiseResolveBlock,
                  rejecter reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                try await DoorstepAI.newEvent(eventName: eventName as String, deliveryId: deliveryId as String)
                resolve(nil)
            } catch {
                reject("E_NEW_EVENT", "Failed to send event: \(error.localizedDescription)", error)
            }
        }
    }

    @objc
    func stopDelivery(_ deliveryId: NSString,
                      resolver resolve: @escaping RCTPromiseResolveBlock,
                      rejecter reject: @escaping RCTPromiseRejectBlock) {
        Task {
            // stopDelivery does not throw so we simply await its completion
            await DoorstepAI.stopDelivery(deliveryId: deliveryId as String)
            resolve(nil)
        }
    }

}
