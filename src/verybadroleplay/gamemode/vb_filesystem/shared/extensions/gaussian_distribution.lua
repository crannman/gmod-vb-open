local sqrt = math.sqrt
local log = math.log
local pi = math.pi
local random = math.random
local pow = math.pow
local cos = math.cos
local ipairs = ipairs

function Gaussian(mean, variance)
  return sqrt(-2 * variance * log(random())) * cos(2 * pi * random()) + mean
end
function Mean(num)
  local sum = 0
  for k, v in ipairs(num) do
    sum = sum + v 
  end
  return sum / #num
end

function StandardDeviation(num)
  local squares, avg = 0, Mean(num)

  for k, v in ipairs(num) do
    squares = squares + pow((avg - v), 2)
  end

  local variance = squares / #num
  return sqrt(variance)
end

function ShowHistogram(t)
  local lo = math.ceil(math.min(unpack(t)))
  local hi = math.floor(math.max(unpack(t)))
  local hist, barScale = {}, 200
  for i = lo, hi do
    hist[i] = 0
    for k, v in pairs(t) do
      if math.ceil(v - 0.5) == i then
        hist[i] = hist[i] + 1
      end
    end
    print(i .. "\t" .. string.rep('=', hist[i] / #t * barScale) .. " " .. hist[i])
  end
end

function TestHist()
  randomseed(os.time())
  local t, average, variance = {}, 50, 10
  for i = 1, 1000 do
    table.insert(t, Gaussian(average, variance))
  end 
  print("Mean:", Mean(t) .. ", expected " .. average)
  print("StandardDeviation:", StandardDeviation(t) .. ", expected " .. sqrt(variance) .. "\n")
  ShowHistogram(t)
end