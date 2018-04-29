## RUN
To try this sample you need to do the following:

0.

```
git clone https://github.com/ekreutz/react-native-barcode-scanner-google.git
cd ./react-native-barcode-scanner-google/helpersios/sample_ios/
```

1.

```
npm install
```

2.

```
cd ios/
pod install
cd ../
```

3.

```
cp node_modules/react-native-barcode-scanner-google/helpersios/replace.sh .

react-native run-ios #should be failed
./replace.sh
react-native run-ios #should be successful
```

3.1

```
react-native run-ios --device
```
