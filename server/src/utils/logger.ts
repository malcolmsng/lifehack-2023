import logger from 'pino';
import dayjs from 'dayjs';

export default logger({
  transport: {
    target: 'pino-pretty',
    options: {
      colorize: true,
    },
  },
  level: 'trace',
  timestamp: () => `,"time":"${dayjs().format()}"`,
});
