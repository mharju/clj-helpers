local _0_0 = nil
do
  local name_0_ = "clj-helpers.main"
  local module_0_ = nil
  do
    local x_0_ = package.loaded[name_0_]
    if ("table" == type(x_0_)) then
      module_0_ = x_0_
    else
      module_0_ = {}
    end
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = ((module_0_)["aniseed/locals"] or {})
  module_0_["aniseed/local-fns"] = ((module_0_)["aniseed/local-fns"] or {})
  package.loaded[name_0_] = module_0_
  _0_0 = module_0_
end
local function _1_(...)
  local ok_3f_0_, val_0_ = nil, nil
  local function _1_()
    return {require("aniseed.core"), require("conjure.bridge"), require("conjure.eval"), require("conjure.extract"), require("aniseed.deps.fennel"), require("conjure.mapping"), require("aniseed.nvim"), require("aniseed.string"), require("aniseed.nvim.util")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {a = "aniseed.core", bridge = "conjure.bridge", ce = "conjure.eval", extract = "conjure.extract", fennel = "aniseed.deps.fennel", mapping = "conjure.mapping", nvim = "aniseed.nvim", str = "aniseed.string", util = "aniseed.nvim.util"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local bridge = _local_0_[2]
local ce = _local_0_[3]
local extract = _local_0_[4]
local fennel = _local_0_[5]
local mapping = _local_0_[6]
local nvim = _local_0_[7]
local str = _local_0_[8]
local util = _local_0_[9]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "clj-helpers.main"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local init = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function init0()
      nvim.ex.augroup("clj_helpers")
      nvim.ex.autocmd_()
      nvim.ex.autocmd("FileType", "clojure", bridge["viml->lua"]("clj-helpers.main", "mappings", {}))
      return nvim.ex.augroup("END")
    end
    v_0_0 = init0
    _0_0["init"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["init"] = v_0_
  init = v_0_
end
local mappings = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function mappings0()
      return mapping.buf("n", nil, "js", "clj-helpers.main", "jump-to-current-kw-symbol")
    end
    v_0_0 = mappings0
    _0_0["mappings"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["mappings"] = v_0_
  mappings = v_0_
end
local is_ns_keyword_3f = nil
do
  local v_0_ = nil
  local function is_ns_keyword_3f0(content)
    return not a["nil?"](string.find(content, "^:[:%w][%w%.%-]*/"))
  end
  v_0_ = is_ns_keyword_3f0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["is-ns-keyword?"] = v_0_
  is_ns_keyword_3f = v_0_
end
local split_ns_keyword = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function split_ns_keyword0(ns_kw)
      local _let_0_ = str.split(ns_kw, "/")
      local ns = _let_0_[1]
      local kw = _let_0_[2]
      local kw_with_local_prefix = ("::" .. kw)
      return {keyword = kw_with_local_prefix, ns = string.sub(ns, 2)}
    end
    v_0_0 = split_ns_keyword0
    _0_0["split-ns-keyword"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["split-ns-keyword"] = v_0_
  split_ns_keyword = v_0_
end
local resolve_ns_alias = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function resolve_ns_alias0(ns)
      util.normal(("mggg/:as " .. ns .. "\\<cr>T["))
      local _let_0_ = extract.word()
      local content = _let_0_["content"]
      util.normal("'g")
      return content
    end
    v_0_0 = resolve_ns_alias0
    _0_0["resolve-ns-alias"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["resolve-ns-alias"] = v_0_
  resolve_ns_alias = v_0_
end
local resolve_namespace = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function resolve_namespace0(ns_kw)
      if is_ns_keyword_3f(ns_kw) then
        local _let_0_ = split_ns_keyword(ns_kw)
        local keyword = _let_0_["keyword"]
        local ns = _let_0_["ns"]
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
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["resolve-namespace"] = v_0_
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
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["src-path"] = v_0_
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
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["ns->filename"] = v_0_
  ns__3efilename = v_0_
end
local jump_to_kw_symbol = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function jump_to_kw_symbol0(symbol)
      local _let_0_ = resolve_namespace(symbol)
      local keyword = _let_0_["keyword"]
      local resolved_ns = _let_0_["resolved-ns"]
      if (resolved_ns and keyword) then
        nvim.ex.edit_(ns__3efilename(resolved_ns))
        return nvim.fn.search(keyword)
      end
    end
    v_0_0 = jump_to_kw_symbol0
    _0_0["jump-to-kw-symbol"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["jump-to-kw-symbol"] = v_0_
  jump_to_kw_symbol = v_0_
end
local jump_to_current_kw_symbol = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function jump_to_current_kw_symbol0()
      local _let_0_ = extract.word()
      local content = _let_0_["content"]
      if not a["empty?"](content) then
        return jump_to_kw_symbol(content)
      end
    end
    v_0_0 = jump_to_current_kw_symbol0
    _0_0["jump-to-current-kw-symbol"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["jump-to-current-kw-symbol"] = v_0_
  jump_to_current_kw_symbol = v_0_
end
return nil