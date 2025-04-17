package com.doorstepai.dropoffsdk

import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import com.doorstepai.sdks.tracking.DoorstepAI
import com.doorstepai.sdks.tracking.AddressType

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
  fun startDeliveryByPlaceID(placeID: String, promise: Promise) {
    try {
      DoorstepAI.startDeliveryByPlaceID(placeID) { result ->
        result.onSuccess {
          promise.resolve(true)
        }.onFailure { error ->
          promise.reject("DELIVERY_ERROR", error.message ?: "Promise Rejection: Failed to start delivery")
        }
      }
    } catch (e: Exception) {
      promise.reject("DELIVERY_ERROR", e.message ?: "Failed to start delivery")
    }
  }

  @ReactMethod
  fun startDeliveryByPlusCode(plusCode: String, promise: Promise) {
    try {
      DoorstepAI.startDeliveryByPlusCode(plusCode) { result ->
        result.onSuccess {
          promise.resolve(true)
        }.onFailure { error ->
          promise.reject("DELIVERY_ERROR", error.message ?: "Promise Rejection: Failed to start delivery")
        }
      }
    } catch (e: Exception) {
      promise.reject("DELIVERY_ERROR", e.message ?: "Failed to start delivery")
    }
  }

  @ReactMethod
  fun startDeliveryByAddress(
    streetNumber: String,
    route: String,
    locality: String,
    administrativeAreaLevel1: String,
    postalCode: String,
    promise: Promise
  ) {
    try {
      val address = AddressType(
        streetNumber = streetNumber,
        route = route,
        locality = locality,
        administrativeAreaLevel1 = administrativeAreaLevel1,
        postalCode = postalCode
      )
      DoorstepAI.startDeliveryByAddressType(address) { result ->
        result.onSuccess {
          promise.resolve(true)
        }.onFailure { error ->
          promise.reject("DELIVERY_ERROR", error.message ?: "Promise Rejection: Failed to start delivery by address")
        }
      }
    } catch (e: Exception) {
      promise.reject("DELIVERY_ERROR", e.message ?: "Failed to start delivery by address")
    }
  }

  @ReactMethod
  fun newEvent(eventName: String, promise: Promise) {
    try {
      DoorstepAI.newEvent(eventName) { result ->
        result.onSuccess {
          promise.resolve(true)
        }.onFailure { error ->
          promise.reject("EVENT CREATION ERROR", error.message ?: "Promise Rejection: Failed to save event")
        }
      }
    } catch (e: Exception) {
      promise.reject("EVENT CREATION ERROR", e.message ?: "Failed to save event")
    }
  }

  @ReactMethod
  fun stopDelivery(promise: Promise) {
    try {
      DoorstepAI.stopDelivery()
      promise.resolve(true)
    } catch (e: Exception) {
      promise.reject("DELIVERY STOP", e.message ?: "Failed to stop delivery")
    }
  }

  @ReactMethod(isBlockingSynchronousMethod = true)
  fun setApiKey(key: String) {
    DoorstepAI.setAPIKey(key)
  }

  companion object {
    const val NAME = "DoorstepAI"
  }
}
