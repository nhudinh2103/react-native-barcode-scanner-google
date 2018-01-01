import React, { Component } from 'react';
import { requireNativeComponent } from 'react-native';
import PropTypes from 'prop-types'

class BarcodeScanner extends Component {
  _onBarcodeRead = (event) => {

    if (!this.props.onBarcodeRead) {
      return;
    }

    this.props.onBarcodeRead(event.nativeevent);
  }

  render() {
    return <NativeBarcodeScanner {...this.props} />
  }
}

BarcodeScanner.propTypes = {
  onBarcodeRead: PropTypes.func
};

const NativeBarcodeScanner = requireNativeComponent('SwiftView', BarcodeScanner);

export default BarcodeScanner;
