# Highly Optimized Signal Module

## Overview

This module provides an optimized implementation of the signal pattern in Lua, designed for use in Roblox. It allows for efficient event handling with minimal conditionals, utilizing a linked list structure to manage connections.

## Features

- Supports multiple listeners for a single event.
- Efficient connection and disconnection methods.
- Safe error handling with `pcall` for callbacks.
- Debouncing functionality to limit the firing rate of signals.

## Installation

To use the Signal module in your Roblox game, place it in `ReplicatedStorage` or any other accessible location, then require it in your scripts.

```lua
local Signal = require(game.ReplicatedStorage:WaitForChild("Signal"))
```

## Usage

### Creating a Signal

```lua
local mySignal = Signal.new()
```

### Connecting a Callback

```lua
local function myCallback(...)
    print("Signal fired with arguments:", ...)
end

local connection = mySignal:Connect(myCallback)
```

### Firing a Signal

```lua
mySignal:Fire("Hello", "World")
```

### Disconnecting a Callback

```lua
connection:Disconnect()
```

### Disconnecting All Connections

```lua
mySignal:DisconnectAll()
```

### Debounced Firing

```lua
mySignal:FireDebounced(1, "This will fire once per second.")
```

## Contributing

Contributions are welcome! If you have suggestions for improvements or new features, feel free to create a pull request. Here are a few guidelines for contributing:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and test thoroughly.
4. Submit a pull request with a clear description of your changes.

## Notes

- Ensure to manage connections properly to avoid memory leaks.
- Utilize debouncing for frequent events to improve performance.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
