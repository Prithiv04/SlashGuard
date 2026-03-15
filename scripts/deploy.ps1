# Get testnet DOT from faucet: https://faucet.polkadot.io (select Passet Hub)

if (-not $env:PRIVATE_KEY) {
    Write-Host "Error: PRIVATE_KEY environment variable is not set." -ForegroundColor Red
    Write-Host "Please set it first using: `$env:PRIVATE_KEY='your_private_key_here'" -ForegroundColor Yellow
    exit 1
}

$env:HUB_RPC = "https://testnet-passet-hub-eth-rpc.polkadot.io"

Write-Host "Deploying ValidatorInsurance to Hub Testnet..." -ForegroundColor Cyan
forge create backend/src/ValidatorInsurance.sol:ValidatorInsurance --rpc-url $env:HUB_RPC --private-key $env:PRIVATE_KEY --legacy

Write-Host "Deployment complete! Please save your deployed contract address and update frontend/index.html." -ForegroundColor Green
