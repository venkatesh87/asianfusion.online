#!/bin/bash

# Get platform
PLATFORM=$(uname)

# Check platform
if [ "$PLATFORM" != "Linux" ] && [ "$PLATFORM" != "Darwin" ]; then
  echo Your platform \"$PLATFORM\" is not supported
  end
fi

# Check awscli installation
if ! hash aws 2>/dev/null; then
  echo awscli is not installed
  nd
fi

# Check jq installation
if ! hash jq 2>/dev/null; then
  echo jq is not installed
  end
fi

# Check gdate (macOS only)
if [ "$PLATFORM" == "Darwin" ]; then
  if ! hash gdate 2>/dev/null; then
    echo gdate is not installed
    end
  fi
fi

# Check awscli configurations
if [ ! -f ~/.aws/config ] || [ ! -f ~/.aws/credentials ]; then
  echo awscli is not configured
  end
fi
