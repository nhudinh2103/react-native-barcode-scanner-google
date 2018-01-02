import React, { Component } from 'react';
import { requireNativeComponent } from 'react-native';
import PropTypes from 'prop-types'

class BarcodeScanner extends Component {
  _onBarcodeRead = (event) => {

    if (!this.props.onBarcodeRead) {
      return;
    }

    this.props.onBarcodeRead({data: event.nativeEvent.data, type: event.nativeEvent.type});
  }

  render() {
    return <NativeBarcodeScanner 
      {...this.props}
      onBarcodeRead = {this._onBarcodeRead}
    />
  }
}

BarcodeScanner.propTypes = {
  onBarcodeRead: PropTypes.func
};

const NativeBarcodeScanner = requireNativeComponent('SwiftView', BarcodeScanner);

export default BarcodeScanner;
