import { DoorstepAI, RootDoorstepAI } from '@doorstepai/dropoff-sdk';
import { View, StyleSheet, Button } from 'react-native';

export default function App() {
  return (
    <View style={styles.container}>
      <RootDoorstepAI apiKey="some_api_key" />
      <Button
        title="Start Delivery"
        onPress={() => {
          DoorstepAI.startDeliveryByPlaceID('your_place_id');
        }}
      />

      <View />
      <Button
        title="Stop Delivery"
        onPress={() => {
          DoorstepAI.stopDelivery();
        }}
      />
      <View />
      <Button
        title="New Event"
        onPress={() => {
          DoorstepAI.newEvent('your_event_name');
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
});
