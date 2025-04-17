import {
  requireNativeComponent,
  View,
  Platform,
  StyleSheet,
} from 'react-native';

import { useEffect } from 'react';

import { DoorstepAI } from './DoorstepAI';

const DoorstepAIView = requireNativeComponent('RootDoorstepAIView');
export function RootDoorstepAI(props: { apiKey: string }) {
  useEffect(() => {
    (async () => {
      if (Platform.OS === 'android') {
        await DoorstepAI.init();
      }
      DoorstepAI.setApiKey(props.apiKey);
    })();
  }, [props.apiKey]);
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
