local Signal = {}
Signal.__index = Signal

local ConnectionNode = {}
ConnectionNode.__index = ConnectionNode

function ConnectionNode.new(callback)
	return setmetatable({
		Callback = callback,
		Connected = true,
		Next = nil,
		Prev = nil
	}, ConnectionNode)
end

function Signal.new()
	local self = setmetatable({}, Signal)
	self._connectionsMap = {}
	self._head = ConnectionNode.new(nil)
	self._tail = self._head
	self._debounce = false
	return self
end

function Signal:Connect(callback)
	local node = ConnectionNode.new(callback)
	node.Prev = self._tail
	self._tail.Next = node
	self._tail = node
	table.insert(self._connectionsMap, node)

	function node:Disconnect()
		if node.Connected then
			node.Connected = false
			node.Prev.Next = node.Next
			if node.Next then
				node.Next.Prev = node.Prev
			else
				self._tail = node.Prev
			end
			node.Next = nil
			node.Prev = nil
		end
	end

	return node
end

function Signal:Fire(...)
	local args = {...}
	local node = self._head.Next

	while node do
		if node.Connected then
			local success, err = pcall(node.Callback, unpack(args))
			if not success then
				warn("Error in signal handler: " .. err)
			end
		end
		node = node.Next
	end
end

function Signal:DisconnectAll()
	local node = self._head.Next
	while node do
		node.Connected = false
		node = node.Next
	end
	self._head.Next = nil
	self._tail = self._head
	self._connectionsMap = {}
end

function Signal:FireDebounced(debounceTime, ...)
	if not self._debounce then
		self._debounce = true
		self:Fire(...)
		task.wait(debounceTime)
		self._debounce = false
	end
end

return Signal
