import { NativeModules, Platform } from 'react-native';
const { DoorstepAI } = NativeModules;

type AddressType = {
  streetNumber: string;
  route: string;
  subPremise: string;
  locality: string;
  administrativeAreaLevel1: string;
  postalCode: string;
};

class DoorstepAIModule {
  static isInitialized = false;

  static enableDevMode() {
    DoorstepAI.setDevMode(true);
  }

  static async init(
    notificationTitle?: string,
    notificationText?: string
  ): Promise<void> {
    if (Platform.OS === 'android') {
      if (this.isInitialized) {
        return;
      }
      try {
        await DoorstepAI.init(notificationTitle, notificationText);
        console.log('DoorstepAI initialized');
        this.isInitialized = true; // Mark as initialized on success
      } catch (error) {
        console.error('Failed to initialize DoorstepAI:', error);
        throw error;
      }
    } // iOS does not require explicit init in the bridge
  }

  static setApiKey(apiKey: string) {
    DoorstepAI.setApiKey(apiKey);
  }

  // Add deliveryId parameter
  static async startDeliveryByPlaceID(placeID: string, deliveryId: string) {
    try {
      const result = await DoorstepAI.startDeliveryByPlaceID(
        placeID,
        deliveryId
      );
      console.log('Delivery started successfully by Place ID:', result);
      return result; // Return result (e.g., session ID from Android)
    } catch (error: any) {
      console.error('Failed to start delivery by Place ID:', error);
      throw error; // Re-throw error for caller handling
    }
  }

  // Add deliveryId parameter
  static async startDeliveryByPlusCode(plusCode: string, deliveryId: string) {
    try {
      const result = await DoorstepAI.startDeliveryByPlusCode(
        plusCode,
        deliveryId
      );
      console.log('Delivery started successfully by Plus Code:', result);
      return result;
    } catch (error: any) {
      console.error('Failed to start delivery by Plus Code:', error);
      throw error;
    }
  }

  // Add deliveryId parameter and handle platform difference
  static async startDeliveryByAddress(
    address: AddressType,
    deliveryId: string
  ) {
    try {
      let result = await DoorstepAI.startDeliveryByAddress(address, deliveryId);
      console.log('Delivery started successfully by Address:', result);
      return result;
    } catch (error: any) {
      console.error('Failed to start delivery by Address:', error);
      throw error;
    }
  }

  // Add deliveryId parameter
  static async stopDelivery(deliveryId: string) {
    try {
      await DoorstepAI.stopDelivery(deliveryId);
      console.log('Delivery stopped successfully');
    } catch (error: any) {
      console.error('Failed to stop delivery:', error);
      throw error;
    }
  }

  // Add deliveryId parameter
  static async newEvent(eventName: string, deliveryId: string) {
    try {
      const result = await DoorstepAI.newEvent(eventName, deliveryId);
      console.log('Event sent successfully:', result);
      return result;
    } catch (error: any) {
      console.error('Failed to send event:', error);
      throw error;
    }
  }
}

export { DoorstepAIModule as DoorstepAI };
