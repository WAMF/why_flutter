#!/bin/bash

# Flutter Firebase Deployment Script
# This script builds the Flutter web app and deploys it to Firebase Hosting

set -e  # Exit on any error

echo "🚀 Starting Flutter Firebase deployment..."

# Step 1: Clean any previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Step 2: Get dependencies
echo "📦 Getting Flutter dependencies..."
flutter pub get

# Step 3: Build Flutter web app
echo "🔨 Building Flutter web app..."
flutter build web --release

# Step 4: Copy build output to public folder
echo "📁 Copying build output to public folder..."
rm -rf public/*
cp -r build/web/* public/

# Step 5: Deploy to Firebase
echo "🔥 Deploying to Firebase..."
firebase deploy

echo "✅ Deployment complete!"
echo "🌐 Your app is now live at: https://whyflutter-f20bb.web.app"