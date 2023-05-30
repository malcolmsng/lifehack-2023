import dotenv from 'dotenv';

dotenv.config();

interface RawEnv {
  NODE_ENV: string | undefined;
  PORT: string | undefined;
  VERSION: string | undefined;
  PROJECT_NAME: string | undefined;
  PROGRAM_ID: string | undefined;
}

type NodeEnv = 'development' | 'production';

interface Env {
  NODE_ENV: NodeEnv;
  PORT: number;
  VERSION: string;
  PROJECT_NAME: string;
  PROGRAM_ID: string;
}

const getEnv = (): RawEnv => ({
  NODE_ENV: process.env.NODE_ENV,
  PORT: process.env.PORT,
  VERSION: process.env.VERSION,
  PROJECT_NAME: process.env.PROJECT_NAME,
  PROGRAM_ID: process.env.PROGRAM_ID,
});

const isNodeEnv = (str: string): str is NodeEnv => {
  return str === 'development' || str === 'production';
};

const getSanitizedEnv = (env: RawEnv): Env => {
  for (const [key, value] of Object.entries(env)) {
    if (value === undefined) throw new Error(`Missing key ${key} in .env`);
  }

  if (!isNodeEnv(env.NODE_ENV!))
    throw new Error(`Invalid Node Env ${env.NODE_ENV}`);

  if (isNaN(parseInt(env.PORT!)))
    throw new Error(`Invalid Port number ${env.PORT}`);

  return {
    NODE_ENV: env.NODE_ENV,
    PORT: Number(env.PORT),
    VERSION: env.VERSION!,
    PROJECT_NAME: env.PROJECT_NAME!,
    PROGRAM_ID: env.PROGRAM_ID!,
  };
};

const env = getEnv();

const sanitizedEnv = getSanitizedEnv(env);

export default sanitizedEnv;
