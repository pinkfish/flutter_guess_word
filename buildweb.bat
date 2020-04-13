flutter build web
echo "Xcopy"
xcopy /sy build\web firebase\public
echo "cd firebase"
cd firebase
echo "Deploy to hosting"
flutter deploy --only hosting