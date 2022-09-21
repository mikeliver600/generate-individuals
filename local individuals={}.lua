local individuals={}
for i=1,10 do
  local result=tostring(math.random(0,1))
  for _=1,7 do result=result..tostring(math.random(0,1)) end
  table.insert(individuals,result)
end
local done=false
local TARGET="1"
local count=0
local maxFit=0
local function fitness(x)
  local _,fit=tostring(x):gsub(TARGET,TARGET)
  return fit
end
local function updateMaxFit()
  for k,v in pairs(individuals) do
    if fitness(v)>maxFit then maxFit=fitness(v) end
  end
  return maxFit
end
local function selectParent()
  local possibleParents={}
  updateMaxFit()
  for k,v in pairs(individuals) do
    if fitness(v)>=maxFit/2 then table.insert(possibleParents,v) end 
  end
  return possibleParents[math.random(#possibleParents)]
end
local function mut(y)
 local shuffle=math.random(1,3)
 if shuffle==1 then
  y=y:sub(1,math.random(1,3))..y:sub(5,math.random(5,8))
 elseif shuffle==2 then
  y=y:sub(5,math.random(5,8))..y:sub(1,math.random(1,3))
 else
  y=y:sub(4,math.random(4,8))..y:sub(1,math.random(1,1))
 end
  if #y<8 then for i=#y,8 do y=y..tostring(math.random(0,1)) end end
  return y:sub(1,8)
end
repeat
count=count+1
print("getting parents")
par1,par2=tostring(selectParent()),tostring(selectParent())
print("reproducing from "..par1.." and "..par2)
local offspring=par1:sub(1,4)..par2:sub(5,8)
print("Operation success\n new individualslua "..offspring)
offspring=mut(offspring)
print("function finished  "..offspring)
local lastV=0
for k,v in pairs(individuals) do
    if fitness(v)<fitness(offspring) then print(offspring.." replaced "..v) individuals[k]=offspring end
    lastV=v
end
until updateMaxFit()==8
print("Perfection reached\n after "..count.." generations.")