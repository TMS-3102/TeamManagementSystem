import firebase from 'firebase/app';
import 'firebase/auth';
import 'firebase/firestore';

var firebaseConfig = {
    apiKey: "AIzaSyBb5IMCqeK3zYynwYCqwRS6pFQUTPVJuo4",
    authDomain: "quick-teams.firebaseapp.com",
    databaseURL: "https://quick-teams.firebaseio.com",
    projectId: "quick-teams",
    storageBucket: "quick-teams.appspot.com",
    messagingSenderId: "1054017626212",
    appId: "1:1054017626212:web:ad897665dddec0488d7f71"
};

firebase.initializeApp(firebaseConfig);
firebase.firestore().settings({timestampsInSnapshots: true});

export default firebase;