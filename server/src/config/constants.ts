// ** Import types
import type { CorsOptions } from 'cors';

const CORS: Readonly<CorsOptions> = {
  origin: ['http://localhost:3000'],
  credentials: true,
  allowedHeaders: ['Content-Type', 'Authorization'],
  methods: ['GET', 'PUT', 'POST', 'DELETE'],
};

export default {
  CORS,
} as const;
