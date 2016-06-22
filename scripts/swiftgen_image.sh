#!/bin/bash

swiftgen images --templatePath ./templates.stencil --output ./UIImage+CWChat.swift ../CWWeChat/Application/Assets.xcassets
mv UIImage+CWChat.swift ../CWWeChat/Expand/Extension/
