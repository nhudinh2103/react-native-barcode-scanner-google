## RUN
To try this sample you need to do the following:

1.

```
npm install
```

2.

```
cd ios/
pod install
```

3.

In your project root run

```
cp node_modules/react-native-barcode-scanner-google/helpersios/replace.sh .

react-native run-ios #should be failed
./replace.sh
react-native run-ios #should be successful
```
