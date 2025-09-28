# duck-type.nvim
Want to see ducks type out your code for you?

## Table of Contents

- [Getting Started](#getting-started)
    - [Requirements](#requirements)
    - [Installation](#installation)
        - [Lazy](#lazy)
- [Configuration](#configuration)
    - [Setup](#setup)
- [Usage](#usage)
- [Showcase](#showcase)

## Getting Started
This section will guide you through the process of installing **duck-type.nvim**.

### Requirements
* [Neovim 0.11](https://neovim.io/news/2025/03]) or the latest nightly build is required for the plugin to work. 

### Installation
After you have met the requirements, proceed to follow the installation steps for the listed package managers:

#### Lazy
<details>

<summary>Lazy</summary>

Add the plugin to your existing list of plugins:

```lua
{
    "DuckyShine004/duck-type.nvim",
    -- Your configuration goes here, leave empty for defaults
    opts = {}
}
```

</details>

## Configuration
This section will guide you through the process of configuring **duck-type.nvim**.

### Setup

**duck-type.nvim** is highly configurable, please refer to the default settings below:

```lua

--- @class Config

local M = {}

M.defaults = {
	delay = 50, -- in ms
	loop = true, -- looping over the same buffer
	cursor = "🦆", -- custom cursor,
}
```

## Usage

Run `:DuckType` within Neovim's CLI to see duck's code for you!

## Showcase
