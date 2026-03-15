# PVMShield

Native DOT insurance for Polkadot validators using PVM Precompiles.

## Structure
- `/backend` - Foundry project with smart contracts
- `/frontend` - Single-file `index.html` frontend
- `/scripts` - Deployment scripts

## Deployment (Windows Native)
1. Open PowerShell and set your private key: `$env:PRIVATE_KEY="your_private_key_here"`
2. Run deployment: `.\scripts\deploy.ps1`
3. Update `CONTRACT_ADDRESS` in `frontend/index.html` with your deployed address.

## Running tests (Windows)
Because you are using Windows natively, you need the Foundry binary:
1. Download `foundry_nightly_win32_amd64.zip` from [Foundry GitHub Releases](https://github.com/foundry-rs/foundry/releases)
2. Extract the ZIP and add the folder containing `forge.exe` to your System PATH environment variable.
3. Open PowerShell in the `backend` folder and run:
```powershell
forge test -vvv
```
