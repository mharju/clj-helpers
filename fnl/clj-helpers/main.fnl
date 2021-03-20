(module clj-helpers.main
  {require {a aniseed.core
            str aniseed.string
            ce conjure.eval
            extract conjure.extract
            mapping conjure.mapping
            nvim aniseed.nvim
            util aniseed.nvim.util
            bridge conjure.bridge
            fennel aniseed.deps.fennel}})

(defn init []
  (nvim.ex.augroup :clj_helpers)
  (nvim.ex.autocmd_)
  (nvim.ex.autocmd :FileType "clojure"
    (bridge.viml->lua :clj-helpers.main :mappings {}))
  (nvim.ex.augroup :END))

(defn mappings []
  (mapping.buf :n nil "js" :clj-helpers.main :jump-to-current-kw-symbol))

(defn- is-ns-keyword? [content]
  (not (a.nil? (string.find content "^:[:%w][%w%.%-]*/"))))

(defn split-ns-keyword [ns-kw]
  (let [[ns kw] (str.split ns-kw "/")
        kw-with-local-prefix (.. "::" kw)]
    {:ns (string.sub ns 2) :keyword kw-with-local-prefix}))

(defn resolve-ns-alias [ns]
  (util.normal (.. "mggg/:as " ns "\\<cr>T["))
  (let [{: content } (extract.word)]
    (util.normal "'g")
    content))

(defn resolve-namespace [ns-kw]
  (when (is-ns-keyword? ns-kw)
    (let [{: ns : keyword } (split-ns-keyword ns-kw)]
      (if (= (string.sub ns 1 1) ":")
        {:resolved-ns (resolve-ns-alias (string.sub ns 2)) :keyword keyword}
        {:resolved-ns ns :keyword keyword}))))

(defn src-path []
  (nvim.fn.finddir "src" ".;"))

(defn ns->filename [ns]
  (.. (src-path)
      "/"
      (-> ns 
          (string.gsub "[.]" "/")
          (string.gsub "[%-]" "_"))
      ".cljs"))

(defn jump-to-kw-symbol [symbol]
  (let [{: resolved-ns : keyword} (resolve-namespace symbol)]
    (when (and resolved-ns keyword)
      (nvim.ex.edit_ (ns->filename resolved-ns))
      (nvim.fn.search keyword))))

(defn jump-to-current-kw-symbol []
  (let [{: content} (extract.word)]
    (when (not (a.empty? content))
      (jump-to-kw-symbol content))))
