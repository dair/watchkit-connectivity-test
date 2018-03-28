# iOS WatchKit Connectivity test

Purpose of the test is to show malfunctioning of documented iOS/WatchOS connectivity using [`updateApplicationContext:error:`](https://developer.apple.com/documentation/watchconnectivity/wcsession/1615621-updateapplicationcontext?language=objc) method.

## iOS Application
iOS Application interface has one [`UILabel`](https://developer.apple.com/documentation/uikit/uilabel?language=objc) and one [`UIButton`](https://developer.apple.com/documentation/uikit/uibutton?language=objc); Tapping the button causes the number in label to increment, also sending the number to WatchKit Extension using [`WKSession`](https://developer.apple.com/documentation/watchconnectivity/wcsession?language=objc) [`updateApplicationContext:error:`](https://developer.apple.com/documentation/watchconnectivity/wcsession/1615621-updateapplicationcontext?language=objc) method.

On receiving [session:didReceiveApplicationContext:](https://developer.apple.com/documentation/watchconnectivity/wcsessiondelegate/1615619-session?language=objc) the iOS Application sets the received number to label.

## WatchKit Extension
WatchKit Extension has one [`WKInterfaceLabel`](https://developer.apple.com/documentation/watchkit/wkinterfacelabel?language=objc) and one [`WKInterfaceButton`](https://developer.apple.com/documentation/watchkit/wkinterfacebutton?language=objc).

Tapping the button causes the number to decrement, also sending the number to iOS counterpart using [`WKSession`](https://developer.apple.com/documentation/watchconnectivity/wcsession?language=objc) [`updateApplicationContext:error:`](https://developer.apple.com/documentation/watchconnectivity/wcsession/1615621-updateapplicationcontext?language=objc) method.

On receiving [session:didReceiveApplicationContext:](https://developer.apple.com/documentation/watchconnectivity/wcsessiondelegate/1615619-session?language=objc) the WatchKit Extension sets the received number on label and also raises a local notification using UNNotificationRequest in case of WatchKit application is in background.

## Issue
Both iOS Application and WatchOS Extension works fine on both iOS/WatchOS Simulator and real devices when both applications are on foreground.

Sending WatchOS Extension to background (by tapping crown on watch) makes behavior vary on Simulator and real devices.

On simulator, when WatchKit App is in background, tapping the iOS App button causes Watch Simulator to raise a notification just as planned.

On real devices, when Watch App is in background, tapping the iOS App button does not affect WatchKit Extension at all in reasonable time. Watch App receives the context on launch.

That is direct condradiction to [Apple's documentation](https://developer.apple.com/library/content/documentation/General/Conceptual/WatchKitProgrammingGuide/SharingData.html) that mentions:

> Data is transferred in the background at an appropriate time to minimize power usage. Transfers may happen at any time, including when neither app is running.

> This method supports background transfers.
