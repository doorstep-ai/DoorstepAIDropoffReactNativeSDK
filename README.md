# DoorstepAI Dropoff SDK for React Native

The `@doorstepai/dropoff-sdk` provides a set of tools to integrate delivery tracking into your React Native application. This SDK enables seamless coordination between your delivery interface and DoorstepAI's backend systems.

## 📦 Installation

```bash
npm install @doorstepai/dropoff-sdk
```

---

## 🚀 Getting Started

### 1. **Import Components**

```tsx
import {
  RootDoorstepAI,
  DoorstepAI
} from '@doorstepai/dropoff-sdk';
```

### 2. **Add `RootDoorstepAI` to Root File**

Place the following component in the root of your `App.tsx` or main entry file:

```jsx
import { RootDoorstepAI } from "@doorstepai/dropoff-sdk"

const App = () => {
  return (
    <View>
        <RootDoorstepAI 
          apiKey="YOUR_API_KEY_HERE" 
          notificationTitle="Some Notification Title"
          notificationText="Some Notification Text"
        />
        {/** Your App Components */}
  )
}
```

This sets the API key and initializes the SDK when the app launches.

The notification title/text is meant to be passed into the Foreground Service for Android. This alows for greater customization over exact text. 

---

## 📲 Example Usage

Use the SDK's functions to track and update delivery events. Below are common examples using buttons.

```jsx
import { Button } from 'react-native';
import { DoorstepAI } from "@doorstepai/dropoff-sdk"

// Start a delivery using a Google Place ID
<Button title="Start Delivery" onPress={() => {
  DoorstepAI.startDeliveryByPlaceID('destination_place_id', 'delivery_id_1');
}} />

// Start a delivery using an address
<Button title="Start Delivery by Address" onPress={() => {
  const address = {
    streetNumber: '123',
    route: 'Main St',
    subPremise: 'Apt 4B',
    locality: 'New York',
    administrativeAreaLevel1: 'NY',
    postalCode: '10001'
  };
  DoorstepAI.startDeliveryByAddress(address, 'delivery_id_1');
}} />

// Send "taking_pod" event
<Button title="Taking POD" onPress={() => {
  DoorstepAI.newEvent('taking_pod', 'delivery_id_1');
}} />

// Send "pod_captured" event
<Button title="POD Captured" onPress={() => {
  DoorstepAI.newEvent('pod_captured', 'delivery_id_1');
}} />

// End the delivery
<Button title="End Delivery" onPress={() => {
  DoorstepAI.stopDelivery('delivery_id_1');
}} />
```

---

## 🔧 SDK API

### `DoorstepAI.init(): Promise<void>`

Initializes the DoorstepAI module on Android. Automatically handled by `RootDoorstepAI` if used properly.

NOTE: You should never need to call this method directly. 

---

### `DoorstepAI.setApiKey(apiKey: string): void`

Sets the API key to authenticate SDK usage.

---

### `DoorstepAI.startDeliveryByPlaceID(placeID: string, deliveryId: string): Promise<string>`

Starts a delivery using a Google Place ID. Returns a session ID on success.

---

### `DoorstepAI.startDeliveryByPlusCode(plusCode: string, deliveryId: string): Promise<string>`

Starts a delivery using a Google Plus Code. Returns a session ID on success.

---

### `DoorstepAI.startDeliveryByAddress(address: AddressType, deliveryId: string): Promise<string>`

Starts a delivery using a structured address object. Returns a session ID on success.

```ts
type AddressType = {
  streetNumber: string;
  route: string;
  subPremise: string;      // Apartment, suite, unit, etc.
  locality: string;        // City
  administrativeAreaLevel1: string;  // State/Province
  postalCode: string;
}
```

---

### `DoorstepAI.stopDelivery(deliveryId: string): Promise<void>`

Stops the specified delivery.

---

### `DoorstepAI.newEvent(eventName: string, deliveryId: string): Promise<void>`

Sends a delivery-related event for the specified delivery. Supported events include:
- `"taking_pod"`
- `"pod_captured"`

More can be added per vender/customer relationship. 

---

## ✅ Best Practices

- Always wrap `DoorstepAI` API calls in `try/catch` or use `.catch()` for better error handling when applicable.
- Use the `RootDoorstepAI` component only **once** at the **root** of your app.
- Ensure your API key is securely stored and never hardcoded in production.
- Always provide a unique `deliveryId` for each delivery session.
- Keep track of the `deliveryId` throughout the delivery lifecycle as it's required for all operations.

---

## 🧪 Debugging

If something isn't working as expected:

- Check console logs for `DoorstepAI initialized` or error messages.
- Verify that the API key is valid and accepted by the SDK.
- Ensure your permissions (e.g., location) are correctly set up on the device.
- Verify that you're using the correct `deliveryId` for each operation.

---

## 🔐 Permissions

To use the `@doorstepai/dropoff-sdk` effectively, you must include the appropriate permissions in your mobile app's configuration files.

### 📱 iOS

In your `Info.plist`, include the following usage descriptions:

```xml
<!-- Location Usage Descriptions -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app requires access to your location for delivery tracking.</string>
<key>NSLocationAlwaysAndWhenInUseUsage</key>
<string>This app requires access to your location to provide continuous tracking even in the background.</string>

<!-- Optional: Motion & Sensor Data (if applicable) -->
<key>NSMotionUsageDescription</key>
<string>This app uses motion data to enhance delivery tracking accuracy.</string>

<!-- Background Location Mode -->
<key>UIBackgroundModes</key>
<array>
    <string>location</string>
</array>
```

### 🤖 Android

In your `AndroidManifest.xml`, include the following permissions:

```xml
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
<uses-permission android:name="android.permission.HIGH_SAMPLING_RATE_SENSORS" />
<uses-permission android:name="android.permission.ACTIVITY_RECOGNITION" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
<uses-permission android:name="android.permission.WAKE_LOCK" />

<uses-feature android:name="android.hardware.sensor.accelerometer" />
<uses-feature android:name="android.hardware.sensor.gyroscope" />
<uses-feature android:name="android.hardware.sensor.barometer" />
<uses-feature android:name="android.hardware.sensor.compass" />
<uses-feature android:name="android.hardware.sensor.proximity" />
```

These permissions enable accurate location and motion tracking during delivery sessions.

---
