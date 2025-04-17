
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
        <RootDoorstepAI apiKey="YOUR_API_KEY_HERE" />
        {/** Your App Components */}
  )
}
```

This sets the API key and initializes the SDK when the app launches.

---

## 📲 Example Usage

Use the SDK's functions to track and update delivery events. Below are common examples using buttons.

```jsx
import { Button } from 'react-native';
import { DoorstepAI } from "@doorstepai/dropoff-sdk"

// Start a delivery using a Google Place ID
<Button title="Start Delivery" onPress={() => {
  DoorstepAI.startDeliveryByPlaceID("213");
}} />

// Send "taking_pod" event
<Button title="Taking POD" onPress={() => {
  DoorstepAI.newEvent("taking_pod");
}} />

// Send "pod_captured" event
<Button title="POD Captured" onPress={() => {
  DoorstepAI.newEvent("pod_captured");
}} />

// End the delivery
<Button title="End Delivery" onPress={() => {
  DoorstepAI.stopDelivery();
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

### `DoorstepAI.startDeliveryByPlaceID(placeID: string): Promise<void>`

Starts a delivery using a Google Place ID.

---

### `DoorstepAI.startDeliveryByPlusCode(plusCode: string): Promise<void>`

Starts a delivery using a Google Plus Code.

---

### `DoorstepAI.startDeliveryByAddress(address: AddressType): Promise<void>`

Starts a delivery using a structured address object.

```ts
type AddressType = {
  streetNumber: string;
  route: string;
  locality: string;
  administrativeAreaLevel1: string;
  postalCode: string;
}
```

---

### `DoorstepAI.stopDelivery(): Promise<void>`

Stops the current delivery.

---

### `DoorstepAI.newEvent(eventName: string): Promise<void>`

Sends a delivery-related event. Supported events include:
- `"taking_pod"`
- `"pod_captured"`

More can be added per vender/customer relationship. 

---

## ✅ Best Practices

- Always wrap `DoorstepAI` API calls in `try/catch` or use `.catch()` for better error handling when applicable.
- Use the `RootDoorstepAI` component only **once** at the **root** of your app.
- Ensure your API key is securely stored and never hardcoded in production.

---

## 🧪 Debugging

If something isn't working as expected:

- Check console logs for `DoorstepAI initialized` or error messages.
- Verify that the API key is valid and accepted by the SDK.
- Ensure your permissions (e.g., location) are correctly set up on the device.

---

---

## 🔐 Permissions

To use the `@doorstepai/dropoff-sdk` effectively, you must include the appropriate permissions in your mobile app's configuration files.

### 📱 iOS

In your `Info.plist`, include the following usage descriptions:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app requires access to your location while in use to track deliveries.</string>

<key>NSLocationAlwaysUsageDescription</key>
<string>This app requires continuous location access to ensure accurate delivery tracking.</string>

<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>This app requires location access at all times to support delivery tracking.</string>

<key>NSMotionUsageDescription</key>
<string>This app uses motion data to improve delivery tracking accuracy.</string>
```

### 🤖 Android

In your `AndroidManifest.xml`, include the following permissions:

```xml
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
<uses-permission android:name="android.permission.HIGH_SAMPLING_RATE_SENSORS" />

<uses-feature android:name="android.hardware.sensor.accelerometer" />
<uses-feature android:name="android.hardware.sensor.gyroscope" />
<uses-feature android:name="android.hardware.sensor.barometer" />
<uses-feature android:name="android.hardware.sensor.compass" />
<uses-feature android:name="android.hardware.sensor.proximity" />
```

These permissions enable accurate location and motion tracking during delivery sessions.

---
