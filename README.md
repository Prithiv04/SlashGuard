# SlashGuard — Validator Slash Insurance on Paseo Asset Hub

> **First DeFi insurance layer protecting Polkadot nominators from validator slashing losses on Paseo Asset Hub**

## 🚨 Overview

SlashGuard protects nominators from losing their staked DOT when validators are slashed due to validator misbehavior.

Historically, more than **$100M+ worth of stake has been slashed across Proof-of-Stake ecosystems**.
In Polkadot, nominators can lose a significant portion or even **100% of delegated stake** when validators fail.

SlashGuard introduces an **insurance-pool-based protection model** built directly on **Polkadot Virtual Machine (PVM)**.

---

## 🎯 Problem

Polkadot nominators face stake loss when validators:

* Double-sign blocks
* Stay offline beyond threshold
* Produce invalid blocks

### Slashing Impact

* **Double-signing:** 0.01% → 100% slash
* **Offline events:** exponential slashing
* **Invalid blocks:** up to 100% stake loss

There is currently **no native insurance mechanism** for nominators.

---

## 🛡️ Solution

```text
MetaMask Stake → PVM Contract → Insurance Pool → Slash Protection
                    ↓
SAFE: 1.0 DOT | Claim #1 ACTIVE | Block 6609774 Confirmed
```

SlashGuard creates insurance pools that absorb slash events and protect stakers.

---

## 🚀 Live Demo

**Live Application:**
https://pvmshield-prithiv.vercel.app

---

## 🏗️ Tech Stack

### Frontend

* React 18
* TailwindCSS
* ethers.js v6.7.0
* MetaMask RPC auto-switching
* Vercel deployment

### Smart Contract

**Contract Address:**
`0x736985ed65A72b1b44B572Ff75EB52Dd7d624eF9`

* Solidity
* Revive compiler
* RISC-V PVM bytecode
* Selector: `0x6ab28a9c`
* Rust staking pallet integration
* 1-block finality on Paseo Asset Hub

### Blockchain

* Paseo Asset Hub Testnet
* Chain ID: `420420421`
* 9,999 DOT funded

---

## 🔧 PVM Execution Flow

```text
MetaMask Stake
     ↓
EVM Contract
     ↓
PVM Precompile
     ↓
RISC-V Bytecode
     ↓
Rust Staking Pallet
     ↓
1-Block Finality
```

---

## 📊 Production Results

| Metric            | Status      | Proof                                      |
| ----------------- | ----------- | ------------------------------------------ |
| Contract Deployed | ✅ LIVE      | 0x736985ed65A72b1b44B572Ff75EB52Dd7d624eF9 |
| PVM Execution     | ✅ Confirmed | Block 6609774                              |
| Insurance Pool    | 🟢 SAFE     | 1.0 DOT                                    |
| Claims            | 🔵 ACTIVE   | Position #1                                |
| RPC Recovery      | ✅ V3.0      | -32002 handled                             |

---

## ⚡ Production Features

* Glassmorphism UI
* V3.0 RPC resilience
* Handles MetaMask `-32002` errors
* Auto network switching
* Real-time pool state updates

---

## 🎬 Demo Highlights

* PVM contract verification
* EVM → RISC-V → Rust staking flow
* SAFE insurance pool activation
* RPC failure recovery
* Block confirmation proof

---

## 🛠️ Quick Start

```bash
git clone https://github.com/prithiv-r/pvmshield
cd pvmshield
npm install
npm run dev
```

---

## 🔗 MetaMask Configuration

### Network

* Chain ID: `420420421`

### Faucet

https://paseo-faucet.polkadot.network

---

## 🔗 Contract ABI

```solidity
function stake(address validator, uint256 amount, uint8 position) external;
function pools() external view returns (uint256 safe, uint256 active);
```

---

## 🎖️ Hackathon Submission

**DoraHacks Polkadot Solidity Hackathon 2026 — PVM Track**

### Submission Links

* Live Demo: https://pvmshield-prithiv.vercel.app
* Contract: `0x736985ed65A72b1b44B572Ff75EB52Dd7d624eF9`
* GitHub: https://github.com/prithiv-r/pvmshield

---

## 🏆 Why SlashGuard Stands Out

| Others                   | SlashGuard                  |
| ------------------------ | --------------------------- |
| RPC failure breaks demo  | V3.0 automatic recovery     |
| Basic dashboards         | Glassmorphism production UI |
| Contract failure unclear | PVM security visibility     |

---

## 👨‍💻 Author

**Prithiv R**
Blockchain Developer
Chennai, India

* Polkadot PVM + EVM Builder
* Hackathon Winner
* Open Source Contributor

---

## 📄 License

MIT License
