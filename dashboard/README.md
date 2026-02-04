# MAHORAGA Dashboard

Real-time monitoring dashboard for the MAHORAGA autonomous trading agent.

## Features

- 📊 Live portfolio performance charts
- 📡 Active trading signals feed
- 🤖 LLM research results
- 📋 Real-time activity logs
- 💰 Position tracking
- 💸 LLM cost monitoring

## Local Development

```bash
npm install
npm run dev
```

Dashboard will be available at http://localhost:3000

## Deploy to Vercel

### Option 1: Using Vercel CLI

```bash
# Install Vercel CLI
npm i -g vercel

# Deploy from the dashboard directory
cd dashboard
vercel

# For production deployment
vercel --prod
```

### Option 2: Using Vercel Dashboard

1. Go to [vercel.com](https://vercel.com) and sign in
2. Click "Add New Project"
3. Import your GitHub repository
4. Set the **Root Directory** to `dashboard`
5. Framework Preset will auto-detect as "Vite"
6. Add environment variable:
   - `MAHORAGA_API_URL` = `https://mahoraga.pagesofadil.workers.dev`
7. Click "Deploy"

### Option 3: One-Click Deploy

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/YOUR_USERNAME/MAHORAGA&project-name=mahoraga-dashboard&root-directory=dashboard&env=MAHORAGA_API_URL&envDescription=URL%20of%20your%20Cloudflare%20Workers%20backend&envLink=https://mahoraga.pagesofadil.workers.dev)

## Configuration

The dashboard connects to your MAHORAGA backend via the `/api` proxy endpoint.

### API Token Setup

On first visit, you'll need to configure your API token:

1. Click `[CONFIG]` in the top right
2. Enter your `MAHORAGA_API_TOKEN`
3. Click "Save & Reload"

The token is stored in browser localStorage and sent with all API requests.

### Environment Variables

- `MAHORAGA_API_URL` - Backend URL (default: production Cloudflare Workers URL)
- `VITE_MAHORAGA_API_TOKEN` - Optional: Pre-configure API token (not recommended for production)

## Build for Production

```bash
npm run build
```

Output will be in the `dist/` directory.

## Tech Stack

- **React** - UI framework
- **Vite** - Build tool
- **Tailwind CSS** - Styling
- **Framer Motion** - Animations
- **Recharts** - Charts (if used)

## CORS Configuration

If you deploy to a custom domain, you may need to update CORS settings in your Cloudflare Workers backend to allow requests from your Vercel domain.
