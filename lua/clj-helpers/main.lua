local _0_0 = nil
do
  local name_0_ = "clj-helpers.main"
  local loaded_0_ = package.loaded[name_0_]
  local module_0_ = nil
  if ("table" == type(loaded_0_)) then
    module_0_ = loaded_0_
  else
    module_0_ = {}
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = (module_0_["aniseed/locals"] or {})
  module_0_["aniseed/local-fns"] = (module_0_["aniseed/local-fns"] or {})
  package.loaded[name_0_] = module_0_
  _0_0 = module_0_
end
local function _1_(...)
  _0_0["aniseed/local-fns"] = {require = {a = "aniseed.core", ce = "conjure.eval", extract = "conjure.extract", fennel = "aniseed.deps.fennel", mapping = "conjure.mapping", nvim = "aniseed.nvim", str = "aniseed.string", util = "aniseed.nvim.util"}}
  return {require("aniseed.core"), require("conjure.eval"), require("conjure.extract"), require("aniseed.deps.fennel"), require("conjure.mapping"), require("aniseed.nvim"), require("aniseed.string"), require("aniseed.nvim.util")}
end
local _2_ = _1_(...)
local a = _2_[1]
local ce = _2_[2]
local extract = _2_[3]
local fennel = _2_[4]
local mapping = _2_[5]
local nvim = _2_[6]
local str = _2_[7]
local util = _2_[8]
do local _ = ({nil, _0_0, {{}, nil}})[2] end
local init = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function init0()
    end
    v_0_0 = init0
    _0_0["init"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["init"] = v_0_
  init = v_0_
end
local is_ns_keyword_3f = nil
do
  local v_0_ = nil
  local function is_ns_keyword_3f0(content)
    return not a["nil?"](string.find(content, "^:[:%w][%w%.%-]*/"))
  end
  v_0_ = is_ns_keyword_3f0
  _0_0["aniseed/locals"]["is-ns-keyword?"] = v_0_
  is_ns_keyword_3f = v_0_
end
local split_ns_keyword = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function split_ns_keyword0(ns_kw)
      local _3_ = str.split(ns_kw, "/")
      local ns = _3_[1]
      local kw = _3_[2]
      local kw_with_local_prefix = ("::" .. kw)
      return {keyword = kw_with_local_prefix, ns = string.sub(ns, 2)}
    end
    v_0_0 = split_ns_keyword0
    _0_0["split-ns-keyword"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["split-ns-keyword"] = v_0_
  split_ns_keyword = v_0_
end
local resolve_ns_alias = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function resolve_ns_alias0(ns)
      util.normal(("mggg/:as " .. ns .. "\\<cr>T["))
      local _3_ = extract.word()
      local content = _3_["content"]
      util.normal("'g")
      return content
    end
    v_0_0 = resolve_ns_alias0
    _0_0["resolve-ns-alias"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["resolve-ns-alias"] = v_0_
  resolve_ns_alias = v_0_
end
local resolve_namespace = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function resolve_namespace0(ns_kw)
      if is_ns_keyword_3f(ns_kw) then
        local _3_ = split_ns_keyword(ns_kw)
        local keyword = _3_["keyword"]
        local ns = _3_["ns"]
        if (string.sub(ns, 1, 1) == ":") then
          return {["resolved-ns"] = resolve_ns_alias(string.sub(ns, 2)), keyword = keyword}
        else
          return {["resolved-ns"] = ns, keyword = keyword}
        end
      end
    end
    v_0_0 = resolve_namespace0
    _0_0["resolve-namespace"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["resolve-namespace"] = v_0_
  resolve_namespace = v_0_
end
local src_path = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function src_path0()
      return nvim.fn.finddir("src", ".;")
    end
    v_0_0 = src_path0
    _0_0["src-path"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["src-path"] = v_0_
  src_path = v_0_
end
local ns__3efilename = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function ns__3efilename0(ns)
      return (src_path() .. "/" .. string.gsub(string.gsub(ns, "[.]", "/"), "[%-]", "_") .. ".cljs")
    end
    v_0_0 = ns__3efilename0
    _0_0["ns->filename"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["ns->filename"] = v_0_
  ns__3efilename = v_0_
end
local jump_to_kw_symbol = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function jump_to_kw_symbol0(symbol)
      local _3_ = resolve_namespace(symbol)
      local keyword = _3_["keyword"]
      local resolved_ns = _3_["resolved-ns"]
      if (resolved_ns and keyword) then
        nvim.ex.edit_(ns__3efilename(resolved_ns))
        return nvim.fn.search(keyword)
      end
    end
    v_0_0 = jump_to_kw_symbol0
    _0_0["jump-to-kw-symbol"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["jump-to-kw-symbol"] = v_0_
  jump_to_kw_symbol = v_0_
end
local jump_to_current_kw_symbol = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function jump_to_current_kw_symbol0()
      local _3_ = extract.word()
      local content = _3_["content"]
      if not a["empty?"](content) then
        return jump_to_kw_symbol(content)
      end
    end
    v_0_0 = jump_to_current_kw_symbol0
    _0_0["jump-to-current-kw-symbol"] = v_0_0
    v_0_ = v_0_0
  end
  _0_0["aniseed/locals"]["jump-to-current-kw-symbol"] = v_0_
  jump_to_current_kw_symbol = v_0_
end
return mapping.buf("n", "js", "clj-helpers.main", "jump-to-current-kw-symbol")