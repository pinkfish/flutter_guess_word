import * as functions from 'firebase-functions';

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
export const serverTime = functions.https.onRequest((request, response) => {
 response.send(const now= Timestamp.now().toString());
});
