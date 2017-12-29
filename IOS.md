#IOS WIP
Currently it's only exposition CameraViewController from
<https://github.com/googlesamples/ios-vision/tree/master/BarcodeDetectorDemo>

#RUN
To try IOS extension you need to do the following:

1.
```
npm install git+https://github.com/sbobykin/react-native-barcode-scanner-google.git#ios --save
```

2.
```
react-native link react-native-barcode-scanner-google
```

3.
Install CocoaPods and do the following in you project root.

```
cp node_modules/react-native-barcode-scanner-google/helpersios/Podfile ios/
```

Open copied Podfile and change name of the target `your_project_name` into your project name.
After that run.

```
cd ios
pod install
```

4.
Run xcode using the following command in your project root.
```
open ios/<your_project_name>.xcworkspace
```

In xcode:

* create new (dummy) swift file (without adding bridge header)

* move (using mouse) Libraries/RNBSG.xcodeproj/RNBSG/GMVBD.storyboard into your main IOS project.
(it should be reference only) 

* add key with name 'Privacy - Camera Usage Description' into 'info.plist' with value describing the reason for camera usage.

5.
In your project root run

```
cp node_modules/react-native-barcode-scanner-google/helpersios/replace.sh .

react-native run-ios #should be failed
./replace.sh
react-native run-ios #should be successful
```
