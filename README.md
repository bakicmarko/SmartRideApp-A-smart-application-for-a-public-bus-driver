# SmartRideApp-A-smart-application-for-a-public-bus-driver
Digitalized transit has become a key part of transit accessibility and the way of movement. With its development, new terms like on-demand services and mobility as a service, MaaS emerge. On-demand service in transit represents a type of service which allows the passenger to control the main parts of the travel, while mobility as a service combines already existing solutions of public and private digitalized transit into a unique system in which the passenger is enabled to organize the travel in its entirety. In this thesis, research of existing solutions for digitalized transit has been conducted and a solution for digitalizing transit for bus drivers has been modeled. Based on the presented model, the design has been implemented in Figma and the prototype of the mobile application has been built in Flutter.


## Setup

To install and run this app you need to install Flutter and Android Studio or VS Code editor.

  - Flutter: [https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install).
  - Android Studio: [https://developer.android.com/studio/install](https://developer.android.com/studio/install)
      - Create virtual device: [https://developer.android.com/studio/run/managing-avds](https://developer.android.com/studio/run/managing-avds)

- VS Code: [https://code.visualstudio.com/](https://code.visualstudio.com/) 


## Run application in terminal

- start Android Virtual Device
- position yourself in project directory

    `cd <PROJECT_FOLDER>`

- run command to get required packages

    `flutter pub get`

- next, run application  with

    `flutter run`

- if you have more than one AVD running, you will be asked to choose on which one you want your application to run, enter number of AVD and continue

- building will take some time, few minutes at least, after building is done app will automatically start


## Application screens


<div style="display: flex; justify-content: center;">
  <div style="margin: 10px; text-align: center;">
    <img src="assets/figma/screens/SplashScreenArt.png" alt="Splash screen" style="width: 30%;">
    <p>Splash screen</p>
  </div>
  <div style="margin: 10px; text-align: center;">
    <img src="assets/figma/screens/LoginScreenArt2.png" alt="Login screen" style="width: 30%;">
    <p>Login screen</p>
  </div>
</div>

<hr>

<div style="display: flex; justify-content: center;">
  <div style="margin: 10px; text-align: center;">
    <img src="assets\figma\screens\HomeScreenFixed.png" alt="Home screen #1" style="width: 90%;">
    <p>Home screen #1</p>
  </div>
  <div style="margin: 10px; text-align: center;">
    <img src="assets\figma\screens\HomeScreenFlexible.png" alt="Home screen #2" style="width: 90%;">
    <p>Home screen #2</p>
  </div>
  <div style="margin: 10px; text-align: center;">
    <img src="assets\figma\screens\HomeScreenRequest.png" alt="Request pop up" style="width: 90%;">
    <p>Request pop up</p>
  </div>
  
</div>

<hr>

<div style="display: flex; justify-content: center;">
  
  <div style="margin: 10px; text-align: center;">
    <img src="assets\figma\screens\HomeScreenExpandedFixed.png" alt="Status & weather" style="width: 90%;">
    <p>Status & weather</p>
  </div>
  
  <div style="margin: 10px; text-align: center;">
    <img src="assets\figma\screens\DriversScreen.png" alt="Drivers screen" style="width: 90%;">
    <p>Drivers screen</p>
  </div>

  <div style="margin: 10px; text-align: center;">
    <img src="assets\figma\screens\RequestListScreen.png" alt="History" style="width: 90%;">
    <p>History</p>
  </div>
</div>

<hr>

<div style="display: flex; justify-content: center;">
  <div style="margin: 10px; text-align: center;">
    <img src="assets\figma\screens\RoutePopUpScreen.png" alt="Route list screen" style="width: 90%;">
    <p>Route list screen</p>
  </div>
  <div style="margin: 10px; text-align: center;">
    <img src="assets\figma\screens\SideMenuScreen.png" alt="Login screen" style="width: 90%;">
    <p>Navigation screen</p>
  </div>
</div>


## Project architecture
Simplified project architecture overview.


 <div style="margin: 10px; text-align: center;">
    <img src="assets\figma\architecture\architecture.jpg" alt="Project architecture" style="width: 90%;">
    <p>Flutter project overview</p>
  </div>




