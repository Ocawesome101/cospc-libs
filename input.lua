-- keyboard/mouse/other input, without stalling --

local lib = {}

function lib.new()
  return {lastTimerID = nil, pressed = {}}
end

function lib.poll(state)
  if not state.lastTimerID then
    state.lastTimerID = os.startTimer(0)
  end
  local sig = table.pack(os.pullEventRaw())
  if sig[1] == "timer" and id == state.lastTimerID then
    state.lastTimerID = nil
    return false
  elseif sig[1] == "key" then
    state.pressed[sig[2]] = true
    return true
  elseif sig[1] == "key_up" then
    state.pressed[sig[2]] = false
    return true
  else
    return sig
  end
end

return lib
