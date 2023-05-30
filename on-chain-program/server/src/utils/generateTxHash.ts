import { randomBytes } from 'node:crypto';

export default function () {
  return new Promise<string>((resolve, reject) => {
    randomBytes(32, function (err, buf) {
      if (err !== null) {
        reject(err);
      }
      let hash = buf
        .toString('base64')
        .replaceAll('/', '_')
        .replaceAll('+', '-');
      resolve(hash);
    });
  });
}
