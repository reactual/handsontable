#!/usr/bin/env node
const request = require('request');

const ENDPOINT = 'https://api.travis-ci.org';
const REPO_OWNER = 'handsontable';
const REPO_PROJECT = 'hot-builder';

const options = {
  method: 'POST',
  url: `${ENDPOINT}/repo/${REPO_OWNER}%2F${REPO_PROJECT}/requests`,
  headers: {
    Authorization: `token ${process.env.TCI_TOKEN}`,
    Accept: 'application/json',
    ContentType: 'application/json',
    'Travis-API-Version': '3',
  },
  json: {
    request: {
      message: `Checking triggered from handsontable/handsontable repository (the ${process.env.TRAVIS_BRANCH} branch)`,
      //branch: 'master',
      branch: 'feature/issue-22',
      config: {
        env: {
          global: [`HOT_BRANCH=${process.env.TRAVIS_BRANCH}`],
        },
      },
    }
  },
};

request(options, (err, res) => {
  if (err) {
    process.exit(1);
  }

  if (res.statusCode >= 400) {
    process.exit(1);
  }
});
