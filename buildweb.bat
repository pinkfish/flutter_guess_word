flutter build web
xcopy /sy build\web firebase\public
cd firebase
flutter deploy --only hosting