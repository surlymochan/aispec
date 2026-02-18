#!/usr/bin/env node

const path = require('path');
const init = require(path.join(__dirname, '..', 'lib', 'init.js')).init;
const verify = require(path.join(__dirname, '..', 'lib', 'verify.js')).verify;

const args = process.argv.slice(2);
const cmd = args[0];

if (cmd === 'init') {
  const opts = {};
  if (args.includes('--no-agents')) opts.agents = false;
  process.exit(init(opts));
}

if (cmd === 'verify') {
  process.exit(verify());
}

console.log(`aispec-cli: init | verify

  init      Create .aispec/spec/ with CONVENTIONS and templates; optional AGENTS.md in root.
            Use --no-agents to skip creating AGENTS.md.

  verify    Check that CONVENTIONS and required templates exist and contain workflow phases.
`);
process.exit(1);
