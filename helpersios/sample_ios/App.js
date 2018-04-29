import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  Alert,
  View
} from 'react-native';
import BarcodeScanner, { BarcodeType } from 'react-native-barcode-scanner-google';

export default class App extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <View style={{flex: 1}}>
        <BarcodeScanner
            style={{
              flex: 1
            }}
            barcodeTypes={BarcodeType.QR_CODE}
            onBarcodeRead={({data, type}) => {
              console.log('onBarcodeRead:', data, type);
              // handle your scanned barcodes here!
              // as an example, we show an alert:
              Alert.alert(`Barcode '${data}' of type '${type}' was scanned.`);
            }}
        />
      </View>
    );
  }
}
