# Assignment

An iOS application which shows the list of items.  It uses CoreData Framework for storing the items offline. If application contains offline records then offline records will be shown otherwise API call will made to fetch the records from server.
User can navigate to detail page of an item by selecting it in the list. Detail Page shows the details along with the delivery location on Google map.

# Requirements

* Xcode 10.2, iOS 12.2 SDK or later, OS X 10.14 or later.
* A Google API Key.
* A Fabric account for crashlytics and Fabric API Key.


# Installation

- Clone the repository to your local machine
- Run pod install in your terminal(open terminal -> set path to your repository's directory -> run pod install)
- Replace your Google API Key in constant file with "GOOGLE_API_KEY"
- Replace Your Fabric API Key in info.plist with "FABRIC_API_KEY"(if you want to use crashlytics)


# Support Version

*  iOS 10.x or later


# Language

* Swift 5


# Design Pattern

MVVM

<img width="1060" alt="FlowChart" src="https://user-images.githubusercontent.com/31096930/58014904-91144600-7b17-11e9-846d-4390e856101b.png">



* Model: Model is being used for storing the data returned from local storage and api. 
Modal is interacting with two layers:
1. CoreDataManager: It performs all database related operations and provides the required output to ViewModel.
2. APIManager: It interacts with server and returns back to the ViewModel with received JSON response.

* View: View presents all user interface elements. The view layer interacts with ViewModel to get the data which is to be shown on UI.
* ViewModel: This layer is the mediator between the View and Model, through which data flows from the Model to the View and vice versa. it contains all the business logic and inform the view through Delegation.   


# Version

1.0


# Pods

* Alamofire
* SwiftyJSON
* GoogleMaps
* GooglePlaces
* SDWebImage
* SwiftLint
* OHHTTPStubs/Swift
* Fabric
* Crashlytics


# Data Caching

* Core Data is used for offline storage of items.
* For image cache, SDWebImage is used. It is an async image downloader with cache support.
* It has “Pull to Refresh” functionality which will always return the updated data from server.


# Crashlytics

Fabric Crashlytics has been already integrated in the application to get the crash reports. All the crash reports can be checked on fabric dashboard. Follow the below steps and just replace the Fabric API Key in info.plist file
1. Create an account here: https://fabric.io/kits/ios/crashlytics/install and register the app.
2. follow the steps on the given link.
3. Replace the Fabric API Key in info.plist file.


# SwiftLint

It is tool to enforce Swift style and conventions. It is integrated using CocoaPod.
Any changes can be made in .swiftlint.yml file, which is located in project root folder.

# Features

1. Data caching (SDWebImage, CoreData)
2. Supports local storage using Core Data
3. "Pull to Refresh" functionality
4. It has pagination feature.
5. It Shows location of Delivery Location on Google Map.

# Assumptions

1. It is iPhone specific app and supports iPhone 5s or later devices
2. It supports iOS version 10.x or later
3. Device orientation is limited to portrait mode only.
4. If any existing record will be updated on server then it will also be updated in local storage only after fetching the          
   updated data from server


# Screenshots
![Simulator Screen Shot - iPhone 8 - 2019-05-21 at 17 56 47](https://user-images.githubusercontent.com/31096930/58096217-33086100-7bf2-11e9-9927-fb488a33d101.png)

![Simulator Screen Shot - iPhone 8 - 2019-05-21 at 18 07 29](https://user-images.githubusercontent.com/31096930/58096724-5aabf900-7bf3-11e9-9cb6-67e43607820e.png)

# Unit Testing
* Unit Test cases are written using XCTestCase
* Test cases cover the Core Data, API, View and ViewModel module.


# Improvements
1. UI test cases can be covered
2. Localisation feature can be added
3. Unit Test cases can be covered more.
4. Detail View on marker tap can be customised. 










