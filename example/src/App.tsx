import { DoorstepAI, RootDoorstepAI } from '@doorstepai/dropoff-sdk';
import { View, StyleSheet, Button } from 'react-native';

export default function App() {
  return (
    <View style={styles.container}>
      <RootDoorstepAI apiKey="your_api_key" />
      <Button
        title="Start Delivery"
        onPress={() => {
          DoorstepAI.startDeliveryByPlaceID('destination_place_id', 'id_1');
        }}
      />

      <View style={styles.spacer} />
      <Button
        title="Stop Delivery"
        onPress={() => {
          DoorstepAI.stopDelivery('id_1');
        }}
      />
      <View style={styles.spacer} />
      <Button
        title="New Event"
        onPress={() => {
          DoorstepAI.newEvent('event_name', 'id_1');
        }}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  spacer: {
    height: 20,
  },
});
