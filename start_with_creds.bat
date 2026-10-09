@echo off
REM ============================================================
REM  Start BlackBox AI server with REAL Stripe credentials
REM
REM  Edit the 3 lines below with your real Stripe key + card ID,
REM  then double-click this file.
REM
REM  Env vars set here take precedence over .env placeholders
REM  because app_factory.py uses load_dotenv() which does NOT
REM  override existing env variables.
REM
REM  Get Stripe key: https://dashboard.stripe.com/apikeys
REM ============================================================

set STRIPE_API_KEY=sk_live_YOUR_REAL_STRIPE_KEY_HERE
set STRIPE_SECRET_KEY=sk_live_YOUR_REAL_STRIPE_KEY_HERE
set DEFAULT_BANK_CARD_ID=card_YOUR_REAL_CARD_ID_HERE

cd /d c:\Users\bsean\.blackbox\blackbox-ai-repo
python -m uvicorn src.api_server:app --host 0.0.0.0 --port 8000 --log-level info
