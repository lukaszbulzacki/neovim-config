vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

require("fzf-lua").setup({
   file_ignore_patterns = {
      "target/",
      "build/",
      "dist/",
      "bin/",
      "obj/",

      ".git/",
   },
   keymap = {
      fzf = {
         ["ctrl-q"] = "select-all+accept",
         ["alt-a"] = "toggle-all",
      },
   },
})
