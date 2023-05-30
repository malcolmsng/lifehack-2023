import type { RequestHandler } from 'express';
import { env } from '../config';
import dayjs from 'dayjs';

const benchmarkController: RequestHandler = (_, res) => {
  let ss = process.uptime();
  const hh = Math.floor(ss / 60 / 60);
  ss -= hh * 60 * 60;
  const mm = Math.floor(ss / 60);
  ss -= mm * 60;

  return res.json({
    projectName: env.PROJECT_NAME,
    version: env.VERSION,
    memoryUsage: process.memoryUsage(),
    uptime: {
      startTime: dayjs
        .unix(new Date().getTime() / 1000 - process.uptime())
        .toJSON(),
      hours: hh,
      minutes: mm,
      seconds: ss,
    },
  });
};

export default benchmarkController;
