(import-macros {: gh : with-safely : | : =>} :lib.macro)
(local {: defgroup : maplead} (require :lib.map))
(local {: packadd} (require :lib.nvim))

(with-safely :now
  (packadd (gh :eraserhd/parinfer-rust) (gh :lewis6991/gitsigns.nvim)))

;;;
;;; neogit
;;;

(with-safely :later
  (packadd (gh :dlyongemallo/diffview-plus.nvim) (gh :NeogitOrg/neogit))
  (let [opts {:disable_hint true}]
    (=> (require :neogit) (setup opts)))
  (defgroup "<Leader>g" "git")
  (maplead "gg" "<cmd>Neogit<cr>" {:desc "open neogit tab"})
  (maplead "gl" "<cmd>Neogit log<cr>" {:desc "view log"})
  (maplead "gp" "<cmd>Neogit pull<cr>" {:desc "pull"})
  (maplead "gP" "<cmd>Neogit push<cr>" {:desc "push"}))

;;;
;;; blink
;;;

(with-safely [:on-event [:InsertEnter :CmdLineEnter]]
  (packadd (gh :xzbdmw/colorful-menu.nvim)
           {:src (gh :saghen/blink.cmp) :version "v1"})
  (let [signature {:enabled true}
        appearance {:nerd_font_variant :normal}
        menu-draw (let [col-menu (require :colorful-menu)
                        icons (require :mini.icons)
                        label-text #(col-menu.blink_components_text $)
                        label-hl #(col-menu.blink_components_highlight $)
                        icon-text #(.. " " (icons.get :lsp $.kind) $.icon_gap)]
                    {:columns [(| :kind_icon) (| :label {:gap 1})]
                     :padding 0
                     :components {:label {:text label-text :highlight label-hl}
                                  :kind_icon {:text icon-text}}})
        completion {:documentation {:auto_show true}
                    :ghost_text {:enabled false}
                    :list {:selection {:preselect false :auto_insert true}}
                    :menu {:draw menu-draw}}
        sources {:default [:snippets :lsp :buffer]}
        keymap (let [tabout #(vim.api.nvim_feedkeys (vim.keycode $) :i false)]
                 {:preset :none
                  "<cr>" [:select_and_accept :fallback]
                  "<c-b>" [:scroll_documentation_up :fallback]
                  "<c-f>" [:scroll_documentation_down :fallback]
                  "<c-e>" [:cancel :fallback]
                  "<tab>" [#(if ($.is_visible) ($.select_next)
                                ($.snippet_active) ($.accept))
                           #(tabout "<plug>(neotab-out)")]
                  "<s-tab>" [#(if ($.is_visible) ($.select_prev)
                                  ($.snippet_active) ($.snippet_backward))
                             #(tabout "<plug>(neotab-reverse)")]})
        cmdline {:completion {:menu {:auto_show true}
                              :list {:selection {:preselect false
                                                 :auto_insert true}}}
                 :keymap {:<cr> [:accept_and_enter :fallback]}}
        opts {: signature
              : appearance
              : completion
              : sources
              : keymap
              : cmdline}]
    (=> (require :blink.cmp) (setup opts))))

;;;
;;; conform
;;;

;; NOTE: fnlfmt sometimes produces really stupid formatting
;; so the manual formatter call is prefered
(with-safely :later
  (packadd (gh :stevearc/conform.nvim))
  (let [ignored-fts [:fennel]
        ignored-ft? (partial vim.tbl_contains ignored-fts)
        fmt (fn [bufnr]
              (when (not (ignored-ft? (. vim.bo bufnr :filetype)))
                {:timeout_ms 500}))
        opts {:formatters_by_ft {:fennel ["fnlfmt"]}
              :default_format_opts {:lsp_format :fallback}
              :format_on_save fmt}
        conform (require :conform)]
    (conform.setup opts)
    (set vim.o.formatexpr "v:lua.require'conform'.formatexpr()")
    (maplead "cf" #(conform.format {:async true})
               {:desc "format current buffer"})))

;;;
;;; lightbulb
;;;

(with-safely :now
  (packadd (gh :kosayoda/nvim-lightbulb))
  (let [opts {:autocmd {:enabled true :updatetime -1}
              :code_lenses true
              :sign {:enabled false}
              :virtual_text {:enabled true :text "󰌵" :lens_text ""}}]
    (=> (require :nvim-lightbulb) (setup opts))))

;;;
;;; colorizer
;;;

(with-safely :later
  (packadd (gh :catgoose/nvim-colorizer.lua))
  (let [opts {:options {:parsers {:names {:enable false}
                                  :hex {:no_hash true}}
                        :display {:mode :virtualtext
                                  :virtualtext {:position :before}}}}]
    (=> (require :colorizer) (setup opts))))
