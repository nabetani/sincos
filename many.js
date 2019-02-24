"use strict";

const input = require('fs').readFileSync('/dev/stdin', 'utf8');
const t = parseFloat(input)
const s=`${Math.sin(t)},${Math.cos(t)},${Math.tan(t)},${Math.atan(t)},${Math.atan2(t,t/2)}`;
console.log(s)
