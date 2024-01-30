            -- Wrap the monitor above the computer
local monitor = peripheral.wrap("top")

            -- Make sure to check if the monitor is connected
if not monitor then
  error("No monitor found on top")
end

            -- Set the monitor's text scale
monitor.setTextScale(0.5) -- Adjust as needed for your monitor size

local w = 82
local h = 66

local grid = {}
for ih = 1, h do
    grid[ih] = {}
    for iw = 1, w do
        local rand = math.random(0, 99)
        grid[ih][iw] = rand < 10
    end
end

local gridNext = {}
for ih = 1, h do
    gridNext[ih] = {}
    for iw = 1, w do
        gridNext[ih][iw] = false
    end
end

local function printGrid()
    --monitor.clear()
    device.clear()
    for ih = 1, h do
        for iw = 1, w do
            --monitor.setCursorPos(iw, ih)
            device.setCursorPos(iw, ih)
            if grid[ih][iw] then
                monitor.setTextColor(colors.lime)
                monitor.write("@")
            else
                monitor.setTextColor(colors.white) -- Changed Text Color Here
                monitor.write(" ")
            end
        end
    end
end

function calcNext()
	for ih = 1, h do
		for iw = 1, w do
			n = 0
			if(iw~=w and grid[ih][iw+1]) then n = n + 1 end -- right
			if(iw~=1 and grid[ih][iw-1]) then n = n + 1 end -- left
			if(ih~=h and grid[ih+1][iw]) then n = n + 1 end -- down
			if(ih~=1 and grid[ih-1][iw]) then n = n + 1 end -- up
			if(ih~=1 and iw~=1 and grid[ih-1][iw-1]) then n = n + 1 end -- up left
			if(ih~=1 and iw~=w and grid[ih-1][iw+1]) then n = n + 1 end -- up right
			if(ih~=h and iw~=1 and grid[ih+1][iw-1]) then n = n + 1 end -- down left
			if(ih~=h and iw~=w and grid[ih+1][iw+1]) then n = n + 1 end -- down right
			if(n == 3 or (n == 2 and grid[ih][iw]))
				then gridNext[ih][iw] = true
                else gridNext[ih][iw] = false
			end
		end
	end
end

function setNext()
	for ih = 1, h do
		for iw = 1, w do
			grid[ih][iw] = gridNext[ih][iw]
		end
	end
end

            -- ... (rest of the initialization code)
term.clear()
term.setCursorPos(35,31)
term.setTextColor(colors.yellow)
term.setBackgroundColor(colors.black)
sleep(0.5)
term.write("3... ")
sleep(1)
term.write("2... ")
sleep(1)
term.write("1... ")
sleep(1)

           -- Function to handle right-clicks on the monitor
local function handleRightClick(x, y)
    -- Toggle the cell state at the clicked position
    local ih = y
    local iw = math.ceil(x / 2) -- Adjust if you're using two characters per cell
    grid[ih][iw] = not grid[ih][iw]
end


--[[            -- ... In the main loop, pass the monitor to the functions
while true do
    calcNext()
    setNext()
    printGrid(monitor) -- Pass the monitor here
    sleep(0.1)
end
]]--

-- Main event loop
while true do
    -- Handle events
    local event, side, x, y = os.pullEvent()
    if event == "monitor_touch" and side == "top" then
        handleRightClick(x, y)
    elseif event == "timer" then -- You can use a timer event to update the grid
        calcNext()
        setNext()
        printGrid(monitor)
        sleep(0.1)
    end
end