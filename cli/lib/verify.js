const fs = require('fs');
const path = require('path');

const AISPEC_SPEC = path.join(process.cwd(), '.aispec', 'spec');
const FALLBACK_SPEC = path.join(process.cwd(), 'spec');

function findSpecRoot() {
  if (fs.existsSync(path.join(AISPEC_SPEC, 'CONVENTIONS.md'))) return AISPEC_SPEC;
  if (fs.existsSync(path.join(FALLBACK_SPEC, 'CONVENTIONS.md'))) return FALLBACK_SPEC;
  return null;
}

function verify() {
  const specRoot = findSpecRoot();
  if (!specRoot) {
    console.error('FAIL: CONVENTIONS.md not found in .aispec/spec/ or spec/. Run `npx aispec-cli init` first.');
    return 1;
  }

  const conventionsPath = path.join(specRoot, 'CONVENTIONS.md');
  const conventions = fs.readFileSync(conventionsPath, 'utf8');

  let failed = false;

  if (!/Spec 驱动编程|八、|\/mrd|\/merge/.test(conventions)) {
    console.error('FAIL: CONVENTIONS.md must contain "Spec 驱动编程" or "八、" and /mrd、/merge workflow.');
    failed = true;
  }

  const templatesDir = path.join(specRoot, 'templates');
  const requiredTemplates = ['proposal.md', 'tasks.md'];
  for (const t of requiredTemplates) {
    const p = path.join(templatesDir, t);
    if (!fs.existsSync(p)) {
      console.error('FAIL: Template missing:', p);
      failed = true;
    }
  }

  const phases = ['/mrd', '/opensp', '/prd', '/design', '/review', '/test', '/merge'];
  let count = 0;
  for (const ph of phases) {
    if (conventions.includes(ph)) count++;
  }
  if (count < 7) {
    console.error('FAIL: CONVENTIONS must describe at least 7 phases (/mrd, /opensp, /prd, /design, /review, /test, /merge). Found:', count);
    failed = true;
  }

  if (failed) return 1;
  console.log('OK: aispec convention and templates verified.');
  return 0;
}

module.exports = { verify, findSpecRoot };
