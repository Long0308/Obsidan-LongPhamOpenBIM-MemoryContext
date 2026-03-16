#!/usr/bin/env node

/**
 * Auto-Memory Kit — Cross-platform Init Script
 * Usage: npx auto-memory-kit init [target-dir]
 * 
 * Installs the AI Agent memory vault + skills into your workspace.
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// ─── Colors ───
const C = {
  reset: '\x1b[0m',
  cyan: '\x1b[36m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  red: '\x1b[31m',
  bold: '\x1b[1m',
  dim: '\x1b[2m',
};

const log = (msg) => console.log(msg);
const ok = (msg) => log(`  ${C.green}✅${C.reset} ${msg}`);
const warn = (msg) => log(`  ${C.yellow}⚠️${C.reset}  ${msg}`);
const fail = (msg) => log(`  ${C.red}❌${C.reset} ${msg}`);
const step = (n, total, msg) => log(`\n${C.green}[${n}/${total}]${C.reset} ${msg}`);

// ─── Helpers ───
function copyRecursive(src, dest) {
  if (!fs.existsSync(src)) return 0;
  let count = 0;
  
  if (fs.statSync(src).isDirectory()) {
    fs.mkdirSync(dest, { recursive: true });
    for (const entry of fs.readdirSync(src)) {
      count += copyRecursive(path.join(src, entry), path.join(dest, entry));
    }
  } else {
    fs.mkdirSync(path.dirname(dest), { recursive: true });
    fs.copyFileSync(src, dest);
    count = 1;
  }
  return count;
}

function countFiles(dir) {
  if (!fs.existsSync(dir)) return 0;
  let count = 0;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    if (entry.isDirectory()) {
      count += countFiles(path.join(dir, entry.name));
    } else {
      count++;
    }
  }
  return count;
}

// ─── Main ───
function main() {
  const args = process.argv.slice(2);
  const command = args[0];
  
  if (!command || command === '--help' || command === '-h') {
    log(`
${C.bold}${C.cyan}🧠 Auto-Memory Kit${C.reset}
${C.dim}AI Agent memory system for Obsidian${C.reset}

${C.bold}Usage:${C.reset}
  npx auto-memory-kit init [target-dir]   Install vault + skills
  npx auto-memory-kit init . --global     Install skill globally
  npx auto-memory-kit init . --vault-only Only install Obsidian vault

${C.bold}Options:${C.reset}
  --global       Install auto-memory skill to ~/.agents/skills/ (all projects)
  --vault-only   Only copy the Obsidian vault, skip skill install
  --force        Overwrite existing files

${C.bold}Examples:${C.reset}
  npx auto-memory-kit init                Install to current directory
  npx auto-memory-kit init ./my-project   Install to specific directory
  npx auto-memory-kit init . --global     Global skill install
`);
    process.exit(0);
  }
  
  if (command !== 'init') {
    log(`${C.red}Unknown command: ${command}${C.reset}`);
    log(`Run: npx auto-memory-kit --help`);
    process.exit(1);
  }
  
  // Parse args
  const targetDir = path.resolve(args[1] || '.');
  const isGlobal = args.includes('--global');
  const isVaultOnly = args.includes('--vault-only');
  const isForce = args.includes('--force');
  
  const templateDir = path.join(__dirname, '..', 'templates');
  const totalSteps = isVaultOnly ? 2 : 4;
  
  log(`\n${C.bold}${C.cyan}🧠 Auto-Memory Kit — Installer${C.reset}`);
  log(`${'═'.repeat(42)}`);
  log(`${C.dim}Target: ${targetDir}${C.reset}`);
  log(`${C.dim}Mode: ${isGlobal ? 'Global' : 'Local'}${isVaultOnly ? ' (vault-only)' : ''}${C.reset}`);
  
  // ═══ Step 1: Copy Obsidian Vault ═══
  step(1, totalSteps, 'Installing Obsidian vault...');
  const vaultSrc = path.join(templateDir, 'LPOpenBIMAI');
  const vaultDest = path.join(targetDir, 'LPOpenBIMAI');
  
  if (fs.existsSync(vaultDest) && !isForce) {
    warn('LPOpenBIMAI/ already exists (use --force to overwrite)');
  } else {
    const copied = copyRecursive(vaultSrc, vaultDest);
    ok(`LPOpenBIMAI/ installed (${copied} files)`);
  }
  
  // ═══ Step 2: Copy .agent rules ═══
  step(2, totalSteps, 'Installing agent rules...');
  const agentSrc = path.join(templateDir, '.agent');
  const agentDest = path.join(targetDir, '.agent');
  
  if (fs.existsSync(agentDest) && !isForce) {
    warn('.agent/ already exists (use --force to overwrite)');
  } else {
    const copied = copyRecursive(agentSrc, agentDest);
    ok(`.agent/ installed (${copied} files)`);
  }
  
  if (isVaultOnly) {
    printSuccess(targetDir, vaultDest);
    return;
  }
  
  // ═══ Step 3: Copy InsForge backend ═══
  step(3, totalSteps, 'Installing backend schemas...');
  const insforgeSrc = path.join(templateDir, 'insforge');
  const insforgeDest = path.join(targetDir, 'insforge');
  
  if (fs.existsSync(insforgeDest) && !isForce) {
    warn('insforge/ already exists (use --force to overwrite)');
  } else {
    const copied = copyRecursive(insforgeSrc, insforgeDest);
    ok(`insforge/ installed (${copied} files)`);
  }
  
  // ═══ Step 4: Verify ═══
  step(4, totalSteps, 'Verifying installation...');
  
  const checks = [
    { path: path.join(vaultDest, 'Agent-Skills', 'Agent-Skills.md'), name: 'Skill MOC (64 skills)' },
    { path: path.join(vaultDest, 'Agent-Agents', 'Agent-Agents.md'), name: 'Agent MOC (23 agents)' },
    { path: path.join(vaultDest, 'Agent-Memory', 'Agent-Memory.md'), name: 'Memory system' },
    { path: path.join(vaultDest, 'Agent-Memory', 'dashboard.html'), name: 'Live dashboard' },
    { path: path.join(agentDest, 'ARCHITECTURE.md'), name: 'Architecture map' },
    { path: path.join(agentDest, 'skills', 'auto-memory', 'SKILL.md'), name: 'Auto-Memory skill' },
  ];
  
  let allOk = true;
  for (const check of checks) {
    if (fs.existsSync(check.path)) {
      ok(check.name);
    } else {
      fail(`${check.name} — NOT FOUND`);
      allOk = false;
    }
  }
  
  if (allOk) {
    printSuccess(targetDir, vaultDest);
  } else {
    log(`\n${C.yellow}⚠️  Some files missing. Try: npx auto-memory-kit init . --force${C.reset}\n`);
  }
}

function printSuccess(targetDir, vaultDest) {
  log(`
${C.bold}${C.cyan}🎉 Installation complete!${C.reset}

${C.bold}What you get:${C.reset}
  • ${C.green}64${C.reset} AI skill cards (Auto Memory, Clean Code, Brainstorming...)
  • ${C.green}23${C.reset} Agent profiles (Orchestrator, Frontend, Backend...)
  • ${C.green}17${C.reset} Obsidian plugin references
  • ${C.green}4${C.reset}  Dashboard views (Vault, Skills, GitHub, Session)
  • ${C.green}3${C.reset}  Canvas graphs (Agent-Swarm, Memory-Graph)
  • Auto-memory protocol (session tracking + context monitor)

${C.bold}Next steps:${C.reset}
  ${C.dim}1.${C.reset} Open ${C.cyan}${targetDir}${C.reset} in ${C.bold}Obsidian${C.reset}
  ${C.dim}2.${C.reset} Open workspace in ${C.bold}Antigravity${C.reset} (or Cursor/Claude)  
  ${C.dim}3.${C.reset} Start working — agent handles the rest

${C.bold}Dashboard:${C.reset}
  ${C.dim}$${C.reset} npx -y http-server LPOpenBIMAI/Agent-Memory -p 8484 -c-1 --cors
  ${C.dim}→${C.reset} ${C.cyan}http://localhost:8484/dashboard.html${C.reset}
`);
}

main();
