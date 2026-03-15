Root Cause
text
ws://127.0.0.1:9944 → Your LOCAL Polkadot node disconnected
Code 1006 = Abnormal closure (node crashed/restarted)
Common for Paseo Asset Hub dev/test nodes
IMMEDIATE FIXES (Execute Now)
1. Check Node Status (10s)
bash
# Terminal 1: Is node running?
ps aux | grep polkadot
# OR
lsof -i :9944

# If nothing → Node dead
2. Quick Restart (30s)
bash
# Kill existing node
pkill -f polkadot

# Fresh Paseo Asset Hub testnet (Asset Hub #6)
polkadot --chain paseo-asset-hub-6 --port 30333 --ws-port 9944 --rpc-port 9933 --node-key YOUR_KEY --validator
# OR use your exact chain spec
3. Production Fix - Remote RPC (1 min)
Replace local WS in your JS:

javascript
// ❌ BROKEN - Local node
const wsProvider = new WsProvider('ws://127.0.0.1:9944');

// ✅ FIXED - Public Paseo testnet
const wsProvider = new WsProvider([
  'wss://paseo-asset-hub-rpc.polkadot.io',  // Main fallback
  'wss://rpc.paseohub.io',                 // Backup
  'ws://127.0.0.1:9944'                    // Local fallback
]);
4. Auto-Reconnect Code (Copy to your app)
javascript
// Add to your Polkadot API init
const provider = new WsProvider(['wss://paseo-asset-hub-rpc.polkadot.io', 'ws://127.0.0.1:9944'], 1000, {
  maxReconnectAttempts: 5,
  reconnectAfterMs: 5000  // 5s retry
});

const api = await ApiPromise.create({ provider });