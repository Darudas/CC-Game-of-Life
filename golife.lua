-- Wrap the monitor above the computer
monitor = peripheral.wrap("top")

-- Make sure to check if the monitor is connected
if not monitor then
  error("No monitor found on top")
end


w = 41
h = 33

grid = {}
for ih = 1, h do
    grid[ih] = {}
    for iw = 1, w do
		rand = math.random(0, 99)
		if(rand < 10)
			then grid[ih][iw] = true
			else grid[ih][iw] = false
		end
    end
end
gridNext = {}
for ih = 1, h do
    gridNext[ih] = {}
    for iw = 1, w do
        gridNext[ih][iw] = false
    end
end

function printGrid()
    monitor.clear()
    for ih = 1, h do
        for iw = 1, w do
            monitor.setCursorPos(iw, ih) -- Set cursor for each cell
            if grid[ih][iw] then
                monitor.setTextColor(colors.lime)
                monitor.write("@")
			else
			
			monitor.setTextColor(colors.black)
                	monitor.write(" ")
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


while(true) do
	calcNext()
	setNext()
	printGrid()
	sleep(0.1)
end
