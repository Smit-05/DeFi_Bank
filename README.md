# DeFi_Bank


### Project Setup

- Create folder.
- Add `package.json` file to this project and add below content.
```json
  {
    "name": "defi-tutorial",
    "version": "0.1.0",
    "description": "DeFi Token Staking App",
    "author": "gregory@dappuniversity.com",
    "dependencies": {
      "babel-polyfill": "6.26.0",
      "babel-preset-env": "1.7.0",
      "babel-preset-es2015": "6.24.1",
      "babel-preset-stage-2": "6.24.1",
      "babel-preset-stage-3": "6.24.1",
      "babel-register": "6.26.0",
      "bootstrap": "4.3.1",
      "chai": "4.2.0",
      "chai-as-promised": "7.1.1",
      "chai-bignumber": "3.0.0",
      "identicon.js": "^2.3.3",
      "react": "16.8.4",
      "react-bootstrap": "1.0.0-beta.5",
      "react-dom": "16.8.4",
      "react-scripts": "2.1.3",
      "truffle": "5.1.39",
      "web3": "1.2.11"
    },
    "scripts": {
      "start": "react-scripts start",
      "build": "react-scripts build",
      "test": "react-scripts test",
      "eject": "react-scripts eject"
    },
    "eslintConfig": {
      "extends": "react-app"
    },
    "browserslist": [
      ">0.2%",
      "not dead",
      "not ie <= 11",
      "not op_mini all"
    ]
  }
  ```
- Add `.gitignore` and add below content.

```ActionScript

  # dependencies
  /node_modules
  /.pnp
  .pnp.js

  # testing
  /coverage

  # production
  /build

  # misc
  .DS_Store
  .env
  .env.local
  .env.development.local
  .env.test.local
  .env.production.local

  npm-debug.log*
  yarn-debug.log*
  yarn-error.log*
```
- Run command `npm install` in package.json directory
- Add below snippet in `truffle-config.js`.
```js
  require('babel-register');
  require('babel-polyfill');

  module.exports = {
    networks: {
      development: {
        host: "127.0.0.1",
        port: 7545,
        network_id: "*" // Match any network id
      },
    },
    contracts_directory: './src/contracts/',
    contracts_build_directory: './src/abis/',
    compilers: {
      solc: {
        optimizer: {
          enabled: true,
          runs: 200
        },
        evmVersion: "petersburg"
      }
    }
  }
```
- Add smart contracts in `/src/contracts` folder.
- Run `truffle compile` to check for the compilation error 
- Migrate contracts on blockchain using command `truffle migrate`
- If already migrated once and want to re-migrate use reset flag `truffle migrate --reset`
<hr>
<p align='center'>
<a href="#"><img alt="Git" src="https://img.shields.io/badge/Solidity-e6e6e6?style=for-the-badge&logo=solidity&logoColor=black"></a>
<a href="#"><img alt="Git" src="https://img.shields.io/badge/Ethereum-3C3C3D?style=for-the-badge&logo=Ethereum&logoColor=white"></a>
<a href="#"><img alt="Git" src="https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E"></a>
<a href="#"><img alt="Git" src="https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB"></a>
</p>
