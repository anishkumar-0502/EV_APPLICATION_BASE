# icon

changing icon

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## How to change app icon and its name

## icon

1 = covert the logo image with same height and width (ex:500 * 500)
2 = convert the icon which supports android by using android asset studio and customize the icon and download the icon - (ic_launcher)
3 = extract the downloaded file (ic_launcher) - copy all the files at folder (res)
4= open the current file for which the icon should be changed and open the files according to the following directory
(android [icon_android] - app - src - main -res)
5 = In res folder paste the copied files replace it .

## icon_name

1=  open the current file for which the name should be changed and open the files according to the following directory
(android [icon_android] - app - src - main - AndroidManifest.xml)
2= In AndroidManifest.xml file ( 3rd line =  android:label=(eg:"Folder_name")) in that label we have to change the app name 

Finally stop the emulator and start 


