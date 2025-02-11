local utils = {}

---Randomly selects an element from a table.
---@generic T
---@param t T[] # The table containing elements of type T.
---@return T | nil # Returns a random element of type T, or nil if the table is empty.
utils.getRandomInTable = function (t)
  if type(t) ~= "table" then return nil end
  if #t == 0 then return nil end
  return t[math.random(1, #t)]
end

---Returns a table containing the keys of a table.
---@param t table # The table to get the keys from.
---@return any[] # Returns a table containing the keys of the input table.
utils.getTableKeys = function (t)
  local keys = {}
  for key, _ in pairs(t) do
    table.insert(keys, key)
  end
  return keys
end

---Retourne la longueur d'une table (incluant les clés non numériques)
---@param t table # La table dont on veut connaître la longueur
---@return number # Le nombre d'éléments dans la table
utils.tableLength = function (t)
  local count = 0
  for _ in pairs(t) do
    count = count + 1
  end
  return count
end

return utils
