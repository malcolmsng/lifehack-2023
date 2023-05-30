import app from './src/app';
import { env } from './src/config';

app.listen(env.PORT, () => {
  try {
    const logMessage = `Server listening on port ${env.PORT}.`;
    if (env.NODE_ENV === 'development') console.log(logMessage);
  } catch (error) {
    const errorMessage = `Failed to start server due to: ${error}`;
    if (env.NODE_ENV === 'development') console.log(errorMessage);
    process.exit(1);
  }
});

// Uncaught errors
process.on('uncaughtException', (error, origin) => {
  if (env.NODE_ENV === 'development') {
    console.log(`An uncaught error at ${origin}`);
    console.log('Uncaught error', error);
  }
  process.exit(1);
});

// Catching unhandled Promise Rejections
process.on('unhandledRejection', (reason, promise) => {
  if (env.NODE_ENV === 'development') console.log('Uncaught rejection', reason);
  promise.catch((e) => {
    if (env.NODE_ENV === 'development')
      console.log(`The error in promise ${e}`);
  });
});
