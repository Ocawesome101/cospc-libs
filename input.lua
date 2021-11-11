-- keyboard/mouse/other input, without stalling --

local lib = {}

function lib.new(delay)
  return {lastTimerID = nil, delay = delay or 0, pressed = {}}
end

function lib.poll(state)
  if not state.lastTimerID then
    state.lastTimerID = os.startTimer(state.delay)
  end
  local sig = table.pack(os.pullEventRaw())
  if sig[1] == "timer" and sig[2] == state.lastTimerID then
    state.lastTimerID = nil
  elseif sig[1] == "key" then
    state.pressed[sig[2]] = true
  elseif sig[1] == "key_up" then
    state.pressed[sig[2]] = false
  end
  return sig
end

return lib
