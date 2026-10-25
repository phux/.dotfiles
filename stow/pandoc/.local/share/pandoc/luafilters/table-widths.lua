-- Size table columns by text length.
-- Pandoc gives every column the same width when a pipe table has a long line
-- and equal dashes in the separator row. Treat equal widths as unset and
-- replace them. Tables with unequal widths (set by the author) stay unchanged.
local MIN, CAP = 6, 60 -- clamp for the text length of a column, in characters

local function len(cell)
  local s = pandoc.utils.stringify(cell.contents)
  return utf8.len(s) or #s
end

local function widths_are_equal(specs)
  local first = specs[1][2]
  if type(first) ~= 'number' or first <= 0 then return false end
  for _, spec in ipairs(specs) do
    if type(spec[2]) ~= 'number' or math.abs(spec[2] - first) > 1e-6 then
      return false
    end
  end
  return true
end

local function add_rows(max, rows)
  for _, row in ipairs(rows) do
    for i, cell in ipairs(row.cells) do
      max[i] = math.max(max[i] or 0, len(cell))
    end
  end
end

function Table(tbl)
  local specs = tbl.colspecs
  if #specs < 2 or not widths_are_equal(specs) then return nil end

  local max = {}
  add_rows(max, tbl.head.rows)
  for _, body in ipairs(tbl.bodies) do add_rows(max, body.body) end
  add_rows(max, tbl.foot.rows)

  local weight, total = {}, 0
  for i = 1, #specs do
    weight[i] = math.min(math.max(max[i] or 0, MIN), CAP)
    total = total + weight[i]
  end

  local new = {}
  for i, spec in ipairs(specs) do new[i] = { spec[1], weight[i] / total } end
  tbl.colspecs = new
  return tbl
end
