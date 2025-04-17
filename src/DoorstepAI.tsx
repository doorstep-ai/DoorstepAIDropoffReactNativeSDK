import { NativeModules, Platform } from 'react-native';
const { DoorstepAI } = NativeModules;

type AddressType = {
  streetNumber: string;
  route: string;
  locality: string;
  administrativeAreaLevel1: string;
  postalCode: string;
};

class DoorstepAIModule {
  static isInitialized = false;

  static async init(): Promise<void> {
    if (Platform.OS === 'android') {
      if (this.isInitialized) {
        return;
      }
      try {
        await DoorstepAI.init();
        console.log('DoorstepAI initialized');
      } catch (error) {
        console.error('Failed to initialize DoorstepAI:', error);
        throw error;
      }
    }
  }

  static setApiKey(apiKey: string) {
    console.log(DoorstepAI);
    DoorstepAI.setApiKey(apiKey);
  }

  static async startDeliveryByPlaceID(placeID: string) {
    DoorstepAI.startDeliveryByPlaceID(placeID)
      .then(() => {
        console.log('Delivery started successfully');
      })
      .catch((error: any) => {
        console.error('Failed to start delivery:', error);
      });
  }

  static startDeliveryByPlusCode(plusCode: string) {
    DoorstepAI.startDeliveryByPlusCode(plusCode)
      .then(() => {
        console.log('Delivery started successfully');
      })
      .catch((error: any) => {
        console.error('Failed to start delivery:', error);
      });
  }

  static startDeliveryByAddress(address: AddressType) {
    DoorstepAI.startDeliveryByAddress(address)
      .then(() => {
        console.log('Delivery started successfully');
      })
      .catch((error: any) => {
        console.error('Failed to start delivery:', error);
      });
  }

  static stopDelivery() {
    DoorstepAI.stopDelivery()
      .then(() => {
        console.log('Delivery stopped successfully');
      })
      .catch((error: any) => {
        console.error('Failed to stop delivery:', error);
      });
  }

  static newEvent(eventName: string) {
    DoorstepAI.newEvent(eventName)
      .then(() => {
        console.log('Event sent successfully');
      })
      .catch((error: any) => {
        console.error('Failed to send event:', error);
      });
  }
}

export { DoorstepAIModule as DoorstepAI };
