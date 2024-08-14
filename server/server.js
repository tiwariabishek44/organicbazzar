const express = require('express');
const admin = require('firebase-admin');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

// Middleware to parse JSON request bodies
app.use(bodyParser.json());

// Initialize Firebase Admin SDK
const serviceAccount = require('../android/organicbazzar-18d9f-firebase-adminsdk-680n9-fd5b9f1cf8.json');
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://organicbazzar-18d9f-default-rtdb.asia-southeast1.firebasedatabase.app'
});

const messaging = admin.messaging();

// Function to send notifications
async function sendMulticastNotifications(tokens, notification) {
  if (tokens.length <= 500) {
    const response = await messaging.sendMulticast({
      tokens,
      notification,
    });
    console.log('Successfully sent notifications:', response.successCount);
    console.log('Failed tokens:', response.failureCount);
  } else {
    const chunks = [];
    for (let i = 0; i < tokens.length; i += 500) {
      chunks.push(tokens.slice(i, i + 500));
    }
    for (const chunk of chunks) {
      await sendMulticastNotifications(chunk, notification);
    }
  }
}

// Define POST route for sending notifications
app.post('/send-notification', async (req, res) => {
  const {  title, body } = req.body;

  if ( !title || !body) {
    return res.status(400).send('Missing required fields: tokens, title, body');
  }

  const notification = {
    title,
    body,
  };

  try {
    tokens=['cAFk4RSYS5iDSd7yCKhC7X:APA91bH8n2ti3I2It5hA9DfIoX1adwUgKmSXNjCiD0qOacLhFYEF7Vu9K05Gq3o70c74CkuGOogI2D7smvxf0Ehlz90rktrUnPRQG8QjOXhP8LaoR-NfmnoKAcPI93tnmQ3Ix9iQaJQF']
    await sendMulticastNotifications(tokens, notification);
    res.status(200).send('Notifications sent successfully');
  } catch (error) {
    console.error('Error sending notifications:', error);
    res.status(500).send('Error sending notifications');
  }
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
