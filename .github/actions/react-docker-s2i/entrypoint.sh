#!/bin/sh
set -e

# ========= RECEIVE ARGUMENTS ==========
REGISTRY=$1
USERNAME=$2
PASSWORD=$3
IMAGE_NAME=$4
TAG=$5

echo "Configuration:"
echo "  Registry: $REGISTRY"
echo "  Username: $USERNAME"
echo "  Image: $IMAGE_NAME:$TAG"

# ======= SET DEFAULT STATUS ===========
echo "push_status=failed" >> "$GITHUB_OUTPUT"

# =========== DOCKER LOGIN =============
echo ""
echo "Logging in to container registry..."
echo "$PASSWORD" | docker login "$REGISTRY" -u "$USERNAME" --password-stdin

if [ $? -ne 0 ]; then
    echo "Docker login failed!"
    exit 1
fi

echo "Docker login successfully ✅"

# ======= PREPARE BUILD CONTEXT ========
echo ""
echo "Preparing build context..."

if [ ! -d "$GITHUB_WORKSPACE/dist" ]; then
    echo "❌ Error: dist/ folder not found!"
    echo "   Make sure you ran 'npm run build' before this action"
    exit 1
fi

cp -r "$GITHUB_WORKSPACE"/dist /app/
echo "✅ Build context prepared ✅"

# ======= BUILD DOCKER IMAGE =========
echo ""
echo "Building Docker image..."
docker build -t "$REGISTRY/$USERNAME/$IMAGE_NAME:$TAG" /app/

if [ $? -ne 0 ]; then
    echo "❌ Docker build failed!"
    exit 1
fi

echo "Docker image built successfully ✅"

# ========== PUSH IMAGE ============
echo ""
echo "Pushing image to registry..."
docker push "$REGISTRY/$USERNAME/$IMAGE_NAME:$TAG"

if [ $? -ne 0 ]; then
    echo "❌ Docker push failed!"
    exit 1
fi

echo "Docker image pushed successfully ✅"

# ======= SET OUTPUTS ===========
FULL_IMAGE_NAME="$REGISTRY/$USERNAME/$IMAGE_NAME:$TAG"
echo "image_name=$FULL_IMAGE_NAME" >> "$GITHUB_OUTPUT"
echo "push_status=success" >> "$GITHUB_OUTPUT"

echo ""
echo "Success! Image available at:"
echo "   $FULL_IMAGE_NAME"