#!/bin/bash

export PXT_FORCE_LOCAL=1
export PXT_RUNTIME_DEV=1
export PXT_ASMDEBUG=1
export PXT_DEBUG=1
export PXT_COMPILE_SWITCHES=csv---mbcodal

git clone -b v7.5.29 https://github.com/microsoft/pxt pxt
cd pxt
npm install
npm run build
cd ..

git clone -b v9.5.7 https://github.com/microsoft/pxt-common-packages pxt-common-packages
cd pxt-common-packages
npm install
cd ..

git clone -b v4.1.32 https://github.com/microsoft/pxt-microbit pxt-microbit
cd pxt-microbit
npm install pxt

npx pxt link ../pxt
npx pxt link ../pxt-common-packages

npm install

npx pxt buildtarget