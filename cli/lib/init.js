const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');
const TEMPLATES = path.join(ROOT, 'templates');
const AISPEC = '.aispec';
const SPEC = path.join(AISPEC, 'spec');
const TARGET_TEMPLATES = path.join(SPEC, 'templates');

function mkdirp(dir) {
  if (fs.existsSync(dir)) return;
  mkdirp(path.dirname(dir));
  fs.mkdirSync(dir);
}

function copyTemplate(name, targetPath) {
  const src = path.join(TEMPLATES, name);
  const dest = path.join(process.cwd(), targetPath, name);
  if (!fs.existsSync(src)) return;
  mkdirp(path.dirname(dest));
  fs.copyFileSync(src, dest);
  console.log('  +', targetPath + '/' + name);
}

function init(opts = {}) {
  const cwd = process.cwd();
  const agentsInRoot = opts.agents !== false;

  if (fs.existsSync(path.join(cwd, AISPEC, 'spec', 'CONVENTIONS.md'))) {
    console.log('.aispec/spec/ already exists; skipping init.');
    return 0;
  }

  mkdirp(path.join(cwd, SPEC));
  mkdirp(path.join(cwd, TARGET_TEMPLATES));

  const conventionsName = 'conventions-minimal.md';
  const conventionsSrc = path.join(TEMPLATES, conventionsName);
  const conventionsDest = path.join(cwd, SPEC, 'CONVENTIONS.md');
  if (fs.existsSync(conventionsSrc)) {
    fs.copyFileSync(conventionsSrc, conventionsDest);
    console.log('  +', SPEC + '/CONVENTIONS.md');
  }

  copyTemplate('proposal.md', TARGET_TEMPLATES);
  copyTemplate('tasks.md', TARGET_TEMPLATES);

  if (agentsInRoot) {
    const agentsSrc = path.join(TEMPLATES, 'agents.md');
    const agentsDest = path.join(cwd, 'AGENTS.md');
    if (fs.existsSync(agentsSrc)) {
      fs.copyFileSync(agentsSrc, agentsDest);
      console.log('  + AGENTS.md');
    }
  }

  console.log('Done. Run `npx aispec-cli verify` to check.');
  return 0;
}

module.exports = { init };
