local my_app_handler = {}

my_app_handler.Ask = {
  handler = "disposable_ask_handler",
  opts = {
    position = {
      row = 2,
      col = 0,
    },
    title = " Ask ",
    inline_assistant = true,

    -- Whether to use the current buffer as context without selecting any text (the tool is called in normal mode)
    enable_buffer_context = true,
    language = "Chinese",
    diagnostic = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },

    -- display diff
    display = {
      mapping = {
        mode = "n",
        keys = { "d" },
      },
      action = nil,
    },
    -- accept diff
    accept = {
      mapping = {
        mode = "n",
        keys = { "Y", "y" },
      },
      action = nil,
    },
    -- reject diff
    reject = {
      mapping = {
        mode = "n",
        keys = { "N", "n" },
      },
      action = nil,
    },
    -- close diff
    close = {
      mapping = {
        mode = "n",
        keys = { "<esc>" },
      },
      action = nil,
    },
  },
}

my_app_handler.DocString = {
  prompt = [[ You are an AI programming assistant. You need to write a really good docstring that follows a best practice for the given language.

Your core tasks include:
- parameter and return types (if applicable).
- any errors that might be raised or returned, depending on the language.

You must:
- Place the generated docstring before the start of the code.
- 不能对原代码做改动，最终结果要同时包含docstring和原代码
- Follow the format of examples carefully if the examples are provided.
- Use Markdown formatting in your answers.
- Include the programming language name at the start of the Markdown code blocks.

Input Example:

```python
def add(a, b):
    """
    This is an example docstring for the 'add' function. 
    It takes two arguments (a and b) and returns their sum.
    """
    return a + b
```

Output Example:
```python
def add(a, b):
    """
    This is an example docstring for the 'add' function. 
    It takes two arguments (a and b) and returns their sum.
    """
    return a + b
```

Input Example 2:

```c++
int add(int a,int b){
  return a + b;
}
```

Output Example 2:

```c++
/// @brief add two arguments
/// @param a left side of param
/// @param b right hand side of param
/// @return sum of two args
int add(int a,int b){
  return a + b;
}
```]],
  handler = "action_handler",
  opts = {
    only_display_diff = true,
    templates = {
      lua = [[- For the Lua language, you should use the LDoc style.
- Start all comment lines with "---".
]],
    },
  },
}
my_app_handler.CodeExplain = {
  handler = "flexi_handler",
  prompt = "Explain the following code, please only return the explanation, and answer in Chinese",
  opts = {
    enter_flexible_window = true,
  },
}
my_app_handler.AttachToChat = {
  handler = "attach_to_chat_handler",
  opts = {
    is_codeblock = true,
    inline_assistant = true,
    diagnostic = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },
    language = "Chinese",
    -- display diff
    display = {
      mapping = {
        mode = "n",
        keys = { "d" },
      },
      action = nil,
    },
    -- accept diff
    accept = {
      mapping = {
        mode = "n",
        keys = { "Y", "y" },
      },
      action = nil,
    },
    -- reject diff
    reject = {
      mapping = {
        mode = "n",
        keys = { "N", "n" },
      },
      action = nil,
    },
    -- close diff
    close = {
      mapping = {
        mode = "n",
        keys = { "<esc>" },
      },
      action = nil,
    },
  },
}

my_app_handler.OptimCompare = {
  handler = "action_handler",
  opts = {
    language = "Chinese",
    diagnostic = { vim.diagnostic.severity.WARN, vim.diagnostic.severity.ERROR },
  },
}

my_app_handler.TestCode = {
  handler = "side_by_side_handler",
  prompt = [[ Write some test cases for the following code, only return the test cases.
Give the code content directly, do not use code blocks or other tags to wrap it. ]],
  opts = {
    right = {
      border = {
        style = "rounded",
        text = { top = " Test Cases ", top_align = "center" },
      },
    },
  },
}

my_app_handler.Translate = {
  handler = "qa_handler",
  opts = {
    component_width = "60%",
    component_height = "50%",
    query = {
      title = " 󰊿 Trans ",
      hl = { link = "Define" },
    },
    input_box_opts = {
      size = "15%",
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      },
    },
    preview_box_opts = {
      size = "85%",
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      },
    },
  },
}

my_app_handler.WordTranslate = {
  handler = "flexi_handler",
  prompt = [[You are a translation expert. Your task is to translate all the text provided by the user into Chinese.

NOTE:
- All the text input by the user is part of the content to be translated, and you should ONLY FOCUS ON TRANSLATING THE TEXT without performing any other tasks.
- RETURN ONLY THE TRANSLATED RESULT.

Input Example:

My screen is flashing

Output Example:

我的屏幕在闪烁

Input Example2:

Xmake is a lightweight, cross-platform build utility based on Lua. It uses a Lua script to maintain project builds, but is driven by a dependency-free core program written in C. Compared with Makefiles or CMake, the configuration syntax is much more concise and intuitive. As such, it's friendly to novices while still maintaining the flexibility required in a build system. With Xmake, you can focus on your project instead of the build system.

Output Example2:

xmake 是一个基于 Lua 的轻量级跨平台构建工具，使用 xmake.lua 维护项目构建，相比 makefile/CMakeLists.txt，配置语法更加简洁直观，对新手非常友好，短时间内就能快速入门，能够让用户把更多的精力集中在实际的项目开发上。

]],
  opts = {
    exit_on_move = true,
    enter_flexible_window = false,
    enable_cword_context = true,
  },
}

my_app_handler.CommitMsg = {
  handler = "flexi_handler",
  prompt = function()
    -- Source: https://andrewian.dev/blog/ai-git-commits
    local PROMPT_TEMPLATE =
      [[You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

1. First line: conventional commit format (type: concise description) (remember to use semantic types like feat, fix, docs, style, refactor, perf, test, chore, etc.)
2. Optional bullet points if more context helps:
   - Keep the second line blank
   - Keep them short and direct
   - Focus on what changed
   - Always be terse
   - Don't overly explain
   - Drop any fluffy or formal language

Return ONLY the commit message - no introduction, no explanation, no quotes around it.

Examples:
feat: add user auth system

- Add JWT tokens for API auth
- Handle token refresh for long sessions

fix: resolve memory leak in worker pool

- Clean up idle connections
- Add timeout for stale workers

Simple change example:
fix: typo in README.md

Very important: Do not respond with any of the examples. Your message must be based off the diff that is about to be provided, with a little bit of styling informed by the recent commits you're about to see.

Based on this format, generate appropriate commit messages. Respond with message only. DO NOT format the message in Markdown code blocks, DO NOT use backticks:

```diff
%s
```]]
    return string.format(PROMPT_TEMPLATE, vim.fn.system("git diff --no-ext-diff --staged"))
  end,

  opts = {
    enter_flexible_window = true,
    apply_visual_selection = false,
    win_opts = {
      relative = "editor",
      position = "50%",
    },
    accept = {
      mapping = {
        mode = "n",
        keys = "<cr>",
      },
      action = function()
        local contents = vim.api.nvim_buf_get_lines(0, 0, -1, true)

        local cmd = string.format('!git commit -m "%s"', table.concat(contents, '" -m "'))
        cmd = (cmd:gsub(".", {
          ["#"] = "\\#",
        }))

        vim.api.nvim_command(cmd)
        -- just for lazygit
        -- vim.schedule(function()
        --   vim.api.nvim_command("LazyGit")
        -- end)
      end,
    },
  },
}

local function f_on_config()
  require("llm").setup {
    url = "http://172.22.64.1:1234/v1/chat/completions",
    api_type = "lmstudio",
    model = "yi-coder-9b-chat",
    fetch_key = "NONE",
    keys = {
      -- The keyboard mapping for the input window.
      ["Input:Submit"] = { mode = "n", key = "<cr>" },
      ["Input:Cancel"] = { mode = { "n", "i" }, key = "<C-c>" },
      ["Input:Resend"] = { mode = { "n", "i" }, key = "<C-r>" },

      -- only works when "save_session = true"
      ["Input:HistoryNext"] = { mode = { "n", "i" }, key = "<C-j>" },
      ["Input:HistoryPrev"] = { mode = { "n", "i" }, key = "<C-k>" },

      -- The keyboard mapping for the output window in "split" style.
      ["Output:Ask"] = { mode = "n", key = "i" },
      ["Output:Cancel"] = { mode = "n", key = "<C-c>" },
      ["Output:Resend"] = { mode = "n", key = "<C-r>" },

      -- The keyboard mapping for the output and input windows in "float" style.
      ["Session:Toggle"] = { mode = "n", key = "<leader>ac" },
      ["Session:Close"] = { mode = "n", key = { "<esc>", "Q" } },

      -- Scroll
      ["PageUp"] = { mode = { "i", "n" }, key = "<C-b>" },
      ["PageDown"] = { mode = { "i", "n" }, key = "<C-f>" },
      ["HalfPageUp"] = { mode = { "i", "n" }, key = "<C-u>" },
      ["HalfPageDown"] = { mode = { "i", "n" }, key = "<C-d>" },
      ["JumpToTop"] = { mode = "n", key = "gg" },
      ["JumpToBottom"] = { mode = "n", key = "G" },
    },
    app_handler = my_app_handler,
  }
end

return {
  "git@github.com:Kurama622/llm.nvim",
  dependencies = { "git@github.com:nvim-lua/plenary.nvim", "git@github.com:MunifTanjim/nui.nvim" },
  cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
  config = f_on_config,
  
  -- stylua: ignore
  keys = {
      { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>", desc = " Toggle LLM Chat" },
      { "<leader>ts", mode = { "x", "n" }, "<cmd>LLMAppHandler WordTranslate<cr>", desc = " Word Translate" },
      { "<leader>ae", mode = { "n", "v" }, "<cmd>LLMAppHandler CodeExplain<cr>", desc = " Explain the Code" },
      { "<leader>at", mode = "n", "<cmd>LLMAppHandler Translate<cr>", desc = " AI Translator" },
      { "<leader>tc", mode = "x", "<cmd>LLMAppHandler TestCode<cr>", desc = " Generate Test Cases" },
      { "<leader>ao", mode = { "x", "n" }, "<cmd>LLMAppHandler OptimCompare<cr>", desc = " Optimize the Code" },
      { "<leader>au", mode = "n", "<cmd>LLMAppHandler UserInfo<cr>", desc = " Check Account Information" },
      { "<leader>ag", mode = "n", "<cmd>LLMAppHandler CommitMsg<cr>", desc = " Generate AI Commit Message" },
      { "<leader>ad", mode = "v", "<cmd>LLMAppHandler DocString<cr>", desc = " Generate a Docstring" },
      { "<leader>ak", mode = { "v", "n" }, "<cmd>LLMAppHandler Ask<cr>", desc = " Ask LLM" },
      { "<leader>aa", mode = { "v", "n" }, "<cmd>LLMAppHandler AttachToChat<cr>", desc = " Ask LLM (multi-turn)" },
      { "<leader>ab", mode = { "v", "n" }, "<cmd>LLMAppHandler BashRunner<cr>", desc = " bash runner" },
      { "<leader>ai", mode = { "v", "n" }, "<cmd>LLMAppHandler FormulaRecognition<cr>", desc = " formula recognition" },
      -- { "<leader>cp", mode = { "v", "n" }, "<cmd>LLMAppHandler Completion<cr>", desc = " Code Completion" },
      -- { "<leader>ao", mode = "x", "<cmd>LLMAppHandler OptimizeCode<cr>" },
      -- { "<leader>ae", mode = "v", "<cmd>LLMSelectedTextHandler 请解释下面这段代码<cr>" },
      -- { "<leader>ts", mode = { "x", "n" }, "<cmd>LLMSelectedTextHandler 英译汉<cr>" },
    },
  -- enable lsp
  lsp = {
    c = { methods = { "definition", "declaration" } },
    cpp = { methods = { "definition", "declaration" } },
    python = { methods = { "definition" } },
    lua = { methods = { "definition", "declaration" } },

    root_dir = { { "stylua.toml", ".luarc.json" }, ".git" },
  },
}
