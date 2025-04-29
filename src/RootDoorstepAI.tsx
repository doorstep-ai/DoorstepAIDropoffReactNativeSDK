import {
  requireNativeComponent,
  View,
  Platform,
  StyleSheet,
  PermissionsAndroid,
} from 'react-native';

import { useEffect } from 'react';

import { DoorstepAI } from './DoorstepAI';

const DoorstepAIView = requireNativeComponent('RootDoorstepAIView');
export function RootDoorstepAI(props: {
  apiKey: string;
  notificationTitle?: string;
  notificationText?: string;
}) {
  useEffect(() => {
    const initializeAndRequestPermissions = async () => {
      if (Platform.OS === 'android') {
        await DoorstepAI.init(
          props.notificationTitle || '',
          props.notificationText || ''
        );
      }

      DoorstepAI.setApiKey(props.apiKey);

      if (Platform.OS === 'android') {
        try {
          const permissionsToRequest = [
            PermissionsAndroid.PERMISSIONS.ACCESS_FINE_LOCATION,
            PermissionsAndroid.PERMISSIONS.ACTIVITY_RECOGNITION,
          ];

          const granted =
            await PermissionsAndroid.requestMultiple(permissionsToRequest);

          if (
            granted[PermissionsAndroid.PERMISSIONS.ACCESS_FINE_LOCATION] ===
              PermissionsAndroid.RESULTS.GRANTED &&
            granted[PermissionsAndroid.PERMISSIONS.ACTIVITY_RECOGNITION] ===
              PermissionsAndroid.RESULTS.GRANTED
          ) {
            console.log('Required Android permissions granted');
          } else {
            console.warn('One or more required Android permissions denied');
          }
        } catch (err) {
          console.warn('Error requesting Android permissions:', err);
        }
      } else if (Platform.OS === 'ios') {
        console.log(
          'iOS: Ensure location and motion usage descriptions are in Info.plist'
        );
      }
    };

    initializeAndRequestPermissions();
  }, [props.apiKey, props.notificationTitle, props.notificationText]);

  // On iOS, the native view might handle triggering permission prompts if needed.
  // The main setup involves Info.plist configuration.
  return (
    <View style={styles.container}>
      {Platform.OS === 'ios' ? <DoorstepAIView /> : null}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    height: 0,
    width: 0,
  },
});
