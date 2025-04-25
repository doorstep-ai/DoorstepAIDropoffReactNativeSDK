package com.doorstepai.dropoffsdk

import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import com.doorstepai.sdks.tracking.DoorstepAI
import com.doorstepai.sdks.tracking.AddressType
import com.facebook.react.bridge.ReadableMap

class DoorstepAIModule(private val reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  override fun getName(): String {
    return NAME
  }

  @ReactMethod
  fun init(promise: Promise) {
    try {
      DoorstepAI.init(reactContext) { result ->
        result.onSuccess {
          promise.resolve(true)
        }.onFailure { error ->
          promise.reject("INIT_ERROR", error.message ?: "Promise Rejection: Failed to initialize DoorstepAI")
        }
      }
    } catch (e: Exception) {
      promise.reject("INIT_ERROR", e.message ?: "Failed to initialize DoorstepAI")
    }
  }

  @ReactMethod
  fun startDeliveryByPlaceID(placeID: String, deliveryId: String, promise: Promise) {
    try {
      DoorstepAI.startDeliveryByPlaceID(placeID, deliveryId) { result ->
        result.onSuccess { sessionId ->
          promise.resolve(sessionId)
        }.onFailure { error ->
          promise.reject("DELIVERY_ERROR", error.message ?: "Promise Rejection: Failed to start delivery by Place ID")
        }
      }
    } catch (e: Exception) {
      promise.reject("DELIVERY_ERROR", e.message ?: "Failed to start delivery by Place ID")
    }
  }

  @ReactMethod
  fun startDeliveryByPlusCode(plusCode: String, deliveryId: String, promise: Promise) {
    try {
      DoorstepAI.startDeliveryByPlusCode(plusCode, deliveryId) { result ->
        result.onSuccess { sessionId ->
          promise.resolve(sessionId)
        }.onFailure { error ->
          promise.reject("DELIVERY_ERROR", error.message ?: "Promise Rejection: Failed to start delivery by Plus Code")
        }
      }
    } catch (e: Exception) {
      promise.reject("DELIVERY_ERROR", e.message ?: "Failed to start delivery by Plus Code")
    }
  }

  @ReactMethod
  fun startDeliveryByAddress(
    addressMap: ReadableMap,
    deliveryId: String,
    promise: Promise
  ) {
    try {
      val streetNumber = addressMap.getString("streetNumber") ?: ""
      val route = addressMap.getString("route") ?: ""
      val subPremise = addressMap.getString("subPremise") ?: ""
      val locality = addressMap.getString("locality") ?: ""
      val administrativeAreaLevel1 = addressMap.getString("administrativeAreaLevel1") ?: ""
      val postalCode = addressMap.getString("postalCode") ?: ""

      val address = AddressType(
        streetNumber = streetNumber,
        route = route,
        subPremise = subPremise,
        locality = locality,
        administrativeAreaLevel1 = administrativeAreaLevel1,
        postalCode = postalCode
      )

      DoorstepAI.startDeliveryByAddressType(address, deliveryId) { result ->
        result.onSuccess { sessionId ->
          promise.resolve(sessionId)
        }.onFailure { error ->
          promise.reject("DELIVERY_ERROR", error.message ?: "Promise Rejection: Failed to start delivery by address")
        }
      }
    } catch (e: Exception) {
      promise.reject("DELIVERY_ERROR", e.message ?: "Failed to start delivery by address")
    }
  }

  @ReactMethod
  fun newEvent(eventName: String, deliveryId: String, promise: Promise) {
    try {
      DoorstepAI.newEvent(eventName, deliveryId) { result ->
        result.onSuccess { eventResponse ->
          promise.resolve(eventResponse)
        }.onFailure { error ->
          promise.reject("EVENT_CREATION_ERROR", error.message ?: "Promise Rejection: Failed to save event")
        }
      }
    } catch (e: Exception) {
      promise.reject("EVENT_CREATION_ERROR", e.message ?: "Failed to save event")
    }
  }

  @ReactMethod
  fun stopDelivery(deliveryId: String, promise: Promise) {
    try {
      DoorstepAI.stopDelivery(deliveryId)
      promise.resolve(true)
    } catch (e: Exception) {
      promise.reject("DELIVERY_STOP_ERROR", e.message ?: "Failed to stop delivery")
    }
  }

  @ReactMethod(isBlockingSynchronousMethod = true)
  fun setApiKey(key: String) {
    DoorstepAI.setAPIKey(key)
  }

  @ReactMethod
  fun setDevMode(devModeEnabled: Boolean) {
    DoorstepAI.devMode = devModeEnabled
  }

  companion object {
    const val NAME = "DoorstepAI"
  }
}
