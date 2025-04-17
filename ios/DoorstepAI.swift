import Foundation
import React
import DoorstepDropoffSDK

@objc(DoorstepAI)
class DoorstepAIBridge: NSObject {

    @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }

  @objc
  func setApiKey(_ apiKey: String) {
    DoorstepAI.setApiKey(key: apiKey)
  }

  @objc
  func startDeliveryByPlaceID(_ placeID: NSString,
                              resolver resolve: @escaping RCTPromiseResolveBlock,
                              rejecter reject: @escaping RCTPromiseRejectBlock) {
    // Use Swift's concurrency support to call the async method.
    Task {
      do {
        try await DoorstepAI.startDeliveryByPlaceID(placeID: placeID as String)
        resolve(nil)
      } catch {
        reject("E_START_DELIVERY", "Failed to start delivery by Place ID: \(error.localizedDescription)", error)
      }
    }
  }

  @objc
  func startDeliveryByPlusCode(_ plusCode: NSString,
                               resolver resolve: @escaping RCTPromiseResolveBlock,
                               rejecter reject: @escaping RCTPromiseRejectBlock) {
    Task {
      do {
        try await DoorstepAI.startDeliveryByPlusCode(plusCode: plusCode as String)
        resolve(nil)
      } catch {
        reject("E_START_DELIVERY", "Failed to start delivery by Plus Code: \(error.localizedDescription)", error)
      }
    }
                               }

     @objc
  func startDeliveryByAddress(_ addressJSON: NSString,
                              resolver resolve: @escaping RCTPromiseResolveBlock,
                              rejecter reject: @escaping RCTPromiseRejectBlock) {
      guard let data = (addressJSON as String).data(using: .utf8) else {
          reject("E_INVALID_ADDRESS", "Invalid JSON string format.", nil)
          return
      }

      Task {
        do {
            guard let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                  let streetNumber = jsonObject["streetNumber"] as? String,
                  let route = jsonObject["route"] as? String,
                  let locality = jsonObject["locality"] as? String,
                  let administrativeAreaLevel1 = jsonObject["administrativeAreaLevel1"] as? String,
                  let postalCode = jsonObject["postalCode"] as? String else {
                reject("E_INVALID_ADDRESS", "Missing or invalid fields in address JSON.", nil)
                return
            }

            let address = AddressType(streetNumber: streetNumber,
                                        route: route,
                                        locality: locality,
                                        administrativeAreaLevel1: administrativeAreaLevel1,
                                        postalCode: postalCode)

            try await DoorstepAI.startDeliveryByAddressType(address: address)
            resolve(nil)
        } catch let error as DoorstepAIError {
             reject("E_START_DELIVERY", "Failed to start delivery by address: \(error.localizedDescription)", error)
        } catch {
            reject("E_JSON_PARSING", "Failed to parse address JSON: \(error.localizedDescription)", error)
        }
      }
  }

  @objc
  func newEvent(_ eventName: NSString,
                resolver resolve: @escaping RCTPromiseResolveBlock,
                rejecter reject: @escaping RCTPromiseRejectBlock) {
      Task {
          do {
              try await DoorstepAI.newEvent(eventName: eventName as String)
              resolve(nil)
          } catch {
              reject("E_NEW_EVENT", "Failed to send event: \(error.localizedDescription)", error)
          }
      }
  }

  @objc
  func stopDelivery(_ resolve: @escaping RCTPromiseResolveBlock,
                    rejecter reject: @escaping RCTPromiseRejectBlock) {
    Task {
      // stopDelivery does not throw so we simply await its completion
      await DoorstepAI.stopDelivery()
      resolve(nil)
    }
  }

}
